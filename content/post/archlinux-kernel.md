---
title: "Arch Linux 使用“更旧”的内核"
date: 2022-01-14
lastmod:
description: Arch Linux 官方维护的 lts 内核进行一些大版本更新时，也经常会带来一些小的问题。那么如何才能留在一个相对更稳定、更旧的内核版本呢？
tags: [linux]
categories: [linux]
series: []
toc: false
math: false
markup: md
draft: false
---

前两天 Arch Linux 官方仓库的 [linux-lts](https://archlinux.org/packages/core/x86_64/linux-lts/) 版本更新到了 5.15.14-1，竟然比 [linux](https://archlinux.org/packages/core/x86_64/linux/) 版本（当时为 5.15.13）还要新。不多没过多久，`linux` 也升到了 5.16。

之前一次更新 `linux` 时，导致电脑无法正常显示，于是我就换到了 `linux-lts` ，那也是我第一次体验进 live CD 去修复 Arch 的一些问题，参考了我当时[安装 Arch Linux]({{< ref "archlinux-installation" >}}) 的记录。不过我的硬件也不新，lts 内核版本更新也挺频繁的，感觉这么频繁更新内核没太大的必要。于是我就想留在一个“更旧”的 lts 内核版本，反正根据 [kernel 的页面](https://www.kernel.org/category/releases.html) ，5.10 的 longterm 版本会一直支持到 2026 年 12 月，比现在最新的 5.15 lts
版本支持的时间（到 2023 年 10 月）还要长。

现在已经明确我的需求：

1. 继续让 Arch Linux 滚动更新，不部分升级。（网上有些文章、论坛里是建议在 pacman 的设置里忽略 kernel 的更新，这是**危险**的！）
2. 使用 5.10 版本的 linux-lts 。

自己编译、维护一份内核有些太麻烦，好在 AUR 中已经有了 [linux-lts510](https://aur.archlinux.org/packages/linux-lts510) 的包。而且包的维护者还维护着一个[非官方仓库 linux-lts](https://wiki.archlinux.org/title/Unofficial_user_repositories#kernel-lts)，里面提供了编译好的 `linux-lts510` ，采用的是和 AUR 中相同的 PKGBUILD ，这样就更简单了，直接添加 linux-lts 仓库即可安装“更旧”的 lts 内核。

在 `/etc/pacman.conf` 后面添加：

```conf
[kernel-lts]
Server = https://repo.m2x.dev/current/$repo/$arch
```

安装时又有点小麻烦，维护者使用的 keyserver 在我的网络环境下似乎不能下载到用于包签名的 key 。只有手动下载 key ，再根据 [Arch Wiki](https://wiki.archlinux.org/title/Pacman/Package_signing#Adding_unofficial_keys) 的步骤，添加这个 key ：

```bash
sudo pacman-key --add /path/to/downloaded/keyfile
sudo pacman-key --lsign-key keyid
```

之后刷新仓库，安装 `linux-lts510` 和 `linux-lts510-header`。

```bash
sudo pacman -S linux-lts510 linux-lts510-header
```

不过这个 kernel 似乎没有注册 pacman hook ，安装后需要我们手动更新 grub 设置（如果你用的是其他的 bootloader ，就用相应的方法）：

```bash
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

并且根据 [Arch Wiki](https://wiki.archlinux.org/title/GRUB/Tips_and_tricks#Recall_previous_entry) 设置 grub 自动记住上次选择的启动选项，就可以在开机时选择想要使用的 `linux-lts510` 内核，并且在之后记住这一选项了。
