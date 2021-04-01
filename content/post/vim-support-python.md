---
title: "让 Windows 中的 Vim 支持 Python"
date: 2020-04-08
description: 让 Windows 中的 Vim 支持 Python
tags: [vim]
categories: [vim]
series: []
math: false
draft: false
---


这段时间一直在家，于是又折腾起了 Vim。今天遇到了一个问题，Vim 有很多插件是依赖 Python 的，而我在 Windows 上安装的 Vim 不能正确地调用之前安装的 Anaconda 中的 Python。

要使 Vim 支持 Python，要做到下面三点。

一是 Python 和 Vim 的架构要相同。即必须同时为32位或同时为64位。

二是 Vim 本身要有 Python 支持。在 Normal 模式下，用 `:version` 命令查看 Vim 的编译版本。

![](https://res.cloudinary.com/dny1wymwm/image/upload/v1586341034/k3DYIahdt9_emv1ow.png)

有 `+Python/dyn` 和 `Python3/dyn` 即表示支持。如果显示不支持 Python，就需要重新编译带 Python 支持的版本（Unix/Linux）。我用的是 Windows，如何在 Linux 上编译我就不再细说，网上也有很多相关的文章。如果你也使用的是 Windows，可以在[这里下载](https://tuxproject.de/projects/vim/)已经编译好的、带 Python 支持的、适用于 Windows 的版本。

三是 Vim 的编译时的 Python 版本要和电脑上安装的 Python 版本一致。同样用 `:version` 命令可以查看 Vim 的编译参数，下面红线划出来的部分即表示 Vim 编译的 Python2 版本为 2.7，Python3 版本为 3.8。

![](https://res.cloudinary.com/dny1wymwm/image/upload/v1586341034/ID6fTMOwlp_gkvozf.png)

为保持版本一致，我的本机上的 Python 版本也要是 3.8 版本的。
{{< tips warn>}}
在本文发布时，Anaconda 中的 Python 版本为 3.7，所以要么换用编译版本为 3.7 的 Vim，要么需要在 [Python 官网](https://python.org)中下载 3.8 版本的 Python。
{{< /tips >}}

如果上面几条都满足，并且 Python 的环境变量配置正确，这时再下载和使用一些依赖 Python 的插件，应该就不会有问题了。

可以在 Vim 中直接执行简单的 Python 语句来测试一下。

```python
:py3 print("hello")
```

如果能够正确执行，就大功告成了。



*参考链接*

- [Python support for Vim on Windows](https://www.reddit.com/r/vim/comments/bc8t83/python_support_for_vim_on_windows/)
