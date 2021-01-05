---
title: "[Vim Tips]Jump to link in Vim's help"
date: 2021-01-05
lastmod:
description: How to jump to a link in Vim's help, and how to jump back?
tags: [vim]
categories: [vim]
series: [Vim Tips]
toc: false
math: false
markup: md
draft: false
---

When I use Vim's help, I usually forget how to jump to the links. So I write the tips down to keep mind in them.

The links in Vim' help is not really links, they are tags. Following shortcut will simplely jump into tags and jump back.

{{< plist
    "Follow the link(jump to the link): <kbd>Ctrl-]</kbd>"
    "Jump back previous location: <kbd>Ctrl-t</kbd> or <kbd>Ctrl-o</kbd>"
>}}

Also you can jump to a specific subjects(tags) by using `:ta {subjects}`" instead of <kbd>Ctrl-]</kbd>.

If you want to know more about using Vim's help, you can open your vim, and type `:h help`. Use search and jump tips to fly inside it!