---
title: "Archlinux 安装记录"
date: 2021-01-14 
lastmod: 2023-04-25
description: 按照 arch wiki 的方法安装基本的 archlinux，以及后续的一些基本软件和桌面环境的安装。
summary: 按照 arch wiki 的方法安装基本的 archlinux，以及后续的一些基本软件和桌面环境的安装。
tags: [linux, arch]
categories: [arch]
series: []
toc: true
math: false
markup: md
draft: false
---

{{< tips info 2022-01-29 更新>}}
不知不觉已经使用 Arch Linux 一年多了，中间只有一次“滚挂”的经历，就我的使用体验来说，Arch Linux 其实还挺稳的，这里的“稳”不是指像之前的 CentOS 那样，包的版本稳定，而更多的是“可靠”。Reddit 上经常会有 Arch Linux 是否稳定之类的讨论，我比较认同其中的一个观点：Arch 不 stable ，它的包经常升级，但是足够 reliable 。

文章的部分内容也进行了更新，新增了使用 systemd-boot 的可选步骤。
{{< /tips >}}

用了很长一段时间的 Windows + WSL2，最终我还是回到了 Linux。之前一直用的是 openSUSE，真真是坚如磐石，包括后来换成 Tumbleweed 源，体验一把滚动发行版的感觉，也依旧稳定。甚至中间隔了近一年没更新，直接 `sudo zypper dup` ，也没出一点问题。唯一一点体验不好的地方，就是源太慢。不过这段时间感觉比我刚开始用 openSUSE 的时候快了很多。后来在 Windows 下发现浏览器和 WSL2 能满足我的大部分需求，没有大量的游戏和文档处理的需求，Windows 独占软件只有 Visual Studio，但得益于 .NET5 的发布，也不是刚需。于是就决定回到 Linux 的怀抱。思来想去，决定装上 Arch。

