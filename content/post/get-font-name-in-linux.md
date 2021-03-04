---
title: "在 Linux 中查看字体名称"
date: 2021-03-04 
description: 如果我们想要在终端环境下进行字体的配置，通常没有一个方便的字体选择框来列出可供选择的字体，我们可以通过 fc-list 命令查看字体。
tags: [linux]
categories: [linux]
series: []
toc: false
math: false
markup: md
draft: false
---

在 Linux 环境下，一些应用程序的字体是需要通过配置文件来进行配置的，我们就需要知道字体的确切名字。通过 `fc-list` 命令可以查看所有安装的字体信息，比如，下面就是 `NotoSansCJK` 字体的信息：

```bash
/usr/share/fonts/noto-cjk/NotoSansCJK-Bold.ttc: Noto Sans Mono CJK TC:style=Bold
└---------------------------┬----------------┘  └--------┬----------┘ └--┬-----┘
                            |                            |               |
                        字体文件名称                    字体名称          字体样式 
```

我们需要的就是中间的“字体名称”部分。如果字体名称有空格，一些配置文件中需要用转义字符进行转义（比如 vim 中），在空格前面添加 `\` 即可。

但是 `fc-list` 返回的结果常常很多，我们可以利用 Linux 的管道符，用 `grep` 来过滤我们想要的结果。比如我想要找 Sarasa 字体，可以利用下面的命令：

```bash
fc-list | grep -i sarasa
```

用 `-i` 选项来忽略大小写。当然这里也可以用 `rg` 替代 `grep` 以获取高亮结果的输出（如果你用 ripgrep 的话），更易辨识。

其实以前我用一个很笨的方法来查看字体名称，就是另外打开一个支持查看字体名称的 GUI 程序，使用它的字体选择器😂。现在也有更直观的 [Font Magener](https://github.com/FontManager/font-manager) 可以使用了。上面的方法可能更符合 Linux 哲学一点，毕竟不用额外的软件了。
