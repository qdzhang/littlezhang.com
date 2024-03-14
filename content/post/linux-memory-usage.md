---
title: "Linux 下排查内存占用过大的问题"
date: 2024-03-14
lastmode:
description: Linux 中出现内存泄漏的问题，如何通过命令行来查看内存占用，显示占用前五的进程。
tags: [linux]
categories: [linux]
series: []
toc: false
math: false
markup: md
draft: false
---

前几天，我的 Linux 桌面遇到一个内存泄漏的问题：锁定屏幕后，在过一段时间后，无法打开屏幕，可以看到屏幕亮了，但是 xscreensaver 无法运行，甚至不能使用 `Ctrl+Alt+F2` 进入其他的 tty 来排查问题。

不过幸运的是，有一次成功进入 tty2 ，得以看看问题出在哪 。

运行下面的命令能输出内存占用前五的进程。

``` bash
ps aux | sort -k4nr | head -5
``` 


分解上面的命令来看：

``` bash
ps aux
```

使用 BSD 格式输入每一个进程。

``` bash
sort -k4nr
```
使用 `sort` 来对上面输出的每一个进程排序，排序的依据需要我们指定参数：

`-k` 参数（key）指定进行排序的 key ，这里指定 `4` ，选取 `ps aux` 的第四列作为 key ，即内存占用；

`-n` 参数（numeric-sort）指定根据数字大小来排序；

`-r` 参数（reverse）指定倒序排序，因为我们接下来要使用 `head` 来输入内存占用最大的五个进程，所以这里用倒序。如果我们接下来用 `tail` 来输入最末的五个，则不需要使用 reverse 参数。

``` bash
head -5
```

输出内存占用最大的五个进程。

运行后发现，是 picom 几乎把内存占满了，而且奇怪的是，我的 picom 运行时加了 `--xrender-sync --xrender-sync-fence` 的参数，还是我在 icewm 的自启动中设置的，而我都忘了为什么加这两个参数，可能是从网上复制来的，而之前我在 i3 下都是没有用额外的参数的，直接使用配置文件启动 picom 。

果然，去除这两个参数之后，再也没有出现内存泄漏的情况了。看来各种配置还是要自己完全弄懂才好。包括我这篇文章中的命令。
