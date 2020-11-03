---
title: "不安装桌面环境在WSL2中使用GUI程序"
date: 2020-11-03
lastmod:
description: 在WSL2中使用GUI程序，不用安装桌面环境
tags: [wsl2, linux]
categories: [wsl2]
series: []
toc: true
math: false
markup: md
draft: false
---

最近要用到 Selenium，我的开发环境在 WSL2 下，需要在 WSL2 下安装 Chrome 和 ChromeDriver，所以就有了这篇记录。

本文的目标是在 WSL2 下使用 GUI 程序，**不需要安装整个桌面环境**（GNOME、KDE、XFCE等）。其中以 Chome 为例，如果你不需要安装 Chrome，可以直接跳转到[这一节](#-windows--x-server)。

## 安装 Chrome

如果你的 WSL2 发行版的软件源里有 Chrome，那么你可以使用包管理器去安装它。如果没有（好像一般都没有，毕竟是闭源软件），可以使用以下命令（Ubuntu环境下）安装它：

```bash
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb
```

安装后可以测试一下是否安装成功：

```bash
google-chrome --version
```
如果正常输出版本号，则说明安装成功。

## 安装 ChromeDriver

ChromeDriver 可以在[其官网](https://chromedriver.chromium.org/)上找到下载链接，下载之后，解压并给予相应权限。可以使用下面的命令下载、解压、安装。

```bash
wget https://chromedriver.storage.googleapis.com/86.0.4240.22/chromedriver_linux64.zip
sudo mv chromedriver /usr/bin/chromedriver
sudo chown root:root /usr/bin/chromedriver
sudo chmod +x /usr/bin/chromedriver
```

ChromeDriver 是一个单文件，如不再使用，直接删除 `/usr/bin/chromedriver` 即可。

安装后可以测试一下是否安装成功：

```bash
chromedriver --version
```
如果正常输出版本号，则说明安装成功。

## 在 Windows 下安装 X Server

接下来需要在 Windows 下安装 X Server。这里我使用的是[VcXsrv](https://sourceforge.net/projects/vcxsrv/)，其他的 X Server 都是可以的，你可以选用你喜欢的。

安装之后，需要一些设置。

首先需要在防火墙里允许 VcXsrv 的连接。可以在“控制面板\系统和安全\Windows Defender 防火墙\允许的应用”里面找到 VcXsrv windows xserver，对其进行控制。

然后打开 VcXsrv，display number 填 0，其他的可以保持默认，直到 Extra setting，要勾选“Disable access control”，并在下面的附加参数里填“-ac”[^1]，如下图。

![Extra setting](https://res.cloudinary.com/dny1wymwm/image/upload/v1604393119/extra_setting_hadn5x.png)

这一步就完成了。可以把上面的设置保存成一个配置文件，以后使用就不用每次都要设置了。

## 在 WSL2 下设置环境变量以使用 X Server

在 Linux 环境中，环境变量 DISPLAY 用来指示 GUI 程序使用哪一个 IP 地址和 X Server。我们可以作如下设置：

```bash
export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0
```

可以把上面的命令保存在 `.bashrc` 文件里（如果你用 bash 的话）。其他的 shell 环境同理。

## 成果

到这里就完成了全部设置。启动 VcXsrv，在 WSL2 shell 中运行 `google-chrome`，已经可以打开图形界面的 Chrome 了。其他有 GUI 需求的程序，比如 gvim，甚至一些 IDE，不谈性能的话，都可以在 WSL2 中安装，直接运行。不过还是很期待微软官方对于 WSL2 的图形支持[^2]。


[^1]: https://github.com/microsoft/WSL/issues/4106
[^2]: https://devblogs.microsoft.com/directx/directx-heart-linux/