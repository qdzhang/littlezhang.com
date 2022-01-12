---
title: "One Small Tip for Goldendict"
date: 2021-12-02
lastmod: 2022-01-12
description: Some Goldendict tips
tags: [software]
categories: [software]
series: []
toc: false
math: false
markup: md
draft: false
---

In [Goldendict](http://goldendict.org/), hotkey <kbd>Alt-s</kbd> is useful to pronounce current word. And I set [mpv](https://mpv.io/) as the external program. But after I configure mpv with much custom tweak and plugins, this keybinding no longer work. Maybe some configurations make Goldendict can not invoke mpv to play audio.

Finally, I find a simple way to fix it. There is no need to set up mpv to compatible with Goldendict. Using `mpv --no-config` as the external program will use a pure mpv without any custom configuration. And Goldendict will invoke a vanilla mpv for the audio playback.

![](https://res.cloudinary.com/dny1wymwm/image/upload/v1641993100/goldendict-mpv-config_l0vsdi.png)
