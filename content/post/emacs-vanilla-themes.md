---
title: "几个好看的 Emacs 自带主题"
date: 2022-05-10
lastmode:
description:
tags: [emacs]
categories: [emacs]
series: []
toc: true
math: false
markup: md
draft: false
---
 
最近完全地把 Emacs 配置切换到原生按键上了（之前用的 Evil 来模拟 Vim )。经过折腾，发现很多 Emacs 自带的功能就很强大了，以前使用的很多包都没必要再使用了。而且还发现了几个很好看、合我口味（香草味的！）的自带主题，在此分享一下。

## Modus themes

这款主题是在 Emacs 28 才变成 built-in 的，之前的版本也可以使用，需自行安装，主页在[这里](https://protesilaos.com/emacs/modus-themes) 。配色很清晰，严格按照 [WCAG AAA](https://www.w3.org/WAI/WCAG2AAA-Conformance) 进行设计，简洁又精致，而且适配了很多包。

![modus-themes](https://res.cloudinary.com/dny1wymwm/image/upload/v1652188816/compressed_1652188488_m4sqai.png)

## Wombat

很温和的一款深色主题，对比度适中，有点 Monokai 的感觉，而且对于 Emacs 28 中新加入的 fido-vertical-mode 也非常友好，易于辨识。

![wombat-theme](https://res.cloudinary.com/dny1wymwm/image/upload/v1652188817/compressed_1652188410_ueifb6.png)

美中不足的是，cursor 的颜色太不明显，可以通过下面的配置设置成其他更鲜艳的颜色。

``` elisp
(load-theme 'wombat)

(custom-theme-set-faces
 'wombat
 '(cursor ((t (:background "#abb2bf")))))

(enable-theme 'wombat)
```

这里要注意，使用 `custom-theme-set-faces` 自定义主题的一些颜色后，一定要使用 `enable-theme` 来使这个自定义生效。

## Misterioso

绿色风格的深色主题，有点类似 solarized-dark 的背景，对比度更高，看起来也很舒服。

![misterioso-theme](https://res.cloudinary.com/dny1wymwm/image/upload/v1652188816/compressed_1652188430_cps7s3.png)

和上面的 wombat 主题类似，需要自定义一下 cursor 的颜色，用起来才更完美。

``` elisp
(load-theme 'misterioso)

(custom-theme-set-faces
 'misterioso
 '(cursor ((t (:background "#abb2bf")))))

(enable-theme 'misterioso)
```

## （xahlee 风格的）默认主题

就是使用 `emacs -q` （不加载配置文件）启动时的浅色主题。这个默认主题有深浅两种，可以通过下面的配置设置：

``` elisp
;; Default light theme
(set-background-color "white")
(set-foreground-color "black")

;; Default dark theme
(set-background-color "black")
(set-foreground-color "white")
```

我更喜欢这款白色的主题。默认主题的最大优势就是完美适配几乎所有插件。在白色的基础上，稍加设置，就可以得到 [xahlee](http://xahlee.info/) 同款的浅绿色护眼主题！

``` elisp
;; initial window settings
(setq initial-frame-alist
      '((background-color . "honeydew")))

;; subsequent window settings
(setq default-frame-alist
      '((background-color . "honeydew")))
```

![xahlee-green-theme](https://res.cloudinary.com/dny1wymwm/image/upload/v1652188816/light-green_mnqrer.png)

其实我现在用的就是 xahlee 同款，所以我才把它放在压轴出场。
