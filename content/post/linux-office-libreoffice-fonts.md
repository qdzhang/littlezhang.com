---
title: "Linux 办公记（二）： LibreOffice 设置中文字体"
date: 2023-07-31
lastmode:
description: 尝试完全使用 Linux 进行办公，记录一下这个过程。这篇文章主要介绍如何在 Linux 下设置 LibreOffice 的中文字体，使之符合中文环境下的基本排版要求。
tags: [Linux]
categories: [Linux]
series: []
toc: true
math: false
markup: md
draft: false
---

[上一篇文章]({{< ref "linux-office-printer" >}})介绍了如何在 Linux 下设置打印机，但是如果在 Linux 上没有正确设置字体，显示效果和打印效果都很不理想。而且网上一些关于日常使用 Linux 的争论中，字处理软件的使用一直是极为高频的话题：如何安装 Microsoft Office ？如何安装 WPS ？如何在虚拟机中使用 Word ？（另一类高频话题可能就是微信、QQ 、钉钉等通讯软件的安装了。）

其实只要字体设置得当，在 Linux  下 LibreOffice 完全能够满足基本的办公需求。这篇文章就记录一下如何在 LibreOffice 中设置、使用恰当的中文字体。

{{< tips info >}}
我是在 Arch Linux 下进行设置的，如果你使用其他的发行版，基本的设置过程可以参考，但是包名很可能是不同的，需要注意。
{{< /tips >}}

## 安装 LibreOffice

``` bash
sudo pacman -S libreoffice-fresh
```

这样安装的 LibreOffice 默认是英文的界面，缺少一些中文本地化的配置选项，而且接下来安装字体后，字体名称显示也是类似「FZFangSong-Z02」这样的英文，不是我们熟悉的「仿宋」这样的名称。所以我们需要安装中文语言包：

``` bash
sudo pacman -S libreoffice-fresh-zh-cn
```

## 安装中文字体

