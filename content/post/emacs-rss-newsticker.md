---
title: "在 Emacs 中使用 Newsticker RSS 阅读器"
date: 2022-01-08
lastmod: 2022-01-15
description: Emacs 里的很多的功能经常有多种的选择，比如邮件客户端，RSS 阅读器等等，elfeed 经常被 emacser 们所讨论。但是其实 Emacs 里已经自带了一个 RSS 阅读器，即 Newsticker 。本文就着重讨论如何配置 Newsticker 。
tags: [emacs]
categories: [emacs]
series: []
toc: false
math: false
markup: md
draft: false
---

提到在 Emacs 里管理、阅读 RSS feed，可能很多人会使用 [Elfeed](https://github.com/skeeto/elfeed) 。其实 Emacs 里面也自带了一个 RSS 阅读器，Newsticker。虽然 Newsticker 很久都没有更新了，但通过一些配置，Newsticker 也可以很好用。

Newsticker 相比 Elfeed 有两个优点：
1. Emacs 自带，不用额外下载，可以满足一些用户的 vanilla 需求（虽然也有很多用户觉得应该把 Newsticker 从 Emacs 中剔除，因为它助长了 Emacs 的“臃肿”）。
2. 可以显示为树状布局，看起来更直观。

![](https://res.cloudinary.com/dny1wymwm/image/upload/v1641649041/2022-01-08_212535_358131644_id7aas.png)

如果上面的两个优点没有打动你，那么使用 Elfeed 可能是更好的选择，更积极的维护，更大的社区，更多的文章，更多的参考资料。当然，不考虑上面的所有，既然 Newsticker 已经自带，何不试试呢？

一些基本的配置：

首先要 require Newsticker ：
```elisp
(require 'newsticker)
```

Newsticker 默认是树状布局（如上面的图），也可以调整为像 Elfeed 类似，所有 feed 内容显示在一个 buffer 里：

```elisp
;;; 默认为 `newsticker-treeview'
(setq newsticker-frontend 'newsticker-plainview)
```

![](https://res.cloudinary.com/dny1wymwm/image/upload/v1642226161/newsticker-plainview_u6g8tv.png)

但是使用 plainview 会比 treeview 更慢，尤其是有大量订阅源时。因此[文档](https://www.gnu.org/software/emacs/manual/html_mono/newsticker.html#Frontends)中建议：

> when you have subscribed to a large amount of feeds you may want to give the Treeview a try.

设置 Newsticker 不在后台自动刷新：
```elisp
(setq newsticker-retrieval-interval 0
      newsticker-ticker-interval 0)
```

Newsticker 会自带一个订阅源，Emacswiki ，可以使用下面的选项删除它：

```elisp
(setq newsticker-url-list-defaults nil)    ;remove default list (i.e. emacswiki)
```


添加 feed ：

```elisp
(setq newsticker-url-list
      '(
        ;; ("title" "URL" other options)
        ;; 这里使用上面的格式，添加 RSS 源
        ("Planet Emacs Life" "https://planet.emacslife.com/atom.xml" nil nil nil)
        ))
```

如果你订阅了很多源，随后可以在 Newsticker 的用户界面里进行分组、归类，Newsticker 会自动在 `.emacs.d` 目录下生成 `newsticker/groups` 文件，直接编辑这个文件，也可以对 feeds 进行分组。

Newsticker 会在每次刷新时自动设置所有的 items 为已读，即使还有一些文章还没有读过。使用下面的选项，使其不自动设置：

```elisp
(setq newsticker-automatically-mark-items-as-old nil)
```

Newsticker 默认使用 Emacs 自带的 `url-retrieve` 来获取 feed 内容，但也可以设置成外部程序，比如 `wget`。我们可以设置成和 Elfeed 一样，使用 `curl` 来获取 feed 内容（虽然下面这个选项名字里有 wget ，其实可以设置任意有重定向下载内容到标准输出功能的外部程序）：

```elisp
(setq newsticker-retrieval-method 'extern)
(setq newsticker-wget-name "curl")
(setq newsticker-wget-arguments '("--disable" "--silent" "--location" "--proxy" "socks5://127.0.0.1:7890"))
```

使用外部程序，我们可以非常方便的设置我们想要的参数，比如上面的，给 `curl` 设置代理。同时，`curl` 等外部命令是异步执行的，不会阻塞 Emacs 本身。

Newsticker 默认使用 eww 里的 shr 引擎来渲染阅读视图，也可以修改 `newsticker-html-renderer` 来改变渲染引擎。不过 shr 已经挺好用了，eww 里能显示的，比如图片之类的，都可以显示。

配合 Emacs 27 引入的 `tab-bar` ，我们还可以定义几个简单的函数，隔离 Newsticker 和我们正在使用的工作区，新建 tab-bar 打开 Newsticker ：

```elisp
;;; 新建一个 tab-bar ，在新的 tab-bar 里打开 Newsticker 的树状视图
(defun my/newsticker-treeview-in-new-tab ()
  (interactive)
  (let (succ)
    (unwind-protect
        (progn
          (tab-bar-new-tab)
          (call-interactively #'newsticker-treeview)
          (tab-bar-rename-tab "newsticker")
          (setq succ t))
      (unless succ
        (tab-bar-close-tab)))))

;;; 退出 Newsticker 时，关闭新建的 tab-bar
(defun my/newsticker-treeview-quit-and-close-tab ()
  (interactive)
  (newsticker-treeview-quit)
  (newsticker-stop)
  (tab-close))
```

更详细的文档请参看 [Emacs 文档](https://www.gnu.org/software/emacs/manual/html_mono/newsticker.html) ，以及我的配置的[全部代码](https://github.com/qdzhang/.emacs.d/blob/f81bb777a636ef08223fde38b4b5c5c32c17940b/init.el#L4420)。

愉快地在 Newsticker 里阅读吧。
