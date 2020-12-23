---
title: "Use zsh as default login shell"
date: 2020-12-23 
description: If you want to use zsh as the default login shell, you can try chsh command.
tags: [linux, zsh]
categories: [linux]
series: []
math: false
markup: md
draft: false
---

Zsh is a shell with rich features. Comparing with bash, zsh is more suitable for interactive use. But most linux distributions use bash as the default login shell. If you don't want to type `zsh` every time in bash prompt, it's time to change the default shell to zsh.

We can simplely use command `chsh` (means 'change shell') to achieve the goal. Use the following command to detect where zsh located in and change default shell one-step.

```bash
chsh -s $(which zsh)
```

Or you can specify the `chsh` argument for `-s` option explicitly if you know the path of zsh.

```bash
chsh -s /usr/bin/zsh  # change the path to your actual zsh path
```

Also `chsh` provide an interactive mode. Type `chsh` then `Enter`, the shells will be listed. You can choose which one to use default.

So all above not only apply for zsh, but also many other shells. Maybe `fish` shell, or whatever. Have a try!
