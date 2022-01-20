---
title: "提高博客加载速度：PNG 图片压缩"
date: 2022-01-20
lastmod:
description: 对博客中的图片进行压缩，可以显著提高网站的加载速度，同时也能节省传输流量。本文对比几种本地压缩的程序，尽力达到既清晰，压缩后的大小又小。
tags: [建站]
categories: [建站]
series: []
toc: false
math: false
markup: md
draft: false
---

博客中如果插入的图片太多，而且不经压缩的话，不仅影响读者体验，还会造成很多额外的图片分发网络的流量。虽然我没有太多读者，流量压力也不大，不过谁又不想让网站加载更快呢？

让图片变小有多种方法，压缩是一种，换用更高效的格式也是一种，比如使用 webp 格式。本文主要讨论“压缩”这一种方法。

之前我一直在用 [tinypng](https://tinypng.com/) 在线压缩图片，压缩效果很好，又小又清晰。但毕竟是在线服务，总觉得不太方便。虽然 tinypng 提供 API ，也有很多程序去调用 API 来使用，但还是需要上传图片。那么能不能在本地完成压缩，来达到类似 tinypng 的压缩效果呢？

当然可以。我最常使用的图片格式是 PNG ，所以后面就只讨论 PNG 的压缩工具。
[Mozilla 的 wiki](https://wiki.mozilla.org/Mobile/Janus#PNG_Compression) 中对比了几种常用的图片压缩的应用程序，如果需要压缩其他格式的，可以参考。

不算各种封装其他工具的 GUI 程序，PNG 压缩程序大概能分成两种：有损（lossy）压缩和无损（lossless）压缩。我们既然想要在不大幅度影响画质的前提下，使图片体积最小，不妨有损压缩和无损压缩混合使用。先使用有损压缩，大幅缩小图片体积，再使用无损压缩，进一步缩减图片体积。

有损压缩最常用、效果最好的程序是 [pngquant](https://pngquant.org/) ，据说 tinypng 后台也使用的它。pngquant 是一个开源的图片压缩工具，可以缩减图片 70% 的体积。以前我用它的时候，它还是纯 C99 写的，现在作者在用 rust 进行重写了。

可以采用下面的参数，来用最慢的速度（其实也不慢）保持画质的同时尽量压缩：

```sh
pngquant --speed 1 --strip --verbose input.png -o output.png
```

这样就能得到一个压缩得很小的图片了。

更进一步，对 pngquant 压缩过的图片再次进行无损压缩。

无损压缩的工具就更多了，[pingo](https://css-ig.net/pingo) （一个 windows 平台下的图片压缩程序） 的作者做了一份详细的无损压缩的[基准测试](https://css-ig.net/benchmark/png-lossless) 。参考这份基准测试，我在我自己的电脑上也进行了测试，最终选出了两个压缩效果最好的程序：[zopfli](https://github.com/google/zopfli) 和 [ect](https://github.com/fhanau/Efficient-Compression-Tool) 。（从上面那份基准测试里可以发现 pingo 的压缩率也相当的好，不过它仅能在 windows 平台上运行。）

zopfli 是 Google 开发的压缩算法，同时也包含一个名为 [zopflipng](https://github.com/google/zopfli/blob/master/README.zopflipng) 的图片压缩程序。我们使用 zopflipng 程序：

```sh
zopflipng -m --lossy_transparent input.png output.png
# 注意！这里的 input.png 应为上一步 pngquant 压缩后的图片
```

使用的 ect 的参数为：

```sh
ect -9 --mt-deflate --mt-file -strip input.png
# 注意！这里的 input.png 应为上一步 pngquant 压缩后的图片
# 而且 ect 压缩后会覆盖原图片，注意备份
```

zopfli 压缩的效果和 ect 的效果类似，肉眼分辨不出画质的区别，压缩后大小基本相同。

为了方便起见，我把上面有损压缩和无损压缩的两步过程写成了一个 shell 脚本，免去了各种输入文件名、存储 pngquant 压缩后的中间文件这些繁琐过程：

```sh
#!/bin/sh

# Use pngquant and zopflipng to compress png images
# The final result is similar to tinypng.com

file_seed="$(date +%s)"
pngquant --speed 1 --strip --verbose $1 -o temp_$file_seed.png
echo "========= zopflipng compressing ========= "
zopflipng -m --lossy_transparent temp_$file_seed.png compressed_$file_seed.png
echo "Deleting temp file..."
rm temp_$file_seed.png
echo "Done."
```

你可以在我的 [dotfiles 仓库](https://github.com/qdzhang/.dotfiles/blob/main/.local/bin/png-tiny)里看到这个脚本，我把它取名 png-tiny 。这个脚本读取命令行第一个参数，一次处理一张图片，压缩后的图片大小基本与 tinypng 压缩后的大小相同。

图片压缩后也只是第一步，懒加载（lazy-loading）也可以带来更快的网页浏览体验，我的这个[博客主题](https://github.com/qdzhang/hugo-notepadium-mod)就支持懒加载。之后我再写写懒加载的一些方法。
