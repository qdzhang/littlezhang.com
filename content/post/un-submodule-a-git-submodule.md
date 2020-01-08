---
title: "如何把 Git Submodule 变成普通文件夹"
date: 2020-01-08
tags: ["git", "开发"]
categories: ["开发"]
imgs: []
toc: false
math: false
---

使用 `git submodule` 可以非常方便地在 Hugo 站点中添加主题，而且可以紧跟主题版本，快速拉取主题作者的最新改动。如果我不想继续跟进版本更新，如何才能取消 submodule 与远程的同步，而跟随主仓库的版本呢？

我想要实现的是把 Git Submodule 变成普通文件夹。这需要两步：**先删除 Git Submodule（删除所有相关的git配置文件即可），再把 submodule 中的文件添加到主仓库**，就可以了。

删除 Git submodule 的命令：
```shell
git rm --cached submodule_path  # 删除指向submodule HEAD的引用
git rm .gitmodules              # 删除主仓库根目录下的.gitmodule配置文件
rm -rf submodule_path/.git      # 删除submodule目录下的.git配置文件
```

添加 submodule 文件夹的命令：
```shell
git add submodule_path          # 添加原先 submodule 中的所有文件到主仓库里
git commit -m "xxxxxx"          # 提交改动，完成目标
```

在 stackoverflow 上有网友[编写了一个 shell 脚本](https://stackoverflow.com/questions/1759587/un-submodule-a-git-submodule/43554035#43554035)，可以简单地用一行命令来实现 **git submodule 到普通文件夹的转换**。当然，需要自行承担风险，有能力的话，也可以去查看脚本的源代码，进行适合自己的修改。