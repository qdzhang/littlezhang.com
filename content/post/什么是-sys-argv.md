---
title: 什么是 sys.argv
date: 2019-05-21T12:34:36.410Z
description: 'python入门, sys.argv是什么, python'
tags:
  - Python
categories:
  - Python
toc: true
mathjax: false
---
看到一些 Python 例子中出现 `sys.argv` 这样的用法，于是查了一下，在此记一笔。

`sys` 模块提供了一些跟系统解释器的变量、函数进行交互的接口，`sys.argv` 就是其中的一个。官方文档是这样解释的：

> The list of command line arguments passed to a Python script.

也就是说，`sys.argv` 是一个**列表**，里面的元素是通过命令行传递给 Python 脚本文件的参数。既然是列表，就可以通过索引来访问 `sys.argv` 中的值。举一个小例子。新建一个文件（script）：

```python
# file test.py
import sys
print(sys.argv[0])
```

在命令行里运行：

```python
>>> python test.py
# Output: test.py
```

可以看到输出的是文件名，即 `sys.argv` 列表中的第一个元素是文件名。再来看看列表中的其他元素：

```python
# file test.py
import sys
print(sys.argv[0])
print(sys.argv[1])
```

命令行执行时增加一个参数：

```python
>>> python test.py hello!
# Output: 
# test.py
# hello!
```

如果添加更多的参数，就会顺次输出这些参数。在命令后面添加的参数，就这样依次传入了 `sys.argv` 这个列表中。这样就实现了**命令行（解释器）**和**脚本文件**的交互，也就是实现了一个从程序外部获取参数的桥梁。

那它有什么用呢？目前我自己还没实际用过 `sys.argv`，这个知乎回答里面举了一个简单、巧妙的例子：<a href=" https://www.zhihu.com/question/23711222/answer/386159073"  target="_blank">sys.argv是什么？ - 磨斯的回答 - 知乎</a>。通过这样的一个“桥梁”，我们在写程序的时候，一些需要变化的参数就可以不直接给定，而是从外面获取参数。

