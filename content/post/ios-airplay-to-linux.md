---
title: "Connect iOS devices to Linux using Screen Mirroring"
date: 2021-10-08
lastmod:
description: Use an open source implementation of AirPlay named UxPlay to mirror iOS device screen to Linux
tags: [linux, 折腾]
categories: [linux]
series: []
toc: true
math: false
markup: md
draft: false
---

Using AirPlay, you can easily connect almost all your Apple devices and some third-party AirPlay-compatible smart TVs. But how to use AirPlay to mirror the screen of iPhone or iPad on Linux?

## 1. Install required packages

[UxPlay](https://github.com/FDH2/UxPlay) is an open source program that can make your Linux device as an AirPlay mirroring server. There is an [aur package](https://aur.archlinux.org/packages/uxplay-git/) if you are using Arch Linux. As for other distros, there are detailed building guides on the UxPlay Github repository.

## 2. Start the Airplay mirroring server

After installing UxPlay, some extra systemd services need to be started.

```bash
systemctl start avahi-daemon
```

Then open UxPlay.

```bash
uxplay
```

## 3. Select your Linux device to connect

Now open iOS control center, tap on the Screen Mirroring, you can find your Linux device as 'UxPlay@hostname', select it, and wait a minute. Your iOS device will connect to the Linux device.

## 4. Some extra settings

If you have configured [auto lock](https://www.littlezhang.com/2021/04/how-to-auto-lock-screen-in-i3wm/) on Linux, UxPlay will not prevent the desktop becoming idle and it may auto lock after a moment. So there are some extra settings to fix it.

We can modify DPMS(Display Power Management Signaling) and screensaver settings with a command.

```bash
xset s off -dpms
```

This command will disable DPMS and prevent screen from blanking.

I wrap all of the preceding steps into a [shell script](https://github.com/qdzhang/.dotfiles/blob/main/.local/bin/airplay-start). It will open AirPlay mirroring server conveniently. And [this script](https://github.com/qdzhang/.dotfiles/blob/main/.local/bin/airplay-stop) will close the Airplay mirroring server and resume auto-lock settings.
