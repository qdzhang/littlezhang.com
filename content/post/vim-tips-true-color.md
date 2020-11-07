---
title: "[VIM TIPS]在vim和tmux中开启真彩色"
date: 2020-11-06 
description:
tags: [vim, tmux, 折腾]
categories: [vim]
series: [VIM TIPS]
math: false
markup: md
draft: false
---

在 vim 和 tmux 中开启真彩色，可以获得更好的视觉体验。

可以在[这里](https://github.com/gnachman/iTerm2/blob/master/tests/24-bit-color.sh)下载这段脚本，在终端执行，如果支持真彩色，则显示如下：
![](https://res.cloudinary.com/dny1wymwm/image/upload/v1604760841/true-color_t9alhg.png)

否则是这样的：
![图片来源见参考链接](https://res.cloudinary.com/dny1wymwm/image/upload/v1604760841/256-color_eycdvd.png)

如果你用的是比较新版本的 vim，那默认就是支持真彩色的。可以在 vim 里用 `:terminal` 命令进入 vim 自带的终端，执行前面下载的 `24-bit-color.sh`，看看是否达到上面的效果。我也试了网上的一些做法，把 `set termguicolors` 加入 vimrc 里，反而不起作用。

Tmux 需要在 `.tmux.conf` 配置文件里添加下面的内容：

```bash
set -g default-terminal tmux-256color  # 这里也可设置成 screen-256color
set-option -ga terminal-overrides ",*256col*:Tc"
```

退出所有的 tmux，再重新打开，就可以了。


*参考链接*

[https://lotabout.me/2018/true-color-for-tmux-and-vim/](https://lotabout.me/2018/true-color-for-tmux-and-vim/)
