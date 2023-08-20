---
title: "把 git 仓库中的单个文件（文件夹）提取到新仓库"
date: 2022-08-14
lastmode: 2023-08-20
description: 使用 git fast-export 和 fast-import ，把 git 仓库中的一个文件（文件夹）提取出来，建立新的仓库，并保留该文件的所有的历史。
tags: [git]
categories: [git]
series: []
toc: false
math: false
markup: md
draft: false
---

最近我把 [Emacs 配置仓库](https://github.com/qdzhang/vanilla-emacs)里的一些文件整理了出来，想放到新的仓库里，以便更好的复用，同时保持 Emacs 配置尽量精简。如果只是简单地复制粘贴，那么这些文件之前的提交历史就没了。Git 里有两个好用的命令，可以把单个文件的提交历史也“提取”出来。

假设我们要把 A 仓库（`/home/dir/A`）的文件（或是文件夹） f （`/home/dir/A/f`）连同 f 的提交历史一同提取到新仓库 B （`/home/dir/B`），这一过程分为三步：

1. 建立新仓库 B ，并使用 git 初始化，而且需要把 branch 的名称改为和 A 仓库里的 branch 一样（尤其是现在 Github 默认的 `main` branch ，需要特别注意）。
2. 在 A 仓库里使用 `git fast-export` 导出 f 和它的历史。
3. 在 B 仓库里使用 `git fast-import` 导入上一步导出的内容。

其中第 2 、3 步还可以使用 Linux 下的 pipes 一步完成（在仓库 A 的目录下执行下面的命令）：

``` shell
git fast-export HEAD -- f | (cd /home/dir/B && git fast-import
```
`fast-export` 还有更多的参数，比如可以选择要导出的历史的数量，更详细准确的操作请参考[Git 的文档](https://git-scm.com/docs/git-fast-export) 。

上面的步骤完成后，在新仓库 B 目录下执行

``` shell
git checkout
```

就可以在 B 里看到新文件和该文件的历史了。
