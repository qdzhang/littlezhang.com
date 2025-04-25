---
title: "How to correct unbalanced parenthesis in smartparens mode"
date: 2025-02-16
lastmode:
description: When I yank code into a `smartparens-mode` buffer and encounter an issue where a closing parenthesis is missing, how to correct the unbalanceed parenthesis efficiently?
tags: [emacs]
categories: [emacs]
series: []
toc: false
math: false
markup: md
draft: false
---

When I yank code into a `smartparens-mode` buffer and encounter an issue where a closing parenthesis is missing, I can manually turn off  `smartparens-mode`, add the closing parenthesis, and then re-enable `smartparens-mode`.

While this approach works, it’s a bit inconvenient. There is a simpler way to correct unbalanced parenthesis. According to this StackOverflow [answer](https://stackoverflow.com/a/26248310 "answer") `quote-insert` (bound by default to <kbd>C-q</kbd>) is unaffected by `paredit-mode`(and also `smartparens-mode`). Simply place your cursor at the point that you want to insert parenthesis, press <kbd>C-q</kbd>, then enter the missing closing parenthesis.
