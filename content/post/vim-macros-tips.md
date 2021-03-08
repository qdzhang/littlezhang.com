---
title: "A small tip when using vim macros"
date: 2021-03-08 
description: Vim macros can help us to get rid of tedious works. If we want to repeat a macro thousands times, a small tip may accelerate the speed of progress.
tags: [vim]
categories: [vim]
series: [Vim Tips]
toc: false
math: false
markup: md
draft: false
---

Show the tip first:
<!--more-->

{{< notice tip >}}
If you record a macro that manipulates buffer frequently, use `vim --clean` to start a "clean" vim, and then use the macro.
{{< /notice >}}

It is a very very simple tip, but helped me a lot yesterday. I recorded a macro to exchange two word-lines in a long text file. Repeating the macro more than 50000 lines is really slow. A few minutes later, I got some messages from vim then found the culprit. There were too many autocmds and plugins slowing current buffer. After I restart Vim with `vim --clean`, the whole progress was lightning fast.
