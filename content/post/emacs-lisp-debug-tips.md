---
title: "Emacs debug 小技巧"
date: 2022-12-15
lastmode:
description: Emacs  中自带了很多实用的“小玩意”，方便我们在 Emacs 出现错误时进行 debug 。这里记录几个我常用的方法。
tags: [emacs, elisp, TIL]
categories: [emacs]
series: []
toc: true
math: false
markup: md
draft: false
---

Emacs 可称得上是一个完备的 Lisp 环境，强大的同时附带了很多实用的“小玩意”，方便我们在 Emacs 出现错误时进行 debug 。这里记录几个我常用的方法。更详细的用法，见脚注文档。

## edebug-defun[^1]

我经常用这个命令来单步调试指定的函数。把光标放在想要调试的函数的开括号上，`M-x edebug-defun` ，类比其他编程语言的话，相当于在该函数起始处设断点。之后在调用到该函数时，就会进入 edebug 模式。在 edebug 模式下，三个快捷键最为有用：
- <kbd>SPC</kbd> ：继续单步执行。执行过程中，minibuffer 会显示当前变量的值。
- <kbd>q</kbd> ：退出调试。
- <kbd>?</kbd> ：查看帮助。

## toggle-debug-on-error[^2]

当不知道错误在哪时，`M-x toggle-debug-on-error` 可以设置“当错误发生时进入 Lisp debugger”。Debugger 会展示更多有用的信息，比如错误的语句、堆栈信息等等，方便排错。Debug 完之后，再次执行 `M-x toggle-debug-on-error` ，就可以取消发生错误时进入 debugger 了。

[^1]: https://www.gnu.org/software/emacs/manual/html_node/elisp/Edebug.html

[^2]: https://www.gnu.org/software/emacs/manual/html_node/elisp/Debugger.html
