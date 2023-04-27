---
title: "Arch Linux 挂载第二块硬盘"
date: 2023-04-21
lastmode: 2023-04-27
description: 如何在 Arch Linux 安装后，挂载一块新的硬盘。
tags: [linux,arch]
categories: [linux,arch]
series: []
toc: true
math: false
markup: md
draft: false
---

如果在[安装 Arch Linux]({{< ref "archlinux-installation" >}}) 后，想要挂载另外一块硬盘，可以按以下步骤操作：

## 1. 创建分区
先检查现在的分区

```sh
lsblk
或
fdisk -l
```

记下新安装的磁盘，比如说，`/dev/sda` ，对该磁盘分区

```sh
gdisk /dev/sda # 我更习惯于使用 gdisk ，使用其他的分区工具亦可
```

清空当前磁盘数据

```sh
o
```

新建一个分区

```sh
# 创建新分区
n
# partition number: default
# first sector: default
# last sector: default(就是全盘大小)(也可以选择一个合适的大小，如果你想要更多的分区的话)
```

确认，写入分区

```sh
w
```

## 2. 格式化分区

使用 `lsblk` 查看新的分区表，这时在 `/dev/sda` 磁盘之下应该有一个类似 `/dev/sda1` 的分区，格式化该分区，这里我使用的是 ext4 文件格式，如果想用其他的也可以

```sh
mkfs.ext4 /dev/sda1
```

## 3. 挂载分区

先挂载可以启动的、正常的系统的各个分区

```sh
mount /dev/[root partition name] /mnt  # 挂载root
mkdir -p /mnt/boot/efi
mount /dev/[efi partition name] /mnt/boot/efi  # 挂载 efi
mkdir /mnt/home
mount /dev/[home partition name] /mnt/home
```

再挂载这块新硬盘所代表的分区到 `/mnt/data`

```sh
mkdir /mnt/data
mount /dev/sda1 /mnt/data
```

## 4. 生成分区表

```sh
genfstab -U /mnt >> /mnt/etc/fstab
cat /mnt/etc/fstab  # 检查 fstab
```

这时在 `/mnt/etc/fstab` 中应该就能看到新的硬盘的 entity 了

## 5. 配置 Boot Loader

这里以 GRUB 为例。先进入 chroot

```sh
arch-chroot /mnt
```

安装 grub 到硬盘

```sh
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
```

生成 grub 配置

```sh
grub-mkconfig -o /boot/grub/grub.cfg
```

新的硬盘就可以在 Linux 系统启动后在 `/data` 挂载点看到了。后续还需要一些其他的设置。

## 6. 建立 Symlinks

这时可以在新的 `/data` 文件夹下建立一个新的 Home 目录 `/data/[user]`，在这个 Home 里建立原来的 Home 里的 symlinks ，比如 `Downloads` 文件夹

```sh
ln -s /data/[user]/Downloads/ /home/[user]/Downloads
```

这里要注意设置 `/data` 里文件的 owner 和 group ，这样我们才能正常读写新硬盘上的这些文件

```sh
sudo chown [owner]:[group] -R /data/Downloads/
```

## 7. 设置回收站（trash-cli）

我在 Arch Linux 上使用[trash-cli](https://github.com/andreafrancia/trash-cli) 作为符合 [freedesktop.org 标准](https://freedesktop.org/wiki/Specifications/trash-spec/)的回收站，配合 pcmanfm 很好用（在 Arch Linux 上需要安装 `gvfs` 这个包）。要想使新硬盘上的文件删除时也进入回收站，需要在 `/data` 下建立一个新文件夹 `.Trash-<uid>` ，我的 uid 是 1000，所以这里是 `.Trash-1000` 。然后更改 `/data/.Trash-1000` 的 owner 和 group

```sh
sudo chown [owner]:[group] -R /data/.Trash-1000/
```

至此，新的硬盘已经挂载、设置好了。
