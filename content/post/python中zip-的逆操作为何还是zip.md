---
title: Python中zip()的逆操作为何还是zip()
date: 2019-05-11T04:51:06.432Z
description: >-
  python, python 入门, python 初学, python 函数, zip 函数, 详解 Python zip() 函数的用法,
  python笔记
tags:
  - Python
categories:
  - Python
toc: false
mathjax: false
---
`zip()` 是Python 中的内置函数，用于将多个可迭代对象“链”在一起（我没有想出一个贴切的中文来解释这个函数，网上有用“打包”、“压缩”这些说法的，但感觉都不太贴切）。按照惯常思维，有了 `zip()`，应该还要有它的逆操作 `unzip()`。但我在之前刚开始学 Python 的时候，看到书上有这样的一句话：

> 与 `zip()` 相反的函数还是 `zip()`。

看到就蒙了，这是个什么原理？而且网上也有很多人问过这样的问题[^1][^2]，回答大概就是要用 `zip(*)` 来进行这个相反的操作。当时对可变参数、迭代器、生成器什么的都一知半解，就没能很好的理解这句话。现在又看到这个问题，发现其实也不是很难理解。

问题关键就在于，`zip()` 可以接受多个参数，也就是说，可以链接任意数量的迭代器或是可迭代序列。我们用一个例子来看。

```python
>>> list_1 = [1, 2, 3]
>>> list_2 = ['a', 'b', 'c']
>>> list_zipped = zip(list_1, list_2)
>>> print(list_zipped)
# Output: <zip object at 0x00000...>
```

这时如果我们直接用 `print()` 函数打印 `list_zipped` ，会发现，输出值是 `<zip object>`，并不是我们想要的。这是因为 `zip()` 函数的返回值是一个元组迭代器（iterator of tuples），而如果我们想要把迭代器作为函数的参数，就要用到可变参数。

 稍微解释一下可变参数。可变参数在不确定要传入多少参数时使用，通常表示为`*args`、`**kwargs`。参数名叫什么无所谓，重要的是参数前面的 `*` 号：一个 `*` 号代表将多个参数展开为列表，两个 `*` 号则代表将多个键-值参数展开为字典。这里我们只用到不带键-值的可变参数，就是只带一个星号的参数。

回到正题。如果我们直接用 `print(list_zipped)` ，就是把 `list_zipped` 作为一个参数传给了 `print()`，所以输出的是 `list_zipped` 本身，就是`zip object`。想要输出 `list_zipped` 这个迭代器的里的每一项，就要把它里面的所有项作为多个参数传入，如下：

```python
>>> print(*list_zipped)
# Output: (1, 'a') (2, 'b') (3, 'c')
```

这是 `zip()` 的功能。接着，我们来进行它的逆操作。这里有一个小细节需要注意， `zip()` 的本质是一个生成器[^3]，经过一次迭代后，就用尽了，后面就无法再进行迭代，所以我们需要要重新构造一次。

```python
>>> list_zipped = zip(list_1, list_2)
>>> new_list_1, new_list_2 = zip(*list_zipped)
>>> new_list_1
# Output: (1, 2, 3)
>>> new_list_2
# Output: ('a', 'b', 'c')
```

第二行就是进行 `zip()` 的逆操作。本质还是 `zip()` 可以接受任意多个参数，所以我们就对 `zip()` 传入可变参数。看下图可以更直观地理解这一过程。

![python_zip](https://res.cloudinary.com/dny1wymwm/image/upload/v1557636609/python_zip_jwnyeb.png)

①处的 `zip()`将两个 `list` （`list_1` 和 `list_2`）“链”为一个 `tuple`（`list_zipped`），再把这个 `tuple` 的每一项作为参数，传给②处的 `zip()`，`zip()` 对这三个可迭代对象进行压缩链接，就“链”成了 `new_list_1` 和 `new_list_2`。因为是传入的多个参数，所以要用可变参数 `*list_zipped` 。这样就完成了 `zip()` 函数的逆操作。



[^1]: https://stackoverflow.com/questions/19339/transpose-unzip-function-inverse-of-zip
[^2]: https://stackoverflow.com/questions/12974474/how-to-unzip-a-list-of-tuples-into-individual-lists
[^3]: Python 文档中给出了一个简单的 `zip()` 函数的实现，可以大致看出其中原理。https://docs.python.org/3.7/library/functions.html#zip
