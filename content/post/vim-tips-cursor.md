---
title: "[Vim Tips]设置Windows Terminal内vim的光标"
date: 2020-11-07 
description: 设置终端内vim的光标，change vim cursor in terminal
tags: [vim, 折腾]
categories: [vim]
series: [Vim Tips]
math: false
markup: md
draft: false
---

本文主要解决 vim 和 Windows Terminal 在光标上的一些兼容性问题。

## 设置光标的形状

在 Windows Terminal 里使用 wsl2 下的 vim，光标不能根据模式的变化而变化，比如 normal 模式下是方块(Solid Block)，insert 模式下是竖线(Vertical Bar)。而且如果 Windows Terminal 的设置里终端的光标是竖线，打开 vim 再退出后，Windows Terminal 的光标也会变成 vim normal 模式下的方块。

要解决这一问题，在 vimrc 文件里添加下面几行：

```vimscript
if &term =~ "xterm"
    let &t_SI = "\<Esc>[6 q"
    let &t_SR = "\<Esc>[3 q"
    let &t_EI = "\<Esc>[2 q"
endif
```

同样的，在 tmux 里 vim 的光标也有类似的问题，上面的配置不能解决，还要再添加如下配置：

```vimscript
if exists('$TMUX')
    let &t_SI .= "\e[6 q"
    let &t_SR .= "\e[3 q"
	let &t_EI .= "\e[2 q"
endif
```

## 设置光标的颜色

Windows Terminal 中还有一个特别明显的 bug，即如果设置成方块光标，当光标颜色与字符颜色相近时，光标在字符上面会挡住字符，理想情况应该是光标在字符上时，字符会反色。在 [这个 issues](https://github.com/microsoft/terminal/issues/1203) 上有非常详细的讨论。目前还没有完美的解决方案，因为还有一些特性微软还没有把代码合并进去。但还是有一些方案的，比如我现在用的，在 Windows Terminal 的 `settings.json` 里 wsl2 部分添加以下代码：

```json
"cursorShape": "filledBox",
"cursorColor": "#45902e",  // 选一个高亮方案里不常见到的颜色，这里我选的深绿色
"cursorTextColor": "textForeground",
```

上面的 issues 里也有人提出了一个临时的解决办法，就是不使用方块光标。不过为了与上面设置的 vim 光标形状保持一致，我还是使用了方块光标（`settings.json`里的`filledBox`）。也可以继续跟踪这个 issues，等官方的更新出来。
