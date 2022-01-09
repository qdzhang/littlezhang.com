---
title: "在 Arch Linux 上安装 EAF"
date: 2022-01-09
lastmod:
description: 在 Arch Linux 上不使用 yay 安装 EAF
tags: [linux, emacs]
categories: [emacs]
series: []
toc: false
math: false
markup: md
draft: false
---

[Emacs Application Framework](https://github.com/emacs-eaf/emacs-application-framework/) 可以说是 Emacs 上的一大“杀手级”应用，极大拓展了 Emacs 的功能，给 Emacs 带来了 Python 、Javascript 丰富的生态，all in Emacs 的体验更进一步。

之前我曾尝试过安装 EAF ，但是没有成功。而且 EAF 的安装脚本在 Arch Linux 中默认使用 yay 来安装系统依赖，我使用的 aur 包并不多，所以一直都是手动安装 aur 。

这次我发现 EAF 的安装脚本还可以指定参数，在脚本运行时，不检查系统依赖，这样就可以避免使用 yay 了。不过这样需要我们事先把所有的系统依赖都处理好。

在 Arch Linux 上，EAF 依赖的官方仓库的包有：

```
wmctrl
python
python-pyqt5
python-pyqt5-sip
python-pyqt5-webengine
nodejs
npm
```

依赖的 aur 包有：

```
 python-epc
 python-sexpdata
```

把这些包都装好后，运行安装脚本：

```bash
./install-eaf.py  --ignore-core-deps --ignore-sys-deps
```

安装过程中，会从 Github 拉取所选定的应用，其他的一些依赖，pip 和 npm 都会安装在用户目录下。之后，浏览器、pdf 阅读器、音乐播放器、文件管理器…… 就可以 all in Emacs 了。

虽然 EAF 提供了与 Emacs Evil 的兼容，不过实际使用起来还是不太协调。而且在我使用过程中，对 Emacs 的启动速度影响较大。我也计划之后慢慢弃用 Evil ，再继续深入使用。
