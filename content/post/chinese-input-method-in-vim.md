---
title: "在 Vim 里更好地使用中文输入法"
date: 2021-03-10
description: 在 Vim 里使用中文，很是不方便，尤其是涉及到频繁的中英文切换的场景。最近尝试了一些解决的方案，在这里总结一下，谈一下我自己的使用体验。我主要使用小鹤双拼，所以文章主要以小鹤双拼的输入舒适度为主，但其他大部分的中文输入方法应该同样适用。
tags: [vim, 输入法, 100DaysToOffload]
categories: [vim]
series: []
toc: true
math: false
markup: md
draft: false
---

最近看到 jdhao 更新了[两篇](https://jdhao.github.io/2021/02/25/nvim_ime_mode_auto_switch/)[博文](https://jdhao.github.io/2021/02/26/IME_inside_vim/)，总结了几种在 Vim 里切换输入法和使用 Vim 自带的补全输入中文的方法。刚好这段时间我也在折腾在 Vim 下的中文输入，在此做一个总结。

## 1. fcitx.vim 或者 vim-barbaric

[fcitx.vim]() 和 [vim-barbaric]() 是两个 Vim 插件，都可以在离开 `insert` 模式后自动切换为英文输入，再次进入 `insert` 模式后，恢复上次的输入状态。如果是在 Linux 环境下使用的话，两者安装之后基本都是开箱即用，而在 Windows 和 macOS 环境下，vim-barbaric 需要安装额外的依赖，并且需要考虑输入法是否支持，在 `README` 里有详细的说明。在我的机器上，vim-barbaric 要比 fcitx.vim 对 Vim 启动速度的影响更小，其他的使用体验基本一致。

## 2. ZFVimIM

[ZFVimIM](https://github.com/ZSaberLv0/ZFVimIM) 是利用 Vim 的内置补全实现的输入法，不依赖外部的输入法，支持云词库，本地词库需要有词库文件的支持，也可以很方便的自己制作词库。作者也给出了几个拼音词库和五笔词库。我自己制作了一份小鹤音形的词库，仓库地址在[这里](https://github.com/qdzhang/ZFVimIM_xiaohe)。

![zfvimim_xhup](https://res.cloudinary.com/dny1wymwm/image/upload/v1616246153/zfvimim_xhup_rmlkoj.gif)

而且小鹤音形、五笔这类输入法重码较少，大部分编码都只对应一个候选字/词，拼音词库则是一个编码对应多个字/词，如果词库很大，不可避免地需要在诸多候选词里选词。所以使用形码输入法，搭配 ZFVimIM 的体验会更好。云词库我还没有体验，可以参照开头 jdhao 的那两篇博文里的内容。

ZFVimIM 默认触发的快捷键是 <kbd>;;</kbd> ，我经常在 Vim 里使用 <kbd>f/F</kbd> 进行行内查找，查找结果的下一个的快捷键是 <kbd>;</kbd>，由于 Vim 会在按下分号时等待是否会有第二个分号按下，如果我只想要跳转到下一个 <kbd>f/F</kbd> 的结果，Vim 就会“呆”一会儿才会响应这个动作。目前没有发现 ZFVimIM 有更改触发快捷键的设置选项，我只好修改源码，把这个快捷键改了。

整体来说，ZFVimIM 的使用体验还可以，我也会在日常使用中，继续完善小鹤音形的[词库](https://github.com/qdzhang/ZFVimIM_xiaohe)。如果你也是使用小鹤音形的 Vim 用户，欢迎 PR！

## 3. fcitx5 自定义触发按键

> 这一段更新于 2021-03-20，目前来看，这是个人觉得体验最好的方法，而且不依赖其他的插件，全局可用。唯一的缺陷就是很多输入法不支持这样设置，如果你也用 fcitx5，可以尝试看看。

我在 Emacs 群里看到一位群友的发言得到启发。那位群友大概的意思是，输入法的每个输入方案对应一个独立的快捷键，而不是像现在大部分的输入法那样，采用一个快捷键，循环选择可选输入方案。这样对于输入法的选择就是精准的，当我按下某个按键时，触发的一定是特定的输入法。这就像 Vim 里的 <kbd>ESC</kbd> ，按下去，一定会回到 `normal` 模式（如果你没有特别更改的话）。

我觉得这个方案挺符合我的输入习惯的。我在 fcitx5 里只使用了两个输入方案：默认的 en 和 中文的 rime。使用两个快捷键对应这两个输入方案，也不会增添额外的心智负担。

于是我在 fcitx5 的设置里找寻一番，果然发现了可以设置的选项。

如果你使用图形界面的 fcitx5 设置，在 Addon 里，选择 input method selector，里面配置一下 switch to N-th input method 的快捷键，可以添加多个。如果你使用配置文件，可以参考我的[配置](https://github.com/qdzhang/.dotfiles/blob/e4ffcd251c3e030aa5e832fa8c4845143d0450fd/.config/fcitx5/conf/imselector.conf#L9)。

以我的配置为例，我的第 0 个（第一个）输入方案是英文，设置为 <kbd>ctrl + \\</kbd>，第 1 个（第二个）输入方案是 rime，设置为 <kbd>alt + \\</kbd>，这样不管在什么情况下，当我按下 <kbd>ctrl + \\</kbd>，选择的一定是英文输入，按下 <kbd>alt + \\</kbd>，选择的一定是中文。这个按键配置不一定最高效，我也会慢慢摸索，找出最适合的快捷键。

{{< 100days day=1 >}}
