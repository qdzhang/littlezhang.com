---
title: "修复 i3pyblocks 在 Python 3.11 下的 asyncio 的兼容性问题"
date: 2023-05-11
lastmode:
description: 在升级 Python 3.11 后，i3pyblocks 的一个依赖项 aionotify 出现了不兼容，本文介绍如何修复它。
tags: [python, arch]
categories: [python]
series: []
toc: false
math: false
markup: md
draft: false
---

今天打开电脑，发现我的 i3 状态栏一片红色，发生甚么事了？哦，原来是昨天，Arch 仓库的 Python 版本升级到了 3.11 ，有一些不兼容更新，把 asyncio 中的 [generator-based coroutines](https://docs.python.org/3.10/library/asyncio-task.html#generator-based-coroutines) 移除了，使 [i3pyblocks](https://github.com/thiagokokada/i3pyblocks) 的一个依赖 [aionotify](https://github.com/rbarrois/aionotify) 坏掉了。

如何修复呢？在 aionotify 中把 `@asyncio.coroutine` decorator 替换成 `async` 关键字，把 `yield from` 替换成 `await` 即可。也可以直接使用这一个已经做了 python 3.11 兼容性更新的 fork 版本的 [aionotify](https://github.com/rickwierenga/aionotify) 。原版的 aionotify 从 2018 年就没再更新了，看来应该也不会再更新了。
