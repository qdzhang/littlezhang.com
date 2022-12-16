---
title: "使用 Emacs 自带的 tempo 取代 YASnippet"
date: 2022-12-16
lastmode: 2022-12-16
description: YASnippet 功能很强大，但 Emacs 中自带了多种 template 系统，都可以实现模板补全的功能，或多或少可以替代 YASnippet 的一些功能，这样就能少用一个包了。
tags: [emacs]
categories: [emacs]
series: []
toc: true
math: false
markup: md
draft: false
---

[YASnippet](https://github.com/joaotavora/yasnippet) 拥有强大的功能，也有很好的生态，有各种复杂、丰富的 template 可供使用。但我使用 template 的需求很简单：

1. 插入事先定义好的模板。
2. 可以在输入时对模板中的一些内容作替换。

比如在 markdown 文章前输入 frontmatter 。使用 Emacs 自带的 tempo[^1] 就可以很好地满足这些需求。 Emacs 中还有不止一套模板系统 : ) ，都能达到目标，这篇文章只讲如何使用 tempo 。

使用 tempo 主要有两个步骤：

1. 定义模板（ tempo-template ）。
2. 触发 tempo （调用上一步中定义好的模板）。

## 定义 tempo-template

使用 `tempo-define-template` 来定义一个模板 。这个函数的签名是这样的：

``` elisp
(tempo-define-template NAME ELEMENTS &optional TAG DOCUMENTATION TAGLIST)
```

其中：

- NAME: 这个 template 的名称
- ELEMENT: 这个 template 的内容，也是整个 tempo 中的核心内容
- TAG （可选）：使用 `tempo-complete-tag` 来进行展开时，进行触发的 tag ，类似于 yasnippets
中的名字，用来触发
- DOCUMMENTATION （可选）：说明文档
- TAGLIST （可选）：tag 的归类

举一个例子。定义一个快速插入 bash shebang 的 tempo-template ：

``` elisp
(tempo-define-template
 "shebang-for-bash"     ; 名称
 '("#!/bin/bash")       ; 要插入的内容
 "bash"                 ; 输入 bash ，再使用 `tempo-complete-tag' 插入上面的内容
 "Insert shebang bash") ; 文档
```

## 触发 tempo

定义完 tempo-template 后，有五种方法来触发 tempo 插入其内容。

### 1. `tempo-complete-tag`

此方法最简单，输入定义的 tempo-template 的 tag （如上面例子中的 `bash`）后，`M-x tempo-complete-tag` ，就可以插入 template 中定义的内容了。

### 2. `tempo-template-<name>` 直接调用函数

这种方法与上一种类似，都是 tempo.el 中定义的。在定义完一个 template 后，tempo 会为我们自动生成一个相应的 interactive 函数，名字为 `tempo-template-<name>` ，其中 `<name>` 为 template 中的“名称”，即上面 bash 例子中的 `shebang-for-bash` 。也就是说，在定义了上述 template 后，可以直接调用 `tempo-template-shebang-for-bash` 来插入 template 的内容。

### 3. abbrev-mode

这种方法只使用 tempo 来定义 template ，使用 `abbrev-mode`[^2] 进行补全。这里 tempo 的作用就和 skeleton-mode 类似了。

先设置 abbrev table 。给上一种方法中自动生成的 tempo 函数设置一个 abbrev ：

```elisp
(define-abbrev sh-mode-abbrev-table "shebang" "" 'tempo-template-shebang-for-bash)
```

开启 `abbrev-mode` ，输入 `shebang` 后按空格，abbrev-mode 会为我们调用 `tempo-template-shebang-for-bash` ，即补全 tempo-template 中的内容。

### 4. hippie-expand

`hippie-expand`[^3] 可以展开（ expand ）当前光标前的文本，它会尝试多种不同后端，比如将文本展开为 abbrev 、dabbrev 、file-name 等等。我们可以自定义一个 try 函数，加入到 `hippie-expand-try-functions-list` 列表中，让 `hippie-expand` 尝试我们自定的展开函数。

定义一个展开 tempo 的函数：

```elisp
(defun try-tempo-complete-tag (old)
  (unless old
    (tempo-complete-tag)))
```

插入到 `hippie-expand-try-functions-list` 最前面，以使 `hippie-expand` 进行展开时会优先尝试 tempo 。

``` elisp
(add-to-list 'hippie-expand-try-functions-list 'try-tempo-complete-tag)
```

设置 `hippie-expand` 的快捷键，比如我设置的是 <kbd>M-/</kbd>。输入 tempo tag （即前面例子中的 bash）后，直接调用 `hippe-expand` ，即可补全。

### 5.  company-tempo

Company 中也有 tempo 的后端。如果要使 company 使用 `company-tempo` 后端进行补全，需要设置下面的变量，以使 tempo 展开：

``` elisp
(setq company-tempo-expand t)
```

之后调用 `company-tempo` 即可补全 template 。因为 `company-tempo` 在 company 所有后端里比较靠后（甚至没在默认的 `company-backends` 里），需要我们自行把 `company-tempo` 添加到 `company-backends` 中，并把它的优先级提高，才能使用快捷键正确补全。


至此，如何使用 tempo 进行模板补全就介绍完了。还可以看看这个[讨论](https://old.reddit.com/r/emacs/comments/wdbk34/emacss_native_templating_and_snippet_fuctionality/)，也是关于 Emacs 自己的 template 系统的。

[^1]: https://github.com/emacs-mirror/emacs/blob/master/lisp/tempo.el

[^2]: https://www.gnu.org/software/emacs/manual/html_node/emacs/Abbrevs.html

[^3]: https://www.gnu.org/software/emacs/manual/html_node/autotype/Hippie-Expand.html