整个安装过程按照 [Arch wiki](https://wiki.archlinux.org/index.php/Installation_guide) 上的步骤，同时参照了这个[视频](https://www.youtube.com/watch?v=8T0vvf1xm58)。这里主要记录一下安装过程，但是如果你也是准备在实机上安装 Arch，请以 Arch wiki 为准，以下内容仅供参考。

## 0.查询电脑型号的适配情况
这一步是很多网上能搜出来的所谓“教程”忽略的一步。直接在搜索引擎里面搜“电脑的型号 + arch”，如果不是特别冷门的设备，arch wiki 里面一般都有设备的各个组件的适配情况，如下图，

![Thinkpad X1 carbon](https://res.cloudinary.com/dny1wymwm/image/upload/v1610786201/thinpad_x1_arch.png)

这是[联想 ThinkPad X1 Carbon (Gen 8) ](https://wiki.archlinux.org/index.php/Lenovo_ThinkPad_X1_Carbon_(Gen_8))的适配情况，可以看到，除了 NFC，其他的设备都是可以正常工作的。而且这个页面里还给出了对应的机型的各种设置，比如休眠、显卡、网卡等等可能需要单独设置的地方。

事先查询，可以心里有底，遇到问题也更好排错。

## 1.调整字体
设置一个大字体，看得更清晰。

```sh
setfont ter-132n
```

## 2.验证引导方式

```sh
ls /sys/firmware/efi/efivars
```

## 3.网络连接

```sh
ip a
ping baidu.com
```

wifi

```sh
iwctl
[iwd] device list
[iwd] station wlan0 scan
[iwd] station wlan0 get-networks
[iwd] station wlan0 connect networkname
[iwd] exit
```

## 4.同步时间

```sh
timedatectl set-ntp true
```

在同步时间的同时，也会进行镜像源的扫描，即使用 [Reflector](https://wiki.archlinux.org/index.php/Reflector) 进行扫描。这是安装系统自己进行的，可以为我们生成 `/etc/pacman.d/mirrorlist` 文件，后面我们直接修改这个文件即可，就不用再创建了。

## 5.选择镜像源(可以放到分区后面进行)

```sh
vim /etc/pacman.d/mirrorlist
# 添加 opentuna
Server = https://opentuna.cn/archlinux/$repo/os/$arch
```

或者使用 reflector 自动选择，见上面的 wiki 链接。



## 6.创建分区
检查现在的分区

```sh
lsblk
或
fdisk -l
```

选择一个需要分区的磁盘（disk）

```sh
gdisk /dev/sda
```

清空当前分区表数据

```sh
o
```

新建一个分区

```sh
# 创建 efi 分区
n
# partition number: default
# first sector: default
# last sector: +512M
L  # 查找 EFI 文件系统
# 输入查找到的 hex code 设置 efi
```

再建一个分区

```sh
# 创建 root 分区
n
# partition number: default
# first sector: default
# last sector: default(就是全盘大小)(选择一个合适的大小)
```

如果想要 home 分区和 root 分区分开，就再建一个分区

```sh
# 创建 home 分区
n
# partition number: default
# first sector: default
# last sector: default(就是全盘大小)
```

最后确认，写入分区：

```sh
w
```

如果有第二块硬盘，可以为第二块硬盘再建一个分区，挂载到 `/data`。我的第二块硬盘是 HDD，所以我这样单独挂载。（我最近换了一块 SATA 的固态硬盘，所以又写了[一篇文章]({{< ref "archlinux-extra-hard-disk" >}})来介绍如何挂载一块新的硬盘。）

## 7.格式化分区

```sh
mkfs.fat -F32 /dev/[efi partition name]
mkfs.ext4 /dev/[root partiton name]
mkfs.ext4 /dev/[home partiton name]
mkfs.ext4 /dev/[second disk partiton name]
```

## 8.挂载分区

```sh
mount /dev/[root partition name] /mnt  # 挂载root
mkdir -p /mnt/boot/efi
mount /dev/[efi partition name] /mnt/boot/efi  # 挂载 efi
mkdir /mnt/home
mount /dev/[home partition name] /mnt/home

mkdir /mnt/data
mount /dev/[second disk part] /mnt/data
```

在 `data` 目录下可以新建用户目录，比如 `/data/username` 建立 symlink 把 ssd 上 `home` 目录下的一些文件夹移动到 hhd 上。如果不行，可以试试 bind mount，在下面[生成分区表](#10.生成分区表)之后修改 fstab，如下:

```sh
/original/location/here  /copy/of/it/here  none  bind
```

## 9.安装基本包

```sh
pacstrap /mnt base linux linux-firmware vim intel-ucode  # 如果是 amd 的 CPU，安装 amd-ucode
```

这里可以安装 `linux-lts`。

## 10.生成分区表

```sh
genfstab -U /mnt >> /mnt/etc/fstab
cat /mnt/etc/fstab  # 检查 fstab
```

## 11.进入安装系统

```sh
arch-chroot /mnt
```

## 12.创建 swapfile

```sh
dd if=/dev/zero of=/swapfile bs=1G count=8 status=progress
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
```

把 swapfile 写入 fstab

```sh
vim /etc/fstab
/swapfile none swap defaults 0 0
```

## 13.设置时区

```sh
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
hwclock --systohc
```

## 14.设置 locale
直接编辑locale文件

```sh
vim /etc/locale.gen
```

把 
- zh_CN.UTF-8 UTF-8 
- zh_HK.UTF-8 UTF-8 
- zh_TW.UTF-8 UTF-8 
- en_US.UTF-8 UTF-8

注释掉
然后执行

```sh
locale-gen
```

创建locale配置文件

```sh
vim /etc/locale.conf
```

在配置文件第一行写入

```sh
LANG=en_US.UTF-8
```

## 15.设置主机名

```sh
vim /etc/hostname
```

文件第一行写入主机名，比如 `arch`

编辑 hosts 文件

```sh
vim /etc/hosts
```

在末尾添加

```sh
127.0.0.1	localhost
::1		    localhost
127.0.1.1	arch.localdomain	arch
```

## 16.设置root密码

```sh
passwd
```

## 17.安装其他的包

```sh
pacman -S grub efibootmgr networkmanager network-manager-applet dialog mtools dosfstools NTFS-3G base-devel linux-headers git bluez bluez-utils xdg-utils xdg-user-dirs pulseaudio pulseaudio-alsa pulseaudio-bluetooth pavucontrol alsa-utils noto-fonts-cjk mesa vulkan-intel
```

如果前面安装的 linux-lts，这里也要相应安装 linux-lts-headers。

## 18.配置 Boot Loader

### 18.1 使用 GRUB

```sh
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
```

生成 grub 配置

```sh
grub-mkconfig -o /boot/grub/grub.cfg
```

### 18.2 使用 systemd-boot

给 bootctl 指定路径

```sh
bootctl --path=/boot/efi install
```

如果是在 QEMU 里面安装，想要使用 UEFI 的话，需要在宿主机安装 `edk2-ovmf` 包，才可以为 QEMU [提供 UEFI 启动选项](https://wiki.archlinux.org/title/PCI_passthrough_via_OVMF#Setting_up_an_OVMF-based_guest_VM)。

编辑 `/boot/loader/loader.conf`:

```pacmanconf
default  arch.conf
timeout  4
console-mode max
```

添加启动项，新建 `/boot/loader/entries/arch.conf`:

```pacmanconf
title   Arch Linux
linux   /vmlinuz-linux
initrd  /intel-ucode.img
initrd  /initramfs-linux.img
options root="LABEL=arch_os" rw
# 这里填 root 所在分区，比如我在虚拟机安装，则为 /dev/vda2
```

## 19.开启一些必要的 systemd 服务
```sh
systemctl enable NetworkManager
systemctl enable bluetooth
```

如果使用无线网的话，可以把 `wpa_supplicant` 的服务也打开。更详细的设置参见 [Arch Wiki](https://wiki.archlinux.org/title/wpa_supplicant) 。

```sh
systemctl enable wpa_supplicant.service
```

也可以使用 `iwd` 替代 `wpa_supplicant` 作为 NetworkManager 的后端，详细设置参见 [Arch Wiki](https://wiki.archlinux.org/title/NetworkManager#Using_iwd_as_the_Wi-Fi_backend) 。

## 20.添加普通用户

```sh
useradd -mG wheel username
passwd username
```

给用户 sudo 权限

```sh
EDITOR=vim visudo
```

把`%wheel all=(all) all`这一行注释掉

## 21.退出并重启

```sh
exit  #退出chroot环境
umount /mnt/boot/efi
umount /mnt
reboot
```

## 22.安装桌面

```sh
sudo pacman -S xorg lightdm lightdm-gtk-greeter lightdm-gkt-greeter-settings firefox xfce4 xfce4-goodies gvfs libreoffice ...
```

启动 lightdm 的 `systemd` 服务。

```sh
sudo systemctl enable lightdm.service
```

如果不想使用各种 Display Manager，可以直接修改 `~/.xinitrc`，之后在 tty 登录后，输入 `startx` 就可以直接进桌面了。查看相关桌面环境的 wiki，里面介绍的很详细。

```sh
reboot
```

如果没有自动生成家目录下的这个分类的目录，比如 Videos、Documents之类的，可以运行下面的命令。如果想要自己管理的，就不用了。

```sh
xdg-user-dirs-update  # 生成家目录的文件夹
```
<hr>
Update:

## 安装后的一些设置

### 更改笔记本电脑合盖后的行为

修改 `/etc/systemd/logind.conf`

```pacmanconf
HandleLidSwitch=lock  # 把合盖后的行为改为锁屏，如果是休眠的话，有时候会不能正常唤醒
```

### 更改 Firefox 的 DPI

在 `about:config` 里修改 `layout.css.devPixelsPerPx` 为 `1.5` 或其他更大、更小数值。

### 设置 NTP 时间同步

使用 `systemd-timesyncd` 。先查看服务是否开启：

```sh
systemctl is-enabled systemd-timesyncd.service
```

如果显示 disabled ，则开启它：

```sh
systemctl enabled systemd-timesyncd.service --now
```

在 `/etc/systemd/timesyncd.conf` 中更改 NTP 服务器（我这里用了阿里云的 NTP 服务器）：

```pacmanconf
[Time]
NTP=ntp1.aliyun.com
FallbackNTP=ntp3.aliyun.com ntp2.aliyun.com 0.arch.pool.ntp.org 1.arch.pool.ntp.org 2.arch.pool.ntp.org 3.arch.pool.ntp.org
#...
```
使用 `timedatectl status` 查看 timesyncd 的状态：

```pacmanconf
NTP service: active
```
即为开启成功。
