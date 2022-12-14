---
title: "Git checkout 的两个替代命令"
date: 2021-03-22
description: Git checkout 包含了很多子命令，可以进行分支的操作，也可以进行文件的操作，看起来有一些混乱。Git 2.23 带来的两个新命令 git switch 和 git restore 就对 git checkout 的这些不合常理的用法进行了语义化的替代。
tags: [git]
categories: [git]
series: []
toc: false
math: false
markup: md
draft: false
---

`git checkout` 可以算是 Git 里最常用的命令之一了，`git checkout [--branch] <branch>` 来切换（新建）分支，`git checkout -- <filename>` 来撤销工作区的文件修改。看上去很让人困惑，为什么分支命令和文件命令都是用 `git checkout`？

Git 也因此在 2.23 版本更新中引入了两个新命令：`git switch` 和 `git restore`。说新其实也不算新了，git 的 [v2.23](https://public-inbox.org/git/xmqqy2zszuz7.fsf@gitster-ct.c.googlers.com/) 在 2019 年 8 月就已经发布了，只是我现在才知道这两个命令 😂。这两个命令分别用来替代 `git checkout` 在“分支”中的功能和在“文件”中的功能，看起来更符合语言上的直觉：switch 来切换分支，restore 来恢复文件。新旧命令对应如下：

| 旧命令                                | 替代命令                            |
| ------------------------------------- | ----------------------------------- |
| `git checkout [-b/--branch] <branch>` | `git switch [-c/--create] <branch>` |
| `git checkout -- <filename> `         | `git restore <filename> `  |

不管新旧命令，都可以添加选项。比如 `git restore <filename>` 其实和 `git restore --worktree <filename>` 一样，都是对 worktree 里的文件进行 restore，同时还有另外一个选项，`git restore --staged <filename>`，作用于 git index 里的文件，即已经 staged 的文件。更多选项和详细的用法，请查看 [git-switch](https://git-scm.com/docs/git-switch/2.23.0) 和 [git-restore](https://git-scm.com/docs/git-restore/2.30.0) 的文档。

需要注意的是，这两个命令推出之初是实验性的，文档也在后续的几个版本略有变化，但上面列举的最常用的两个用法一直没变，而且最近几个版本也没有继续的变化。所以如果你使用的 git 版本够新（v2.23+)，刚开始学习 git 的使用，可以放心地采用更具语义化的、更便于记忆的新命令，不用再困惑于网上的一些教程里一堆混乱的 `git checkout` 命令。如果已经习惯了 `checkout` 的用法，feel free，用你想用的吧。

