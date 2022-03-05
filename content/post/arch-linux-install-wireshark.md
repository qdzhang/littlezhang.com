---
title: "Arch Linux 安装 Wireshark"
date: 2022-03-05
lastmod:
description: 在 Arch Linux 上安装 Wireshark ，并进行一些额外的设置。
tags: [linux]
categories: [linux]
series: []
toc: true
math: false
markup: md
draft: false
---

在 Arch linux 上安装 Wireshark 并不能“开箱即用”，需要用 root 用户运行。而且根据 [Arch Wiki](https://wiki.archlinux.org/title/wireshark) ，直接使用 root 来运行 Wireshark 不安全，所以需要下面的步骤，来进行一些额外的设置。此为记录。（整个过程是在 Arch Linux 上安装的，其他的发行版也可以参考。）

Wireshark 实现了特权分离，即可以用普通用户运行 Wireshark GUI ，Wireshark 背后的 dumpcap 组件使用 root 运行。如果我们不想直接使用 root 来运行 dumpcap ，可以为它设置 [capabilities](https://wiki.archlinux.org/title/Capabilities) 。而且这样也不是完全安全，只是“更少的危害（less damage）”。

## 1. 使用包管理器安装 Wireshark

```bash
sudo pacman -S wireshark-qt
```

## 2. 创建 wireshark 组

创建一个 `wireshark` group ，并把用户 $USER 添加 `wireshark` 组。

```bash
sudo groupadd wireshark
sudo gpasswd -a $USER wireshark
```

重新登录该用户，使更改生效。或者使用 `newgrp wireshark` 直接使用户进入 `wireshark`  group 。

## 3. 更改 dumpcap 的 group

```bash
sudo chgrp wireshark /usr/bin/dumpcap
```

## 4. 更改 dumpcap 的 permissions

```bash
sudo chmod o-rx /usr/bin/dumpcap
```

## 5. 更改 dummcap 的 capabilities

Wireshark 文档上是先给出了设置 dumpcap 的 file capabilities ，但是在上面第三步中，更改 dumpcap 的 group 会清除 dumpcap 的 file capabilities, 所以应该在这一步再进行更改 capabilities 的操作。

```bash
sudo setcap cap_net_raw,cap_net_admin+eip /usr/bin/dumpcap
```

此时就可以使用普通用户操作 wireshark 了。

---

**参考链接**

- https://wiki.archlinux.org/title/wireshark
- https://gitlab.com/wireshark/wireshark/-/wikis/CaptureSetup/CapturePrivileges#most-unixes
- https://wiki.wireshark.org/CaptureSetup/CapturePrivileges#most-unixes
