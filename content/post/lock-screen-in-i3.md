---
title: "How to auto lock screen in i3wm"
date: 2021-04-25
lastmod: 2021-08-01
description:
tags: [i3, linux]
categories: [i3]
series: []
toc: true
math: false
markup: md
draft: false
---

Desktop environments (Gnome, KDE, ...) have an elaborate set of utilities covering almost every aspect of usages. When I started using i3wm, I missed the convenience of power-manager, locking screen, etc. But it is possible to implement them **manually**. This article is written about how auto lock-screen working in i3wm.

<!--more-->

{{< tips warn>}}
Following introduction may be not concise and clear. If you want to see details about the configuration, my dotfiles is [here](https://github.com/qdzhang/.dotfiles/tree/main/.config/i3/autolock).
{{< /tips >}}

There are two parts when configuring autolock. One is **lock**, the other is **auto**.

## How to lock screen?

[i3lock](https://i3wm.org/i3lock/) is a simple screen locker that have synergy with i3wm. If you are using Arch linux, install `i3` package group will install i3lock automatically. And there are several alternatives. Such as [i3lock-color](https://github.com/Raymo111/i3lock-color), [i3lock-fancy](https://github.com/meskarune/i3lock-fancy). They are all wrappers of primitive i3lock to add functions that can change lockscreen pictures and blur background easily.

And what I am using currently is [XSecureLock](https://github.com/google/xsecurelock). XSecurelock provides a simple ascii user interface when lock screen. Ascii art YES!

```
\|/          (__)    
     `\------(oo)
       ||    (__)
       ||w--||     \|/
   \|/
```

All the lockscreen programs can be invoked in the shell manually. Add some keybindings in i3wm will make life easily. Furthermore, Arch wiki provides a useful [snippets](https://wiki.archlinux.org/title/i3#Shutdown,_reboot,_lock_screen) to shutdown, reboot or lock screen in various keystrokes. Adapt it to your demand.

```bash
set $Locker i3lock && sleep 1

set $mode_system System (l) lock, (e) logout, (s) suspend, (h) hibernate, (r) reboot, (Shift+s) shutdown
mode "$mode_system" {
    bindsym l exec --no-startup-id $Locker, mode "default"
    bindsym e exec --no-startup-id i3-msg exit, mode "default"
    bindsym s exec --no-startup-id $Locker && systemctl suspend, mode "default"
    bindsym h exec --no-startup-id $Locker && systemctl hibernate, mode "default"
    bindsym r exec --no-startup-id systemctl reboot, mode "default"
    bindsym Shift+s exec --no-startup-id systemctl poweroff -i, mode "default"  

    # back to normal: Enter or Escape
    bindsym Return mode "default"
    bindsym Escape mode "default"
}

bindsym $mod+Pause mode "$mode_system"
```

## How to **auto** lock screen?

[Xautolock](https://linux.die.net/man/1/xautolock) can be used to invoke preceding locking programs when the computer has been idle for a specified amount of time. And [xidlehook](https://gitlab.com/jd91mzm2/xidlehook) is a general-purpose replacement for xautolock rewritten in Rust. 

I have a script to use xidlehook and i3lock(i3lock-color, i3lock-fancy...) to auto lock screen.

<details><summary>Click to see the script</summary>
<p>


```bash
#!/bin/bash

# Only exported variables can be used within the timer's command.
export PRIMARY_DISPLAY="$(xrandr | awk '/ primary/{print $1}')"

# Run xidlehook
xidlehook \
  `# Don't lock when there's a fullscreen application` \
  --not-when-fullscreen \
  `# Don't lock when there's audio playing` \
  --not-when-audio \
  `# Dim the screen after 300 seconds, undim if user becomes active` \
  --timer 300 \
    'xrandr --output "$PRIMARY_DISPLAY" --brightness .1' \
    'xrandr --output "$PRIMARY_DISPLAY" --brightness 1' \
  `# Undim & lock after 10 more seconds` \
  --timer 10 \
    'xrandr --output "$PRIMARY_DISPLAY" --brightness 1; i3lock' \
	#                                                     │
    #                                                     └───  Replace this command with you lockscreen program or script
    '' \
  `# Finally, suspend an hour after it locks` \
  --timer 1200 \
    'systemctl suspend' \
    ''
```

</p>
</details>

Or, execute `xset` to specify autolock interval. For example, I am using xset cooperate with xsecurelock, the config of i3 is like this:

```bash
exec xset s 300 5
exec xss-lock -n /usr/lib/xsecurelock/dimmer -l -- xsecurelock
```

This combo is the simplest method to auto lock screen in i3wm, and is also the method I am using currently. The only thing you should to do is installing xsecurelock, and put previous two line configurations in you i3 config file. 

Some deeper manipulation, such as the options of XSecurelock, or system suspend and hibernate, is not contained in this article.
