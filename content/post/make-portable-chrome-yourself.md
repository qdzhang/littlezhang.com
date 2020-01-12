---
title: "构建自己的便携版Chrome"
date: 2020-01-10
description: 如何制作自己的便携版Chrome
tags: [好软, 折腾]
categories: [好软]
series: []
math: false
draft: false
---

此文记录我是如何构建 Portable Chrome 的，出发点是不随便使用网上所谓的“绿色版”，方法上怎么简单怎么来，不涉及到复杂的功能。

## 预备条件

1. **下载离线版 Chrome**。从[这个网站](https://tools.shuax.com/chrome/)可以下载，注意校对 SHA1 和 SHA256，而且还应该有 Google LLC 的数字签名。

   ![](https://res.cloudinary.com/dny1wymwm/image/upload/v1578830048/googlesalhdgfjka_aznpib.png)

2. **下载 GoogleChromePortable**。从[这里](https://portableapps.com/apps/internet/google_chrome_portable)下载。这是 portableapps.com 构建的便携版 Chome 。这让我想起一个笑话：下载WinRAR，结果发现是一个 rar 压缩包。

## 一、提取 Chrome 文件

用解压缩软件打开下载的离线版 Chrome，里面有一个chrome.7z文件，再次解压，就能得到一个Chrome-bin文件夹，这个就是我们需要的。

![](https://res.cloudinary.com/dny1wymwm/image/upload/v1578829460/xPAJTxq9a3_hlldr3.png)

## 二、提取GoogleChromePortable.exe

下载的GoogleChromePortable应该也是一个exe文件，不用执行整个文件。和刚才一样，用解压缩软件打开，我们只需要提取里面的GoogleChromePortable.exe文件。里面也有帮助文档，如果需要，可以一并提取出来。

文件不大，不足1M。为了确保文件没有被篡改，一定要进行文件校验。同时也有 Rare Ideas LLC 的数字签名。之前这个小软件已经很久没有更新了，数字签名一直停留在2016年，但当我写本文时，才发现，在去年（2019年）作者就对软件进行了一次更新，并更新了数字签名。我们就用新版本吧。

![](https://res.cloudinary.com/dny1wymwm/image/upload/v1578830017/portablechrome_hiiwyf.png)

## 三、制作便携版

新建一个文件夹，用来存放便携版 Chrome。把上一步提取的GoogleChromePortable.exe放入文件夹中。在该文件夹中再创建一个名为App的文件夹，把第一步中得到的Chrome-bin文件夹放入App文件夹中。此时的文件目录应为

```
/
├── App/
│ └── Chrome-bin/
└── GoogleChromePortable.exe
```

运行GoogleChromePortable.exe，就可以使用Chrome了，并且会在根目录下自动生成一个Data文件夹，里面存放的是用户数据。如果要更新Chrome，可以直接替换App目录下的Chrome-bin文件夹。

## 四、已知的问题

用这种方法制作出来的便携版Chrome和正常的网络安装版相比，还存在一些问题，但基本不影响日常使用。下面是一些问题：

- 内置更新无法使用（可以用上面的方法手动更新）。
- 可能与本地安装的其他版本Chrome有冲突。
- 最小化到Windows任务栏有问题
- ... ...

想要了解详细的情况，可以在第二步提取并查看GoogleChromePortable中的帮助文档。文档中还有更进阶的用法，但是我的需求只是有一个能正常使用的便携Chrome，就止步于此了。