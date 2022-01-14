---
title: "Arch Linux 安装 NVIDIA 专有驱动"
date: 2021-09-09
lastmod:
description: Arch Linux 安装 NVIDIA 专有驱动
tags: [linux]
categories: [linux]
series: []
toc: false
math: false
markup: md
draft: false
---

之前[安装 Arch Linux]({{< ref "archlinux-installation" >}}) 的时候，我并没有安装 NVIDIA 独显驱动，因为一提到 Linux 下的 NVIDIA 驱动，脑海中最先浮现的便是 Linus 竖中指的画面。况且笔记本上还有 Intel 的集成显卡，在 Linux 下的驱动支持极佳，视频什么的足以应付。

近来突然想玩 Minecraft，毕竟是号称集显也能玩的游戏。Vanilla Minecraft 确实能用集显流畅的跑起来，但是一加光影，就有点难为 UHD 630 了。最终还是决定装上 NVIDIA 的专有驱动。

我的需求很简单，可以用独显跑指定的程序即可，不需要全局切换。我只安装了下面两个包：

```bash
sudo pamcan -S nvidia-dkms nvidia-prime
```

其中，`nvidia-dkms` 是可以根据不同内核进行编译的驱动包，比 wiki 里写的 `nvidia` 包要更方便，每次更新内核就会自动编译相应的驱动。`nvidia-prime` 是进行显卡切换的包，驱动安装成功后，如果要使用 NVIDIA 独显，就在相应的命令行前加上 `prime-run` 即可。比如使用 `mesa-demo` 包里提供的 `glxinfo` 来测试显卡驱动是否安装成功，就可以用下面的命令：

```bash
prime-run glxinfo | grep OpenGL
```

如果输出 NVIDIA 显卡的信息，则独显驱动安装成功。还可以使用 `nvidia-smi` 来查看 NVIDIA 独显的使用信息，类似任务管理器的效果。

没想到安装过程和使用过程竟然出乎意料的简单，看来 Linus 中指竖得卓有成效呀。
