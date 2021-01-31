---
title: "Arch Linux list installed packages by date"
date: 2021-01-31 
description: If you want to list all installed packages by date, you can simplily grep sufficient information in pacman log
tags: [linux, arch]
categories: [arch]
series: []
toc: false
math: false
markup: md
draft: false
---

This is a simple tip to determine all installed packages by date. You can search for some approach using pacman with some bash script. But we can also use pacman log to achieve it.

Pacman log is located in `/var/log/pacman.log` and it records all events related to pacman. And `grep` will help us to find what we want in massive logs. Use the following command:

```
grep installed /var/log/pacman.log
```

If you like to use ripgrep, replace `grep` with `rg`. Because `pacman.log` contains all events when you type `pacman` in command, the results are not really same with `pacman -Q` to display **current** installed packages. So duplicate items are ordinary.
