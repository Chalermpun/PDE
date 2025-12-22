# Docker with QEMU

## Install QEMU
### Debian & Ubuntu

```bash
sudo apt-get install qemu-system
```

### Termux

```bash
pkg update ; pkg install wget qemu-system-x86-64-headless qemu-utils -y
```

## Run QEMU

```bash
mkdir ~/alpine ; cd ~/alpine 
wget -O alpine.iso http://dl-cdn.alpinelinux.org/alpine/v3.20/releases/x86_64/alpine-virt-3.20.2-x86_64.iso
```

```bash
qemu-img create -f qcow2 alpine.qcow2 10G
```

```bash
qemu-system-x86_64 -m 512 -netdev user,id=n1,hostfwd=tcp::2222-:22 -device virtio-net,netdev=n1  -cdrom alpine.iso -nographic alpine.qcow2
```

## Setup Network
```bash
mkdir -p /etc/udhcpc
echo "RESOLV_CONF=no" >> /etc/udhcpc/udhcpc.conf
echo "nameserver 8.8.8.8" >> /etc/resolv.conf
echo "nameserver 8.8.4.4" >> /etc/resolv.conf
```

## Setup Alpine
```bash
setup-alpine
```
```text
 ALPINE LINUX INSTALL
----------------------

 Hostname
----------
Enter system hostname (fully qualified form, e.g. 'foo.example.org') [localhost]

 Interface
-----------
Available interfaces are: eth0.
Enter '?' for help on bridges, bonding and vlans.
Which one do you want to initialize? (or '?' or 'done') [eth0]

Do you want to do any manual network configuration? (y/n) [n]


Root Password
---------------
Changing password for root
New password:
Bad password: too weak
Retype password:
passwd: password for root changed by root


Timezone
----------
Africa/            Egypt              Iran               Poland
America/           Eire               Israel             Portugal
Antarctica/        Etc/               Jamaica            ROC
Arctic/            Europe/            Japan              ROK
Asia/              Factory            Kwajalein          Singapore
Atlantic/          GB                 Libya              Turkey
Australia/         GB-Eire            MET                UCT
Brazil/            GMT                MST                US/
CET                GMT+0              MST7MDT            UTC
CST6CDT            GMT-0              Mexico/            Universal
Canada/            GMT0               NZ                 W-SU
Chile/             Greenwich          NZ-CHAT            WET
Cuba               HST                Navajo             Zulu
EET                Hongkong           PRC                leap-seconds.list
EST                Iceland            PST8PDT            posixrules
EST5EDT            Indian/            Pacific/

Which timezone are you in? [UTC]


 Proxy
-------
HTTP/FTP proxy URL? (e.g. 'http://proxy:8080', or 'none') [none]

Which NTP client to run? ('busybox', 'openntpd', 'chrony' or 'none') [chrony] none



APK Mirror
------------
 (f)    Find and use fastest mirror
 (s)    Show mirrorlist
 (r)    Use random mirror
 (e)    Edit /etc/apk/repositories with text editor
 (c)    Community repo enable
 (skip) Skip setting up apk repositories

Enter mirror number or URL: [1]



 User
------
Setup a user? (enter a lower-case loginname, or 'no') [no]



Which ssh server? ('openssh', 'dropbear' or 'none') [openssh]

Allow root ssh login? ('?' for help) [prohibit-password] yes


Enter ssh key or URL for root (or 'none') [none]


 Disk & Install
----------------
Available disks are:
  fd0   (0.0 GB  )
  sda   (1.1 GB QEMU     QEMU DVD-ROM    )


Which disk(s) would you like to use? (or '?' for help or 'none') sda

How would you like to use it? ('sys', 'data', 'crypt', 'lvm' or '?' for help) [?] sys

WARNING: Erase the above disk(s) and continue? (y/n) [n] y
```

## Install Docker
```bash
echo "http://dl-cdn.alpinelinux.org/alpine/v3.20/community" >> /etc/apk/repositories
apk update
apk add docker
service docker start
service docker stop

dockerd -H tcp://0.0.0.0:2375 --iptables=false
```

## Create bash script

```bash
echo "qemu-system-x86_64 -m 4G -netdev user,id=n1,hostfwd=tcp::2345-:2345 -device virtio-net,netdev=n1 -nographic alpine.qcow2" >> ~/alpine/alpine.sh
```

```bash
bash alpine.sh
```
