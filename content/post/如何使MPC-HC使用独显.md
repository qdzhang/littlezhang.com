---
title: "使 MPC-HC 使用独显"
date: 2020-06-10 
description: 利用 Windows 10 特性，使 MPC-HC 使用独显，发挥高性能显卡的优势
tags: [折腾, 好软, MPC-HC]
categories: []
series: []
math: false
markup: md
draft: false
---

MPC-HC 是 Windows 平台上的一款功能强大的、[开源](https://github.com/clsid2/mpc-hc)的影音播放器，虽然界面复古了点，但其内置 LAVFilters，可以搭配其他的一些渲染器、滤镜等，打造“最强播放器”。比如网上就有很多关于 MPC-HC + madVR 之类的配置文章，这里不详述，我们重点在如何**优雅地**、**一劳永逸地**使这款强大的播放器使用独显（我的显卡是 Nvidia 的，不太确定是否对 AMD 适用）。

MPC-HC 不能在 Nvidia 控制面板里使用独显，这可能是 Nvidia 的设定吧。网上也有解决方法，主要都是以下两种：
1. 把 MPC-HC 的可执行文件，即安装目录下的 mpc-hc64.exe(32位为 mpc-hc.exe) 改名，随便改成什么都行，再在 Nvidia 控制面板里手动添加改名后的可执行文件，就可以使用独显了。
2. 下载 [Nvidia Profile Inspector](https://github.com/Orbmu2k/nvidiaProfileInspector)，在软件里面对 MPC-HC 进行修改，之后就能在 Nvidia 控制面板里调用独显了。

但是这两种方法都不太优雅，第一种方法会对文件关联和一些其他的需要用到原程序名的地方产生影响，第二种方法每次使用 MPC-HC 之前都需要去 Nvidia Profile Inspector 里调，很是麻烦。

接下来才是重头戏，真正优雅的、一劳永逸的方法，而且**理论上**支持所有应用程序调用独显。我们利用了 Windows 10 的原生设置，也就是说，这个方法只支持 Windows 10。

在设置里，点击“系统”，在显示设置里，向下拉，找到“图形设置”，点进去。

![](https://res.cloudinary.com/dny1wymwm/image/upload/v1591761897/ApplicationFrameHost_NxiSAoI6ka_vu42kr.png)

可以在下拉框里选择应用的类型，我们要设置 MPC-HC，所以选择“桌面应用”。

![](https://res.cloudinary.com/dny1wymwm/image/upload/v1591761896/ApplicationFrameHost_8j4mSfg1br_txkpzp.png)

点击浏览，找到 MPC-HC 的安装目录下，选择 MPC-HC 的可执行文件，即安装目录下的 mpc-hc64.exe(32位为 mpc-hc.exe)，就把 MPC-HC 添加到了设置里了。

![](https://res.cloudinary.com/dny1wymwm/image/upload/v1591761896/ApplicationFrameHost_IWFowFgylK_ghy9jz.png)

点击“选项”，选择“高性能”，点击保存，就完成了。

![](https://res.cloudinary.com/dny1wymwm/image/upload/v1591761897/ApplicationFrameHost_NEgfc03Ne0_lpays9.png)

如果你有其他的应用程序，想让它调用独显，也可以用上面的方法添加。