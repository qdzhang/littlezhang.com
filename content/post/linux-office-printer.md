---
title: "Linux 办公记（一）：设置打印机"
date: 2023-07-26
lastmode:
description:
tags: [Linux]
categories: [Linux]
series: []
toc: true
math: false
markup: md
draft: false
---

经常听到有人在网上争论「Linux 办公是否可行」之类的问题，于是我决定亲自试一试，并把一些设置过程记录一下，既可供日后参考，也希望可以对 Linux 的普及尽到一点微薄之力。

这篇文章记录如何设置打印机。分成三个步骤：设置 CUPS 打印系统、使用 GUI 对打印机进行设置、安装打印机驱动。我是在 Arch Linux 下进行设置的，如果你使用的其他的发行版，基本的设置过程可以参考，但是包名很可能是不同的，需要注意。

# 设置 CUPS

CUPS 是 Linux 下的一套通用打印系统，用来管理打印相关的工作，[Arch Linux wiki](https://wiki.archlinux.org/title/CUPS "Arch wiki") 中有详细的介绍。我们只需要以下两个简单步骤：

1. 安装 `cups` 包。

``` bash
sudo pacman -S cups
```

2. 启动 `cups.service` 服务。

``` bash
sudo systemctl start cups.service
```

# 使用 GUI 对打印机进行设置

使用 GUI 对于一般办公人员很友好，如果你正在使用 GNOME 等完整的桌面环境，那么桌面中可能已经自带了打印机的设置界面；如果你和我一样使用 i3 等窗口管理器，那么需要安装额外的软件。我选择使用 `system-config-printer` 来对 CUPS 进行设置。

安装后，打开 `Print Settings`，点击「Add」，就可以添加打印机了。如果你的打印机拥有极佳的 Linux 支持，此时系统已经能识别出你的打印机了，恭喜你，一直「Next」就能顺利添加一台打印机了，之后就可以在不同的软件中使用了（我也不确定有没有这样的打印机）。

但是有很大的概率 `Print Settings` 只会默认选择使用通用的驱动，那么就需要额外安装驱动。

# 设置打印机驱动

{{< tips info >}}
目前 CUPS 的版本（2.x) 还是使用 PDD 文件来对打印机进行驱动，但是后续的 3.x 版本将会[移除 PDD 的支持](https://openprinting.github.io/OpenPrinting-News-February-2023/) ，当 3.0 正式版发布后，我可能会更新这部分内容，目前下面的步骤还是可行的。
{{< /tips >}}

首先安装 Foomatic ，相当于打印机驱动的数据库。

Foomatic 分两部分，缺一不可。一是数据库驱动，包名为 `foomatic-db-engine` ，二是数据库的内容，有几个不同的包，分别涵盖了不同的打印机的自由驱动和非自由驱动。如果不清楚你的打印机包含在那个包里，那就全部装上吧。

``` bash
sudo pacman -S foomatic-db-engine foomatic-db foomatic-db-ppds foomatic-db-nonfree foomatic-db-nonfree-ppds
```

这时再打开 `Print Settings` ，添加一台新的打印机，可能系统已经能够识别出打印机的型号了，按照提示点「Next」 就行了。

如果还是没有显示相应的型号，还可以使用 [Gutenprint](https://gimp-print.sourceforge.io/) ，这个项目为 GIMP 和 CUPS 提供了大量不同品牌（Canon, Epson, Lexmark, Sony, Olympus, 和 PCL ）、不同型号的打印机驱动。安装 `gutenprint` 和 `foomatic-db-gutenprint-ppds` 两个包即可。

{{< tips info >}}
如果之后 `gutenprint` 更新了，需要手动运行 `cups-genppdupdate` 命令，并重启 `cups.service` 服务，来更新并应用系统中的 PDD 文件。
{{< /tips >}}

如果此时还是不能正确驱动打印机，那么需要到制造商的官网上，看看是否提供了专有的驱动包可供使用。如果运气实在不佳，官网的驱动只支持 Windows ，那么 Linux 办公的尝试就此结束吧。

我的经历是，安装了 Gutenprint 之后，打印机已经能够正常使用了，使用体验和 Windows 下几乎没有什么区别，全图形化操作，点点鼠标，打印工作就能完成。甚至 `Print Settings` 提供的打印队列的功能比 Windows 下的还要好用，这是意外惊喜。