为达到更好的显示效果，参考[这篇文章](https://zhuanlan.zhihu.com/p/538459335?utm_id=0) ，选择四款可以免费使用（包括商用）的方正字体：方正书宋、方正黑体、方正楷体、方正仿宋（包括 GB2312 和  GBK 两种编码），和两款 Noto CJK 字体：Noto Serif CJK 、Noto Sans CJK （这两款字体也可以使用思源宋体和思源黑体）。

这六款字体都是免费可商用，搭配使用，就可以得到相当漂亮的显示效果。

Noto 字体可以直接在 Arch Linux 的官方仓库里安装：

``` bash
sudo pacman -S noto-fonts-cjk
```

方正字体需要到[官网上](https://www.foundertype.com/index.php/FindFont/index)自行搜索下载，获得免费的授权。但是现在方正的官网上仅提供字体的获取，还需要另外下载客户端，在客户端中才能下载相应的字体文件。然而，客户端没有 Linux 版本的，我们需要自行解决字体文件的问题。要么是在 Windows 中安装客户端并下载字体，然后复制到 Linux 平台，要么就需要直接在网上查找字体文件，然后安装。

好在「万能」的 aur 里有两个包可以直接安装方正字体（使用时请注意版权和许可）：`ttf-foundertype-sc-fonts` 和 `wps-office-fonts` 。前者只有简体，后者是从 WPS 社区里提取出来的字体版本，还含有其他的方正字体，使用的话，需要特别注意字体的版权。我们只使用上述四款免费可商用的字体。两个字体包安装后，字体的名称略微不同：

|`ttf-foundertype-sc-fonts`|`wps-office-fonts`|
|--------------------------|------------------|
|方正书宋简体              |方正书宋_GBK      |
|方正黑体简体              |方正黑体_GBK      |
|方正楷体简体              |方正楷体_GBK      |
|方正仿宋简体              |方正仿宋_GBK      |

不管安装哪个包皆可，考虑到编码更全，这里我选择 `wps-office-fonts` 。

## 设置 LibreOffice

设置 LibreOffice 分为两步：一是配置「字体替换表」；二是配置 Writer 中「基本字体」。

### 配置「字体替换表」

因为 Linux 下中文字体名称不能和 Windows 中的字体完全对应，所以我们需要配置替换表，使用我们指定的字体显示原本的文字。比如，我们指定所有的「宋体」，使用「方正书宋_GBK」字体来显示，诸如此类。

点击 LibreOffice 工具栏中的「工具」->「选项」，在左侧选项栏中点击「LibreOffice」->「字体」，在右侧勾选「使用替换表」，在下面「字体」一栏中填入通用的字体名称，如「宋体」、「仿宋」等，在「替换成」一栏中填入已安装的、要使用的字体名称，如「方正书宋_GBK」、「方正仿宋_GBK」等，如下图。

![替换表](https://res.cloudinary.com/dny1wymwm/image/upload/v1690788676/compressed_1690788506_ccr1yz.png)

我使用的替换规则如下表：

|字体        | 替换成                     |
|------------|----------------------------|
|宋体        |方正书宋_GBK                |
|SimSun      |方正书宋_GBK                |
|楷体        |方正楷体_GBK                |
|楷体_GB2312 |方正楷体_GBK                |
|黑体        |方正黑体_GBK                |
|SimHei      |方正黑体_GBK                |
|仿宋        |方正仿宋_GBK                |
|仿宋_GB2312 |方正仿宋_GBK                |
|小标宋      |Noto Serif CJK SC SemiBold  |
|大标宋      |Noto Serif CJK SC           |
|粗宋        |Noto Serif CJK SC Black     |
|大黑        |Noto Sans CJK SC Mediu      |
|粗黑        |Noto Sans CJK SC Black      |

替换表前面的两个复选框「始终」和「仅屏显」都需要勾选，勾选前者以使用该条替换规则，勾选后者以保持字体不变，仅在 Linux 本地使用该条替换规则来显示，当我们发送文件到其他平台（Windows 、Mac）时，依然会使用原字体，而不是我们替换后的字体。

这样设置后，我们在 Linux 平台新建文档，设置字体，就需要在字体选栏中手动输入我们想要的字体，比如「宋体」，此时 LibreOffice 会使用「方正书宋_GBK  」来显示文档，当我们发送文档到 Windows 平台时，该文档会使用 Windows 下默认的「宋体」显示。

### 配置 Writer 中的「基本字体」

每次都需要在字体选栏中手动输入字体名称，是件繁琐的工作，我们可以通过设置默认的字体来解决。

点击 LibreOffice 工具栏中的「工具」->「选项」，在左侧选项栏中点击「LibreOffice Writer」->「基本字体（亚洲文字）」，我们可以在右面设置我们想要的默认字体和大小，因为我们上面已经配置了「替换表」，这里设置的文字都可以顺利地使用我们指定的方正字体和 Noto 字体来显示。

![基本字体](https://res.cloudinary.com/dny1wymwm/image/upload/v1690788675/compressed_1690788515_qxor3m.png)

### 效果

经过上面两步 LibreOffice 的设置，可以得到如下不错的效果：

![效果](https://res.cloudinary.com/dny1wymwm/image/upload/v1690788675/compressed_1690788500_sk0ubj.png)

## 设置 fontconfig （可选）

字体安装后，还可以配置 fontconfig ，来设置全局字体，遵守 fontconfig 的软件自然会使用这些字体，但也有很多软件不会遵守。而且如果你只在 LibreOffice 中使用上述安装的中文字体，这一步不是必需的。

参考[依云的博文](https://blog.lilydjwg.me/categories/4326/posts) 和 [配置文件](https://github.com/lilydjwg/dotconfig/blob/master/fontconfig/fonts.conf) ，进行以下 fontconfig(`~/.config/fontconfig/fonts.conf`) 的设置：

``` xml
<match>
  <test name="family"><string>宋体</string></test>
  <edit name="family" mode="prepend" binding="strong">
    <string>FZShuSong-Z01</string>
    <string>Noto Serif CJK SC</string>
  </edit>
</match>

<match target="pattern">
  <test name="family"><string>SimSun</string> </test>
  <edit binding="strong" mode="prepend" name="family">
    <string>FZShuSong-Z01</string>
    <string>Noto Serif CJK SC</string>
  </edit>
</match>

<match>
  <test name="family"><string>仿宋</string></test>
  <edit name="family" mode="prepend" binding="strong">
    <string>FZFangSong-Z02</string>
    <string>Noto Serif CJK SC</string>
  </edit>
</match>

<match>
  <test name="family"><string>黑体</string></test>
  <edit name="family" mode="prepend" binding="strong">
    <string>FZHei-B01</string>
    <string>Noto Sans CJK SC</string>
  </edit>
</match>

<match>
  <test name="family"><string>SimHei</string></test>
  <edit name="family" mode="prepend" binding="strong">
    <string>FZHei-B01</string>
    <string>Noto Sans CJK SC</string>
  </edit>
</match>

<match>
  <test name="family"><string>楷体</string></test>
  <edit name="family" mode="prepend" binding="strong">
    <string>FZKai-Z03</string>
    <string>Noto Sans CJK SC</string>
  </edit>
</match>

<alias binding="strong">
  <family>FangSong</family>
  <accept>
    <family>FangSong_GB2312</family>
  </accept>
</alias>

<alias binding="strong">
  <family>仿宋</family>
  <accept>
    <family>仿宋_GB2312</family>
  </accept>
</alias>

<alias binding="strong">
  <family>KaiTi</family>
  <accept>
    <family>KaiTi_GB2312</family>
  </accept>
</alias>

<alias binding="strong">
  <family>KaiTi SC</family>
  <accept>
    <family>KaiTi_GB2312</family>
  </accept>
</alias>

<alias binding="strong">
  <family>楷体</family>
  <accept>
    <family>楷体_GB2312</family>
  </accept>
</alias>
```

## 总结

在经过以上的设置以后，我们使用 LibreOffice 打开文件、新建文件，都可以使用与 Windows 平台类似的字体来显示，结合[上一篇文章]({{< ref "linux-office-printer" >}})配置成功的打印机，我们的文档也能漂亮地打印出来了。对于一些需要更多 Microsoft Word 高级功能的工作而言，可能坚守 Windows 平台和 Word 还是必需的；但对于要求不太严格的一般的办公场合，这些设置足以胜任基本需求。
