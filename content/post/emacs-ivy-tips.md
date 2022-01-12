---
title: "Emacs ivy 小技巧"
date: 2022-01-11
lastmod:
description: 一些 Emacs ivy 的小技巧
tags: [emacs]
categories: [emacs]
series: []
toc: true
math: false
markup: md
draft: false
---

现在 [Consult](https://github.com/minad/consult) 、[Vertico](https://github.com/minad/vertico) 之类的轻量级 completion framework ，和 Emacs 28 之后自带的 [icomplete-vertical](https://github.com/oantolin/icomplete-vertical) 似乎成为了 Emacs 中的“潮流”。不过目前我还是更习惯使用 ivy。这里不讨论各种工具的好坏，也不介绍 ivy
如何使用，只是记录下我在 ivy 中还会不经意发现的一些好用的小功能。

下面动图中的例子均在 ivy 的源码中操作。虽然 ivy 、swiper 、counsel 为三个不同的包，不过为了方便起见，这里就不做区分了。

## 逐步缩小搜索范围

有时候我们可能不能一步搜索到位，就需要逐步缩小缩小搜索的范围。在 ivy 中使用 <kbd>Shift-SPC</kbd> 就能在现有的候选中，再次进行搜索。

下面这个例子是在 ivy 的源码中，先搜索 `ivy-read` ，再在上一步的候选中搜索 `defun` 。其中 <kbd>⎵sg</kbd> (<kbd>SPC-sg</kbd>) 是我设置的 `cousel-grep-or-swiper` 的快捷键。

{{< webm poster="https://res.cloudinary.com/dny1wymwm/video/upload/s--7S-WmS3G--/q_5/e_blur:800/v1641882465/ivy-filter-vp9-q56_dp2enb.jpg"   webm="https://res.cloudinary.com/dny1wymwm/video/upload/v1641882465/ivy-filter-vp9-q56_dp2enb.webm" mp4="https://res.cloudinary.com/dny1wymwm/video/upload/s--FS8itiiD--/vc_h264/v1641882465/ivy-filter-vp9-q56_dp2enb.mp4" >}}

## 搜索替换 

借助 ivy ，可以在 narrow  （缩小搜索范围）之后再对其中的文本进行替换。这里介绍两种方法，还有很多的其他的方法，不过这两种方法对我来说已经足够了。

### ivy-occur 

使用 ivy 搜索之后按 <kbd>C-c C-o</kbd> 可以进入 `ivy-occur` buffer ，`ivy-occur` buffer 是只读的，需要借助 wgrep 来把它变为可写的，再进行替换。在 `ivy-occur` buffer 中，<kbd>C-x C-q</kbd> 可以进入 wgrep-mode ，下面的例子中我把 `ivy` 替换成 <kbd>completion</kbd> ，按 <kbd>C-c C-c</kbd> 保存更改。而且不止可以替换，其他任何的编辑操作都是可行的。

{{< webm poster="https://res.cloudinary.com/dny1wymwm/video/upload/s--cWuCHomZ--/q_5/e_blur:800/v1641882467/ivy-occur-wgrep-vp9-q56_envw0s.jpg" webm="https://res.cloudinary.com/dny1wymwm/video/upload/v1641882467/ivy-occur-wgrep-vp9-q56_envw0s.webm" mp4="https://res.cloudinary.com/dny1wymwm/video/upload/s--C7gAdpTB--/vc_h264/v1641882467/ivy-occur-wgrep-vp9-q56_envw0s.mp4" >}}

### M-q 进行 query-replace

搜索过程中按 <kbd>M-q</kbd> 可以直接对当前搜索的词进行替换，使用的是 Emacs 内置的 `query-replace` ，但是能实时显示替换后的词，和 [anzu](https://github.com/emacsorphanage/anzu) 的效果类似。

{{< webm poster="https://res.cloudinary.com/dny1wymwm/video/upload/s--9Rqkupnw--/q_5/e_blur:800/v1641882467/ivy-query-and-replace-vp9-q56_vw6laf.jpg" webm="https://res.cloudinary.com/dny1wymwm/video/upload/v1641882467/ivy-query-and-replace-vp9-q56_vw6laf.webm" mp4="https://res.cloudinary.com/dny1wymwm/video/upload/s--4kAXqut6--/vc_h264/v1641882467/ivy-query-and-replace-vp9-q56_vw6laf.mp4" >}}

## ivy-avy

使用 [ivy-avy](https://github.com/abo-abo/swiper/blob/master/ivy-avy.el) ，用 avy 来跳转搜索结果（avy 的基本用法和设计哲学，可以参看这篇文章 [avy can do anything](https://karthinks.com/software/avy-can-do-anything/)）。ivy-avy 在 melpa 上是一个单独的包，需要单独安装。在 ivy 中使用快捷键 <kbd>C-'</kbd> 可以调出 avy 。

{{< webm poster="https://res.cloudinary.com/dny1wymwm/video/upload/s--U0wWRdaH--/q_5/e_blur:800/v1641882466/ivy-avy-vp9-q56_uhnupq.jpg" webm="https://res.cloudinary.com/dny1wymwm/video/upload/v1641882466/ivy-avy-vp9-q56_uhnupq.webm" mp4="https://res.cloudinary.com/dny1wymwm/video/upload/s--RfWJaOIQ--/vc_h264/v1641882466/ivy-avy-vp9-q56_uhnupq.mp4" >}}

## counsel-rg 添加任意 flag

ivy 通过 counsel 中提供了与 ripgrep 的集成，`counsel-rg` 。我们可以在 Emacs 配置文件中设置 rg 的参数。但是这样设置后是全局生效的，如果我们在使用 `counsel-rg` 时，临时需要添加额外的 flag, 在输入 `--` 之后可以便可添加。如下例（<kbd>⎵si</kbd> (<kbd>SPC-si</kbd>) 是我设置的 `cousel-rg` 的快捷键。），我在 ivy 文件夹中搜索 `defun` ，显示出文件夹下所有文件中的 `defun` 字段，包括 org 文件、texi 文件等等。如果我只想搜索所有 elisp 文件中的 `defun` 字段，在搜索的关键词之后再输入 `--`，之后添加一个 glob 选项 `-g*.el` ，就限定在 elisp 文件中搜索 `defun` 了。其他所有合法的 flag 都可以这样添加。

{{< webm poster="https://res.cloudinary.com/dny1wymwm/video/upload/s--hdpBCz4K--/q_5/e_blur:800/v1641882465/counsel-rg-custom-args-vp9-q56_x9k16i.jpg" webm="https://res.cloudinary.com/dny1wymwm/video/upload/v1641882465/counsel-rg-custom-args-vp9-q56_x9k16i.webm" mp4="https://res.cloudinary.com/dny1wymwm/video/upload/s--rg4RNTnT--/vc_h264/v1641882465/counsel-rg-custom-args-vp9-q56_x9k16i.mp4" >}}
