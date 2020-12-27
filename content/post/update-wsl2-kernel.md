---
title: "Update WSL2 kernel to a newer version"
date: 2020-12-27 
description: WSL2 offical kernel version is old, but we can update it to a much newer version
tags: [linux, wsl2]
categories: [wsl2]
series: []
math: false
markup: md
draft: false
---

Microsoft maintains a [custom linux kernel](https://docs.microsoft.com/zh-cn/windows/wsl/install-win10#step-4---download-the-linux-kernel-update-package) for WSL2. Keeping with the offical version has many benefits. For instance, the linux kernel in WSL2 can be updated when the Windows itself updates since Windows 10 version 2004[^1]. And also the automatic updates will service capabilities. 

But the WSL2 kernel drops behind the mainline kernel version unless you are in Windows Insiders. You may want to follow the mainline kernel version or a newer version at least. WSL2 is based on Hyper-V, in the other words, it is actually a virtual machine. So it is possible to boot WSL2 with a custom kernel.

Download the newer WSL2 linux kernel from [here](https://github.com/nathanchance/WSL2-Linux-Kernel/releases). And place the kernel somewhere in Windows, such as the user folder. Then create a new file named `.wslconfig` in your Windows user's home directory(e.g. `C:\Users\yourname\.wslconfig`) and type following:

```
[wsl2]
kernel = C:\\Users\\yourname\\bzImage
```

The path behind `kernel =` is the full path to the kernel image with all of the slash replaced with double slashes. It points to the kernel image downloaded before.

Restart WSL2 and use `uname -r` to see whether new kernel is booted. If you like neofetch screenshot, you can also use `neofetch` to see the current version of kernel.

[^1]: https://devblogs.microsoft.com/commandline/wsl2-will-be-generally-available-in-windows-10-version-2004/
