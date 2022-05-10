---
title: "一个简单的 REPL"
date: 2022-05-09
lastmode:
description: 使用 common lisp 实现一个超级简单的 REPL
tags: [emacs]
categories: [emacs]
series: []
toc: false
math: false
markup: md
draft: false
---

REPL 代表 Read-Eval-Print Loop ，在开发中可以提供很多便利。具体的含义、操作不详述，网上也有很多介绍的文章。我用 REPL 也有段时间，不想今天看的一本书中，极其简单地实现一个 REPL ，很有意思。以下代码使用 common-lisp 实现。

```lisp
(defun simple-repl ()
  (loop (print (eval (read)))))
```

就是把 REPL 四个字母代表的四个动作，分别对应的函数，按照 read-eval-print-loop 的顺序从内到外运行，之后运行 `simple-repl` 这个函数，这个极简的 REPL 就跑起来了，可以在里面执行所有合法的函数了。Lisp 中的一些思想确实很精妙。
