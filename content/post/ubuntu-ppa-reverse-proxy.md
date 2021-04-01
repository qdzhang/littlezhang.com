---
title: "使用反向代理加速 Ubuntu PPA"
date: 2021-01-10
lastmod:
description: PPA 的下载速度太慢？使用 USTC 开源镜像提供的反向代理加速 PPA。
tags: [linux, ubuntu]
categories: [linux]
series: []
toc: false
math: false
markup: md
draft: false
---

Ubuntu 的 [PPA](https://launchpad.net/ubuntu/+ppas)（Personal Package Archives）可以下载其他用户上传的编译好的软件，很便捷地解决一些软件版本落后、自己不想编译等等的问题（这里需要自行权衡利弊），但下载速度有时实在太慢，又不像软件源一样可以使用镜像，如何加速？这个[知乎回答](https://www.zhihu.com/question/382334154/answer/1131393495)很好的解决了问题。

使用中科大提供的反向代理可以提高 PPA 的下载速度。在 `/etc/apt/sources.list.d` 目录下可以找到每一个 PPA 添加的 `list` 文件，把其中的 `http://ppa.launchpad.net` 替换为 `https://launchpad.proxy.ustclug.org`。

{{< tips error>}}
一定要替换成 **`https`** ！
{{< /tips >}}

在 [USTC 镜像网站上](https://mirrors.ustc.edu.cn/)可以查看反向代理列表，像 docker、npm 等等都可以使用 USTC 的反向代理。