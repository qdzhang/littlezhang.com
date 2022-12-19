---
title: "Magit 中的 timemachine : 查看文件修改历史"
date: 2022-12-19
lastmode:
description: 在 Emacs 中使用 Magit 的 magit-file-dispatch 来模拟 timemachine ，方便地查看文件的修改历史。
tags: [emacs, magit]
categories: [emacs]
series: []
toc: false
math: false
markup: md
draft: false
---

Emacs 中可以使用 [git-timemachine
](https://codeberg.org/pidu/git-timemachine) 浏览 git 仓库中的文件的历史版本，Bozhidar Batsov 在他的一篇[博文](https://emacsredux.com/blog/2014/07/22/travel-back-and-forward-in-git-history/)中比较详细地介绍过这一插件的功能。

但如果你已经在使用 Magit （应该有很多 Emacser 都在用吧），Magit 中的 `magit-file-dispatch` 提供了相似的功能。这样又可以少装一个包了。

`magit-file-dispatch` 默认绑定在 <kbd>C-c M-g</kbd> 上。它会弹出一个 transient menu ，有很多针对当前文件的 actions 。

![magit-transient-menu](https://res.cloudinary.com/dny1wymwm/image/upload/q_auto:eco/v1671449534/compressed_1671449320_p4vu9z.webp)

其中：

- <kbd>p</kbd> ： `magit-blob-previous` ，前一个版本。
- <kbd>n</kbd> ： `magit-blob-next` ，后一个版本。

就构成了 timemachine 的功能。

如果需要一个时间线的概览，在 `magit-file-dispatch` 的 actions menu 上按 <kbd>l</kbd> ，`magit-log-buffer-file` ，就会显示当前文件的 log 。在某一 entry 上按 <kbd>RET</kbd> ，会显示相应的 commit 信息。在 commit 信息中移动光标到 diff 中，按 <kbd>RET</kbd> ，就会进入该 commit 提交时的文件状态。

注意，在 timemachine 中浏览的这些文件都是只读的，想要退出 timemachine  ，只需按 <kbd>q</kbd> 。

---

**参考链接**
- https://old.reddit.com/r/emacs/comments/bcpexy/magit_how_to_quickly_view_the_history_of_a_file/
