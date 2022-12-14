---
title: "Emacs 中的 change-log-mode"
date: 2022-12-14
lastmode:
description: 使用 Emacs 中的 change-log-mode 可以很方便地编写 changelog 。
tags: [emacs, TIL]
categories: [emacs]
series: []
toc: false
math: false
markup: md
draft: false
---

Emacs 中自带的 `change-log-mode` 可以很方便地编写 gnu-style[^1] 的 changelog 。新建名为 `ChangeLog` 的文件，只需使用一个命令： `add-change-log-entry-other-window`[^2] ，默认绑定在 <kbd>C-x 4 a</kbd> 上，就可以在 `ChangeLog` 中添加一个新项，并且 Emacs 会自动把当前修改的文件和函数作为新项的起始，如下面的示例[^3]（可通过设置 `user-full-name` 和 `user-mail-address` 来控制“名字”和“电子邮箱”）：

```
1993-05-25  Richard Stallman  <rms@gnu.org>

        * man.el: Rename symbols 'man-*' to 'Man-*'.
        (manual-entry): Make prompt string clearer.

        * simple.el (blink-matching-paren-distance):
        Change default to 12,000.

1993-05-24  Richard Stallman  <rms@gnu.org>

        * vc.el (minor-mode-map-alist): Don't use it if it's void.
        (vc-cancel-version): Doc fix.
```

[^1]: https://www.gnu.org/prep/standards/html_node/Change-Logs.html#Change-Logs

[^2]: https://www.gnu.org/software/emacs/manual/html_node/emacs/Change-Log-Commands.html

[^3]: https://www.gnu.org/software/emacs/manual/html_node/emacs/Format-of-ChangeLog.html
