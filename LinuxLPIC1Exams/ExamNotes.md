# LPIC 1 Exam Notes

## Resources
http://www.gocertify.com/quizzes/linux-practice-questions/linux-lpi101-lx0101-quiz.html

https://itbeginner.net/linux-essentials-exam-answer-test-online-pdf
https://itbeginner.net/linux-essentials-chapter-1-test-online-2016.html

https://www.lpi.org/our-certifications/exam-101-objectives

https://developer.ibm.com/tutorials/l-lpic1-map/

http://www.linuxdoc.org/ - BEST first internet site to go to for information about how to perform an unfamiliar Linux task

youtube videos?
https://www.youtube.com/user/AnthonyIrwinVideos/playlists
The Linux Man:  https://www.youtube.com/channel/UCVQ7kPpJJ2FA_iYl8Wtx0SA

6 year old lpic
https://www.youtube.com/watch?v=HMpB28l1sLc&list=PLtGnc4I6s8dvO8uBaSn1udaBNhg0SO4W2

## To Be sorted

* Partitions /dev/sd[a,b,c][1,2,3]  (sda1 is first partition of first drive)
* `sudo fdisk -l /dev/sda`
* `swapon -summary`
* mkdir -p Projects/{ancient,classical,medieval}
* Quotas
  * configure quota for a user `edquota [username]`
  * for a group `edquota -g [groupname]`
* Container platform LXC

## Consoles
* tty1 through tty6
* On CentOS in Gui mode
  * open a terminal here
    * `tty` will return /dev/pts/0 (or 1...)
    * This is a pseudo console
    * open another terminal and `tty` will return /dev/pts/1 (or next in seq)
    * ssh to this box from elsewhere and `tty` will return /dev/pts/2 (or next in seq)
  * Alt+Ctrl+F2..F7 will switch to text based (physical) console
    * `tty` will return /dev/tty2, a physical/virtual terminal
  * Alt+Ctrl+F1 will go back to the Gui.
  * `chvt [num]` will swtich as well
  * `who` will list all of the terminals
  * on Centos GUI is on tty1. VT7 (Alt+Ctrl+F7) is often, but not always the GUI... CHECK THIS!!
```
vagrant  :0           2019-01-24 15:43 (:0)
vagrant  pts/0        2019-01-24 15:43 (:0)  --  first gui term
vagrant  pts/1        2019-01-24 15:43 (:0)  --  second gui term
vagrant  pts/2        2019-01-24 15:48 (172.28.128.1)  --  ssh (from 128.1)
vagrant  tty2         2019-01-24 15:51  Alt+Ctrl+F2
vagrant  tty3         2019-01-24 15:52  Alt+Ctrl+F3
``` 
  * `w` command is similar to who
``` 18:09:34 up  2:39,  5 users,  load average: 0.01, 0.02, 0.05
USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU WHAT
vagrant  :0       :0               15:43   ?xdm?  50.90s  0.24s /usr/libexec/gn
vagrant  pts/0    :0               15:43    6.00s  0.08s  0.01s w
vagrant  pts/1    :0               15:43    2:21m  0.05s  0.05s bash
vagrant  tty2                      15:51     ?     0.05s  0.05s -bash
root     tty3                      18:08     ?     0.04s  0.04s -bash
```

## Navigating the FS, normal bash ops, history
* `ls -ld` long list on one dir
* `ls -lh` long in human readable
* `ls -i` shows inode
* `pwd` -P physical path in place of sym links, -L logical is the default
* `ctrl+a` for beginning and `ctrl+e` for end of line
* `ctrl+left/right` moves cursor an entire word at a time
* `ctrl+k` deletes to end of line
* `ctrl+u` deletes to beginning of line (use to clear out password entry to start over)
* `ctrl+l` clear the screen except current line
* `ctrl+w` delete one word before the cursor
* `ctrl+t` swap current char with one before - correct dyslexic typing
* `ctrl+z` to put process in background

# Linux Essentials
* Free Software Foundation
* MySQL
* GNU: Gnu's Not Unix!
* Dev Languages C, Python, PHP
* People
  * First Open Source OS (Dr. Andrew Tanenbaum )
  * Richard Stallman was the founder of the GNU project. 
  * Who developed the first Linux kernel? Linus Torvalds 
* TWO ssh Syntaxes -- ssh stephen@172.16.10.123 , ssh -l stephen 172.16.10.123
* directory will you find system-related configuration files /etc?
* `#!/bin/bash`
* Microsoft SQL Server has recently been ported to Linux
* Net utils
  * `ping -c 5 host.example.com`  5 packets
  * Traceroute and tracepath are both used to follow the network path to outside systems. 
  * View default gateway:  route, netstat -r
  * 
* File System
  * directory will you find system-related configuration files /etc?
  * contains filesystem management utilities such as cp or mv  /bin and /usr/bin
* view network configuration - 2 commands
  * ip addr show, ifconfig
* two primary Dev models Bazaar and Cathedral Models (Bazaar is less structured)
* CUPS and SAMBA for printing

# Exam 101
## Topic 101: System Architecture
### 101.1 Determine and configure hardware settings
* Description: Candidates should be able to determine and configure fundamental system hardware
* Key Knowledge Areas:
  * Enable and disable integrated peripherals.
  * Differentiate between the various types of mass storage devices.
  * Determine hardware resources for devices.
  * Tools and utilities to list various hardware information (e.g. lsusb, lspci, etc.).
  * Tools and utilities to manipulate USB devices.
  * Conceptual understanding of sysfs, udev and dbus.
* The following is a partial list of the used files, terms and utilities:
  * /sys/
    * /sys/module -- kernel modules
  * /proc/
  * /dev/
    * everything in here is created by udev
  * modinfo - `modinfo usb-storage`, `modinfo [things from lsmod]`
  * modprobe - Add and remove modules from the Linux Kernel
    * `sudo modprobe -rv sr_mod` results (eject cdrom first)
      * rmmod sr_mod
      * rmmod cdrom
      * so using modprobe can remove multiple (if uneeded) modules
      * handles dependencies 
  * lsmod - Show the status of modules in the Linux Kernel
  * rmmod - Simple program to remove a module from the Linux Kernel
    * or use modprobe -r
    * modprobe -r btrfs`
  * insmod - Simple program to insert a module into the Linux Kernel
    * must deal with dependencies manually
  * lspci - PCI devices
    * -v or -vv
  * lsusb
  * usb-devices
  * lscpu
  * lsblk
  * udev, /dev
  * `cat /proc/meminfo`
  * `udevadm monitor`
* sysfs is a pseudo file system
* Pseudo File Systems
  * /proc  --  processes, can view things as txt files like the cmdline to start the process. A directory for all of the PIDs.
    * `cmdline` params used by kernel when loaded
    * `cpuinfo`
  * /sys  --  devices etc
  * sysfs is a pseudo file system
* udev - Dynamic device management
  * udev relies on sysfs
  * udev rules are located at the /etc/udev/rules.d
  * udevadm utility for working with udev
* dbus
  * notifies desktop applications of hardware events.
  * eg reaction to putting a CD in the drive or a usb drive into a usb connector
  * events between applications eg a music player letting other apps know what somg is playing
* proc
* /lib/modules/[kernel-version]/modules.dep
  * sudo cat /lib/modules/$(uname -r)/modules.dep

### 101.2 Boot the system
* Description: Candidates should be able to guide the system through the booting process.
* Key Knowledge Areas:
  * Provide common commands to the boot loader and options to the kernel at boot time.
  * Demonstrate knowledge of the boot sequence from BIOS/UEFI to boot completion.
  * Understanding of SysVinit and systemd.
  * Awareness of Upstart.
  * Check boot events in the log files.
* The following is a partial list of the used files, terms and utilities:
  * dmesg
    * -H human readable
    * -C clear
    * -w wait
  * journalctl
  * BIOS
  * UEFI
    * ls /sys/firmware, if there is an efi dir, then likely this is a UEFI system??
  * bootloader
  * kernel
  * initramfs
  * init
  * SysVinit
  * systemd
* What are the interrelationships of: BIOS/UEFI, MBR/GPT, Grub/Grub2, InitV/Systemd?
* Boot sequence
  * post
  * mbr or gpt
  * boot loader lilo/grub legacy/grub2
  * kernel + initramfs
    * init ram fs - default drivers required to get system up
  * init(V)/upstart/systemd
  * services are loaded
  * login prompt
* Boot process
  * GRUB  --  Grand Unified Boot Loader  --  
  * looks for Boot Sector
  * linux Kernal
  * Initial RAM disk
  * Initialization System
* Boot Logs, dmesg and journalctl -k  (systemd)
* A good way to tell if a system is running init or systemd
  * `top -p 1`
      * 1 root      20   0 19344 1340 1136 S  0.0  0.1   0:01.02 init   
      * 1 root      20   0  128256   6964   4184 S   0.0  0.2   0:01.79 systemd 
* InitV systems
  * `cat /etc/inittab`
  * id:5:initdefault:
  * `ls -ld /etc/rc*` to see all of the runlevels
    * These directories contain sctipts whose names start with S(tarting) or K(illing) then a number with the load seq
  * control services (2 methods)
    * `/etc/init.d/cups start/stop/status` find links to the sctipts in /etc/rc*
    * `service cups start/stop/status` 
    * `chkconfig --level 5 cups on/off` changes symbolic links for Start/Kill scripts
    * `runlevel` displays current and previous runlevels
    * `telinit [num]` change runlevel `init [num]` also works
  * Loads services one at a time
  * /sbin/init
  * /etc/inittab
    * `<id>:<runlevel>:<action>:<process>`
  * /etc/rc.d  - Red hat
  * /etc/init.d - Debian
  * `runlevel` to see current runlevel
  * `telinit 3` to change to runlevel 3
  * Runlevel | Purpose
    * 0 | Halt
    * 1 | Single user mode
    * 2 | Multi-user mode (no networking)
    * 3 | Multi-user mode (with networking)
    * 4 | unused
    * 5 | Multi-user, w/net and GUI
    * 6 | reboot
* Upstart
  * asynchronous
  * /sbin/init
  * startup
  * mountall
  * /etc/init/rc-sysinit.conf
  * telinit
  * runlevel
  * /etc/init/rc.conf
* Systemd
  * https://www.digitalocean.com/community/tutorials/how-to-use-systemctl-to-manage-systemd-services-and-units
  * attempts to replace shell scripts with compiled C code
  * Unit File Locations
    * /usr/lib/systemd/system (pkgs install here do not modify)
    * /etc/systemd/system (modify here as these will take precedence over the /usr/lib files)
    * /run/systemd/system
    * `systemctl list-unit-files`
    * `man [5] systemd.unit`
    * `systemctl cat [something.unit]`
  * boot
    * /sbin/init sym linked to ../lib/systemd/systemd
  * Target types  (found in /usr/lib/systemd/system)
    * halt.target (like runlevel 0)
    * poweroff.target (better to use than halt)
    * multi-user.target (like runlevel 3)
    * graphical.target (like runlevel 5)
    * rescue.target (like runlevel 1)
    * basic.target - used during boot process before another target
    * sysinit.target - system initialization
    * reboot.target (like runlevel 6)
    * Docs
      * man 5 systemd.target
      * man 7 system.special
  * `systemctl cat [some].target`
  * `systemctl list-unit-files -t target`
  * `systemctl list-units -t target` list active
  * `systemctl get-default [type].target`  default target
  * `systemctl set-default [type].target` 
  * `systemctl isolate multi-user.target` change targets (allow isolate must be enabled)
  * `systemctl rescue`
  * `systemctl poweroff`
  * `systemctl reboot`
  * Adjusting the System State (Runlevel) with Targets
    * `systemctl list-unit-files --type=target`  all targets
    * `systemctl list-units --type=target`  active targets
    * `sudo systemctl isolate multi-user.target` changes the target immediately if possible
    * `sudo systemctl rescue/halt/poweroff/reboot` These are shortcuts, often with added functionality
  * Service Management
    * `systemctl start/stop/restart/reload/kill/status/enable/disable/mask/unmask     [unitname]`
    * `sudo systemctl stop/start cups(.service)` The .service is optional
    * `enable` sym link from svc file in /lib/systemd/system or /etc/systemd/system
    * `systemctl status cups`
    * `systemctl is-active/is-failed/is-enabled cups` will show active/inactive
* more systemctl commands
  * `systemd-analyze blame` how long did each service take to load
* System State Overview
  * `systemctl list-units`
  * `systemctl list-units --all | grep cups.service`  will show running/dead
  * `systemctl list-units --state=enabled,running --type=service`
    * This shows more columns than the list-unit-files below
* The list-units command only displays units that systemd has attempted to parse and load into memory. Since systemd will only read units that it thinks it needs, this will not necessarily include all of the available units on the system. To see every available unit file within the systemd paths, including those that systemd has not attempted to load, you can use the list-unit-files command instead:
* `systemctl list-unit-files --state=enabled,running --type=service`
  * lists file and state:  The state enabled, disabled, static (does not contain an install section), masked (mark a unit as completely unstartable), generated, transient, indirect, enabled-runtime
* Unit Management
  * `systemctl cat [something.unit]`
  * `systemctl list-dependencies cups.service`  --reverse, --before, --after
  * `systemctl show cups.service`
  * `systemctl show cups.service -p Conflicts` Conflicts property
  * `sudo systemctl edit cups.service --full`
    * the changed file will be written to /etc/systemd/system
    * To remove any additions, delete the unit's .d configuration directory or the   modified service file from /etc/systemd/system. 
    * `sudo rm -r /etc/systemd/system/nginx.service.d`
    * `sudo rm /etc/systemd/system/nginx.service`
* https://www.digitalocean.com/community/tutorials/understanding-systemd-units-and-unit-files
  * `systemctl list-unit-files` --type/-t service/timer
  * `systemctl list-timers` --all to see inactive
    * mask = disabled
* `sudo journalctl -u mytimer.timer`  -f to view the log from the end
* /etc/systemd/system is for user-defined unit files
  * modify here as these will take precedence over the /usr/lib files
* /usr/lib/systemd/system is for unit files from user-installed software
* Somehow, placing the files in /etc/systemd/system fixed the issue with the timer???
* systemd units
  * .service: A service unit describes how to manage a service or application on the server. This will include how to start or stop the service, under which circumstances it should be automatically started, and the dependency and ordering information for related software.
  * .socket
  * .device
  * .mount
  * .automount
  * .swap
  * .target: A target unit is used to provide synchronization points for other units when booting up or changing states. They also can be used to bring the system to a new state. Other units specify their relation to targets to become tied to the target's operations.
  * .path
  * .timer: A .timer unit defines a timer that will be managed by systemd, similar to a cron job for delayed or scheduled activation. A matching unit will be started when the timer is reached.
  * .snapshot
  * .slice
  * .scope
* `sudo yum install -y httpd`
* `rpm -ql httpd | grep system` view systemd files in a pkg
* `systemctl status httpd` note the pkg installs disabled by default
* `sudo systemctl enable httpd.service` Note the name from the "loaded" line??
  * Created symlink from /etc/systemd/system/multi-user.target.wants/httpd.service to /usr/lib/systemd/system/httpd.service.
  * now it is enabled, but still dead/inactive
* `sudo systemctl start httpd.service`
* `systemctl help xrdp.service`
* `systemctl -H [host or ip] status xrdp.service` ssh keys must be set up

### 101.3 Change runlevels / boot targets and shutdown or reboot system
* Description: Candidates should be able to manage the SysVinit runlevel or systemd boot target of the system. This objective includes changing to single user mode, shutdown or rebooting the system. Candidates should be able to alert users before switching runlevels / boot targets and properly terminate processes. This objective also includes setting the default SysVinit runlevel or systemd boot target. It also includes awareness of Upstart as an alternative to SysVinit or systemd.
* Key Knowledge Areas:
  * Set the default runlevel or boot target.
  * Change between runlevels / boot targets including single user mode.
  * Shutdown and reboot from the command line.
  * Alert users before switching runlevels / boot targets or other major system events.
  * Properly terminate processes.
  * Awareness of acpid.
The following is a partial list of the used files, terms and utilities:
* /etc/inittab
* shutdown - preferred with delay and message options
* reboot/poweroff
* init
* /etc/init.d/
* telinit
* systemd
* systemctl
* /etc/systemd/
* /usr/lib/systemd/
* wall sends a message to all open terminals
* Reboot Commands
  * reboot
  * telinit 6
  * shutdown -r now
  * systemctl isolate reboot.target
* Shutdown Commands
  * poweroff
  * telinit 0
  * shutdown -h 1 minute (invokes wall)
  * systemctl isolate poweroff.target
* wall - broadcast a message to logged in users
* acpid - advanced configuration and power interface
  * config /etc/acpi  

## Topic 102: Linux Installation and Package Management
### 102.1 Design hard disk layout
* Description: Candidates should be able to design a disk partitioning scheme for a Linux system.
* Key Knowledge Areas:
  * Allocate filesystems and swap space to separate partitions or disks.
  * Tailor the design to the intended use of the system.
  * Ensure the /boot partition conforms to the hardware architecture requirements for booting.
  * Knowledge of basic features of LVM.
* The following is a partial list of the used files, terms and utilities:
  * / (root) filesystem
  * /var filesystem
  * /home filesystem
  * /boot filesystem
  * EFI System Partition (ESP)
  * swap space
  * mount points
  * partitions
* Mount points
  * `mount` - display mount points
  * `df -hT`
* /etc file system (system-related configuration files)
  * /etc/apt/sources.list
    * /etc/apt/sources.list.d/vscode.list
  * /etc/default/grub
  * /etc/resolv.conf
  * /etc/hosts
  * /etc/man_db.conf
  * /etc/network/interfaces
  * /etc/network/interfaces.d/*
  * /etc/samba/smb.conf
  * /etc/systemd/system
  * /etc/systemd/system/multi-user.target.wants/httpd.service to /usr/lib/systemd/system/httpd.service
  * /etc/default/keyboard
  * /etc/sysctl.conf
  * /etc/rc.local
  * /etc/inittab
  * /etc/rc.d  - Red hat
  * /etc/init.d - Debian
  * /etc/securetty
  * /etc/init/rc.conf
  * /etc/systemd/system
  * /etc/resolv.conf - DNS resolution
  * /etc/ld.so.conf
  * /etc/acpi
  * /etc/udev/rules.d
  * /etc/yum.conf
  * /etc/yum.repos.d/
  * /etc/fstab
  * /etc/mtab
  * /etc/bashrc file
  * /etc/profile
  * /etc/profile.d
  * /etc/skel
  * /etc/updatedb.conf
* File System Hierarchy Std:  http://www.pathname.com/fhs/ and https://wiki.linuxfoundation.org/lsb/start
http://refspecs.linuxfoundation.org/FHS_3.0/fhs/index.html
  * / root
  * bin
  * boot - kernal and supporting files
    * This will usually be a separate partition??
    * usually vfat??
    * Sample:
      * config-3.10.0-862.11.6.el7.x86_64
      * config-3.10.0-957.1.3.el7.x86_64
      * efi
      * grub
      * grub2
      * initramfs-0-rescue-b8ae4e7c6e42490b801633d8d903c9a0.img
      * initramfs-3.10.0-862.11.6.el7.x86_64.img
      * initramfs-3.10.0-862.11.6.el7.x86_64kdump.img
      * initramfs-3.10.0-957.1.3.el7.x86_64.img
      * initramfs-3.10.0-957.1.3.el7.x86_64kdump.img
      * symvers-3.10.0-862.11.6.el7.x86_64.gz
      * symvers-3.10.0-957.1.3.el7.x86_64.gz
      * System.map-3.10.0-862.11.6.el7.x86_64
      * System.map-3.10.0-957.1.3.el7.x86_64
      * vmlinuz-0-rescue-b8ae4e7c6e42490b801633d8d903c9a0
      * vmlinuz-3.10.0-862.11.6.el7.x86_64
      * vmlinuz-3.10.0-957.1.3.el7.x86_64
  * dev - quasi-pseudo
  * etc
  * home
    * /home/[user]/.bashrc
  * lib
  * lib64 - .so (shared object) files
  * media
  * mnt
  * opt - (optional) third party, Enterprise environments
  * proc - pseudo  --  processes, can view things as txt files like the cmdline to start the process
  * root
  * sbin
  * srv - not used on CentOS uses /var instead. Might put databases here
  * swap (older 1.x to 2.0x of RAM, newer no less than 50% of RAM)
  * sys - pseudo  (sysfs)  --  devices etc
  * tmp
  * usr
    * Sample: bin etc games include lib lib64 libexec local sbin share src tmp
    * /usr/share/doc - location for more docs for apps
    * /usr/lib/systemd/ (pkgs install here do not modify)
  * var - (variable) dynamic content, log files, websites
    * Should be on separate partition
* LVM - Logical Volume Management
  * use for any volume except for boot, resize, snapshot
  * `pvs`  - Display information about physical volumes
  * partitions must be of type 8e or 8e00
  * vagrant boxes are using LVM??
  * `lvs` - Display information about logical volumes
  * `pvcreate` - Initialize physical volume(s) for use by LVM
    * `pvcreate /dev/sdb1`
    * `pvs` or `pvscan -v` to see the results
  * `vgcreate lvm_volume /dev/sdb1 /dev/sdb2 /dev/sdb3`
    * some versions can only add one pv to a vg at create time
    * `vgextend` - Add physical volumes to a volume group
  * `vgs` - Display information about volume groups
  * `lvcreate -L 24M -n res_vol lvm_volume`
  * `lvextend` - Add space to a logical volume
  * `mkfs.ext2 /dev/lvm_volume/res_vol`
  * `lvremove` to delete a logical volume
* partition IDs
  * 83 - std Linux  (same as ext2??)
  * 82 - Linux Swap
  * 8e - LVM
* parted - Modern command to create MBR or GPT partitions
* Logical partions have numbers greater than 4?

### 102.2 Install a boot manager
* Description: Candidates should be able to select, install and configure a boot manager.
* Key Knowledge Areas:
  * Providing alternative boot locations and backup boot options.
  * Install and configure a boot loader such as GRUB Legacy.
  * Perform basic configuration changes for GRUB 2.
  * Interact with the boot loader.
* The following is a partial list of the used files, terms and utilities:
  * menu.lst, grub.cfg and grub.conf
  * grub-install
  * grub-mkconfig
  * MBR
* Legacy Grub
  * /boot/grub/menu.lst
  * comment out `hiddenmenu` to bring up the boot menu (otherwise there should be option to press a key within the timeout period to open the menu)
  * to see boot messages, remove `rhgb quiet` from the end of the relevent kernel command
  * `e` to edit and remove `rhgb quiet` to see boot messages
  * `sudo grub-install /dev/sda`
  * Stage 1:  boot.img
  * Stage 1.5:  core.img
  * Stage 2:  /boot/grub/
* Change root password legacy grub
  * get to boot menu (press any key before timeout)
  * `e` on first option
  * up/down to kernel option and `e` again
  * append `1` to line [enter] to save the line
  * then `b`
  * result is single user mode, passwd to change pw
* Grub2
  * grub2 on Ubuntu 18.04 just looks different than on CentOS
  * Most of this information should be considered for CentOS only
  * edit the file /etc/default/grub
  * grub2-mkconfig modifies /boot/grub2/grub.cfg on CentOS systems
    * `grub2-mkconfig -o /boot/grub2/grub.cfg`
  * use `update-grub` on Ubuntu
  * grub2 install command `grub-install /dev/[disk]`
* Change root password grub2
  * Restart to grub2 bootloader
  * `e` on first line to edit
  * edit/append the linux16 line: `systemd.unit=rescue.traget` to boot into rescue mode (this option is for when you DO have the root pw)
  * `rd.break enforcing=0` to break at the ram disk and turn off selinux
  * ctrl+x to boot
  * FS is in read only mode: `mount -o remount,rw /sysroot`
  * `chroot /sysroot`  (chroot - run command or interactive shell with special root directory)
  * `passwd`
  * `exit`
  * `mount -o remount,ro /`
  * `exit` to boot normally
  * `sudo restorecon /etc/shadow`
  * `sudo setenforce 1`
* To be sorted
  * grub.conf (rh)/menu.lst(deb)
  * device.map
* run grub to get into the grub shell (my systems do not have this)
* `sudo vim /etc/default/grub`, then `update-grub`
  * See /boot/efi/EFI/centos
* used with GPT and UEFI (Unified Extensible Firmware Interface)
  * UEFI replaces traditional BIOS, requires 64 bit and prevents unauthorized OS to boot
* Stage 1:  boot.img
  * GPT Header
  * Partition Entry Array
* Stage 1.5:  core.img
  * /boot/efi
  * MUST be vfat or FAT32
* Stage 2:  /boot/grub2/
  * grubenv  --  This file lists the same kernel as `uname -r`
    * Edit this file with `grub2-editenv`
  * themes
* Commands:
  * `grub2-editenv list`  --  lists the same kernel as `uname -r`
  * `update-grub` to make modifications on Deb Systems
* Your GRUB2 install has become corrupt; what might you do in order to resolve the issue? (Choose Two) 
  * Reinstall the GRUB bootloader grub-install /device 
  * Recreate the grub.cfg configuration file grub-mkconfig > /boot/grub/grub.cfg 
* Ubuntu 18.04 vagrant install
  * Use left shift during boot to get boot menu in non-gui mode
  * use [esc] during boot to get boot menu in gui mode
  * This boot menu looks like grub2 (GNU grub version 2.02)
  * `e` to edit a line of the boot menu
    * at the end of the "linux" line append `systemd.unit=rescue.target`
  * `c` for command mode
    * `ls` and `ls (hd0,1)/`
    * `linux /boot/vmlin[tab] root=/dev/sda1` to commplete the kernel and get the dev from the lsblk command
    * `initrd /boot/initrd.img-4.15.0-39-generic`
    * `boot`
  * Gui grub customizer
    * `sudo grub-customizer`
* Ubuntu 12.04 vagrant install
  * ubuntu/precise64 - /etc/default/grub
    * #GRUB_HIDEN_TIMEOUT=0
    * #GRUB_HIDEN_TIMEOUT_QUIET=0
  * /boot/grub/menu.lst??  --  This does not modify the boot menu??
  * v12.04 seems to be in a weird no man's land zone: grub v1.99
  * Menu comes from /boot/grub/grub.cfg
* Change display resolution Ubuntu 16.04 on HyperV
  * sudo vim /etc/default/grub
  * GRUB_CMDLINE_LINUX_DEFAULT="quiet splash video=hyperv_fb:1920x1080"  (1680x1050,  1600x900)
    * Experiment 1: match screen resolution (1920x1080)
  * sudo update-grub
  * sudo reboot now

### 102.3 Manage shared libraries
* Description: Candidates should be able to determine the shared libraries that executable programs depend on and install them when necessary.
* Key Knowledge Areas:
  * Identify shared libraries.
  * Identify the typical locations of system libraries.
  * Load shared libraries.
* The following is a partial list of the used files, terms and utilities:
  * ldd - shared libraries required for a program
  * `ldconfig -p` to see all of the libraries
  * /etc/ld.so.conf
  * LD_LIBRARY_PATH
* .so (shared object) files in /lib64
* Shared Libraries
  * Dynamic .so (shared object) extension or Statically linked .a extension
  * /lib, /usrlib (32 bit), /usr/lib64, /usr/local/lib, /usr/share
  * `ldd` list library dependencies for a program
  * `ldconfig` cached listing of recently used libraries
    * /etc/ld.so.conf
  * LD_LIBRARY_PATH - legacy environment variable

### Comparison: yum/apt
  * apt has a 'cache that might need updating to get latest packages, yum refreshes each time a call to a repo is made.
  * update: apt just reads repos, yum installs non-kernel updates
  * `apt-get dist-upgrade` kernel updates
  * `sudo do-release-upgrade` OS upgrade on Ubuntu
  * /etc/apt/sources.list
  * /etc/yum.repos.d
  * `yum list installed` 
  * `apt list --installed`

### 102.4 Use Debian package management
* Description: Candidates should be able to perform package management using the Debian package tools.
* Key Knowledge Areas:
  * Install, upgrade and uninstall Debian binary packages.
  * Find packages containing specific files or libraries which may or may not be installed.
  * Obtain package information like version, content, dependencies, package integrity and installation status (whether or not the package is installed).
  * Awareness of apt.
* The following is a partial list of the used files, terms and utilities:
  * /etc/apt/sources.list
  * dpkg
  * dpkg-reconfigure
  * apt-get
  * apt-cache
* Debian APT (includes dependencies)
  * `apt list --installed`
  * /etc/apt/sources.list
  * `apt-get update` updates local cache  (looks at repos in sources.list)
  * /etc/apt/sources.list.d (add a repo here)
  * Software & Updates is a GUI for etc/apt/sources.list
  * /var/cache/apt/archives - downloaded .deb files
  * `apt-cache [search/show/showpkg] [pattern]`  (local cache)
  * `apt-get install`
  * `apt-get remove/purge/autoremove`
    * `sudo apt-get remove [pkg]`
    * `sudo apt-get purge [pkg] ` (removes conf files)
    * `sudo apt-get autoremove` (removes dependencies)
  * `sudo apt-cache depends [pkg]`
  * `sudo apt-get check` (for broken systems)
  * upgrading
    * `apt-get upgrade` regular upgrades
    * `apt-get dist-upgrade` upgrades to the next release of the distribution (upgrades the kernel) (smart version of above??, might remove packages)
    * `sudo do-release-upgrade` to upgrade to the latest version of the OS (such as 18.04)
  * `apt-key list`
  * `apt-key add` See PowerShell example
  * `add-apt-repository`  (add-apt-repository ppa:webupd8team/java)
  * Misc/unsorted
    * `apt-get-download`
  * View installed packages
    * apt list --installed
    * apt list --installed | grep [package]
  * aptitude works almost exactly like apt
    * `aptitude` no params will open a menu driven system
  * dpkg to install .deb files
    * `dpkg --info, --status, -l (list), -i (install), -L (list files), -r (remove), -P (purge), [pkg]`
    * -S (search the pkg db, give it a file name and returns the pkg that installed it)
    * `dpkg-reconfigure`  --  reruns a pkg's setup?
* Deb/apt/Ubuntu examples
  * Samba
    * `sudo apt-get install samba`
    * Samba Install and configure process  --  Note: this will set up a wide open share, anyone can write to it. For an isolated lab, this should be fine for sharing files. I am using this process because it is known to me. There may be better ways in the long run.
    * Edit /etc/samba/smb.conf  (as root, 'gksudo gedit')
      ```
      [smbshare]
          path = /home/coateds/smbshare
          public = yes
          writable = yes
      ```
    * cd ~
    * mkdir smbshare
    * chmod 777 smbshare
  * PowerShell
    * (Source https://github.com/PowerShell/PowerShell/blob/master/README.md)
    * Import the public repository GPG keys: `sudo curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -`
    * Register the Microsoft Ubuntu repository: 
      * `curl https://packages.microsoft.com/config/ubuntu/18.04/prod.list | sudo tee /etc/apt/sources.list.d/microsoft.list`
      * Places a file in etc/apt/sources.list.d
    * sudo apt-get update
    * sudo apt-get install -y powershell
    * Start PowerShell:  `pwsh`
    * link: /usr/bin/pwsh -> /opt/microsoft/powershell/6/pwsh
  * VSCode
    * Install the key
      * `curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg`
      * `sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/`
      * This *appears* to be the same key as for powershell??
    * `sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'`
    * Then update the package cache and install the package using:
    * Not Needed?  `sudo apt-get install apt-transport-https`
    * `sudo apt-get update`
    * `sudo apt-get install code` # or code-insiders
  * VSCode Install process -- older process??
    * sudo add-apt-repository ppa:ubuntu-desktop/ubuntu-make
    * sudo apt-get update
    * sudo apt-get install ubuntu-make
    * sudo umake web visual-studio-code
    * This worked well and installed the latest (1.13) version!!
      * /home/[user]/.local/share/umake/web/visual-studio-code/code
      * right click icon on launcher --  Lock to Launcher
      * install code runner extension
    * umake web visual-studio-code --remove  (If needed)
  * VSCode Upgrade process -- older process??
    * sudo apt-get update (optional?)
    * umake web visual-studio-code
  
### 102.5 Use RPM and YUM package management
* Description: Candidates should be able to perform package management using RPM, YUM and Zypper.
* Key Knowledge Areas:
  * Install, re-install, upgrade and remove packages using RPM, YUM and Zypper.
  * Obtain information on RPM packages such as version, status, dependencies, integrity and signatures.
  * Determine what files a package provides, as well as find which package a specific file comes from.
  * Awareness of dnf.
* The following is a partial list of the used files, terms and utilities:
  * rpm
  * rpm2cpio
  * /etc/yum.conf
  * /etc/yum.repos.d/
  * yum
  * zypper
* RRM Package Manager YUM  (SUSE Linux uses Zypper, Fedora uses DNF)
  * yum does not have a cache as the repos are automatically scanned for latest??
  * /etc/yum.conf
  * /etc/yum.repos.d
  * /var/cache/yum
  * `yum search http`  
  * `yum info httpd`  
  * `sudo yum install httpd`  
  * `yum reinstall`
  * `yum list installed`  
  * `yum list installed open*`  
  * `yum deplist httpd` (dependency list)  
  * `yum remove httpd`  
  * `yum autoremove httpd`  (purge)
  * `yum repolist`  
  * `yum clean all`  
  * `yum update`  (installs non kernel updates)
  * `yum upgrade` (similar to dist- in apt, will get kernel updates too)
  * `yum whatprovides`  (what package installs a given file)
  * `sudo yum install yum-utils`
  * `yumdownloader [pkg]`
    * `--resolve` - download dependencies in addition to pkg
  * `yum grouplist`
  * `yum localinstall [file].rpm` (will suggest dependencies even from Internet)
  * `yum localupdate [file].rpm` update from local
* RPM command
  * `rpm -ivh [pkg.rpm]`  (i) install, (v) verbose, (h) progress bar
  * `rpm -e [pkg]` removes
  * `rpm -Uvh [pkg.rpm]`  (U) update ...
  * -F  freshen -- updates packages if installed on the system
  * `rpm -qpi (info)` query a package before install (query/package/information)
    * `-qpl` (query/package/list files)
    * `rpm -qa` (list installed pkgs)
    * `rpm -qf [file]` (query/file) what package does a file come from
    * `rpm -qi [installed pkg]` information about a installed pkg

  ```
  sudo yum list installed pow*
    Installed Packages
    powershell.x86_64          6.1.2-1.rhel.7           @packages-microsoft-com-prod
  sudo rpm -qa pow*
    powershell-6.1.2-1.rhel.7.x86_64
  ```
* rpm2cpio some.rpm | cpio -idmv convert to cpio archive file  ---  Extraction tool
  * cpio is an archive program similar to tar
  * rpm pkgs are cpio files with added metadata
  * use this command to extract the files from .rpm via the cpio format
  * RPM database /var/lib/rpm --  `rpm --rebuilddb`
  * , , , -U (upgrades), -e (erase), -Va (verify)
  * exclude packages in /etc/yum.conf  Example: `exclude=xorg-x11* gnome* `  under [main] section
* <a href='https://linuxacademy.com/cp/livelabs/view/id/238'>Repositories and the Apt Tools - Linux Academy Lab</a>
* RH/yum/Centos examples
  * Samba - should be the same as Ubuntu, sub yum for apt-get
  * PowerShell
    * `sudo yum clean all`
    * `sudo yum -y install epel-release` (not needed for my Vagrant...)
    * `sudo yum -y update`
    * `curl https://packages.microsoft.com/config/rhel/7/prod.repo | sudo tee /etc/yum.repos.d/microsoft.repo`
    * `sudo yum install powershell`
  * VSCode is installed via Chef provider to Vagrant
    * (provide link?)

### 102.6 Linux as a virtualization guest
* Description: Candidates should understand the implications of virtualization and cloud computing on a Linux guest system.
* Key Knowledge Areas:
  * Understand the general concept of virtual machines and containers.
  * Understand common elements virtual machines in an IaaS cloud, such as computing instances, block storage and networking.
  * Understand unique properties of a Linux system which have to changed when a system is cloned or used as a template.
  * Understand how system images are used to deploy virtual machines, cloud instances and containers.
  * Understand Linux extensions which integrate Linux with a virtualization product.
  * Awareness of cloud-init.
* The following is a partial list of the used files, terms and utilities:
  * Virtual machine
  * Linux container
  * Application container
  * Guest drivers
  * SSH host keys
  * D-Bus machine id

## Topic 103: GNU and Unix Commands
### 103.1 Work on the command line
* Description: Candidates should be able to interact with shells and commands using the command line. The objective assumes the Bash shell.
* Key Knowledge Areas:
  * Use single shell commands and one line command sequences to perform basic tasks on the command line.
  * Use and modify the shell environment including defining, referencing and exporting environment variables.
  * Use and edit command history.
  * Invoke commands inside and outside the defined path.
* The following is a partial list of the used files, terms and utilities:
  * bash
  * echo
  * env
  * export
  * pwd
  * set
  * unset
  * type
  * which
  * man
  * uname
  * history
  * .bash_history
  * Quoting
* man pages
  * Section 1: executables programs or shell commands
  * Section 2: System Calls
  * Section 3: Library Calls
  * Section 4: Special Files
  * Section 5: File Formats and conventions
  * Section 6: Games
  * Section 7: Misc
  * Section 8: Sys Admin commands (usually for root)
  * Section 9: Kernal routines
* `man [sec#] [item]`
* Man Pages
  * brief review of the syntax:  SYNOPSIS
  * environmental variable might we use to specify the directory where man page files will be located:  $MANPATH
  * info command can also be used
  * configuration file  --  /etc/man_db.conf
  * section within a man page provides a list of man pages or other resources  --  SEE ALSO
  * Search:  man -k [subject] , apropos [subject]
  * Which section of a man page contains administrative utilities used by the root user  --  8
* Echo and Path
* type - is something a fn, file, alias, built-in, or keyword
  * -P will give path like which
  * will tell me if a command is built in (like pwd)
  * or if it is a Shell Keyword
* env, export and local variables
  * `env` and `set` will display all of your environment variables in Bash
  * `declare` - Declare variables and give them attributes.
* Version info
  * `uname`  --  kernel info
  * -a for All information
  * -s, --kernel-name: Print the kernel name.
  * -n, --nodename: Print the network node hostname.
  * -r, --kernel-release: Print the kernel release.
  * -v, --kernel-version: Print the kernel version.
  * -m, --machine: Print the machine hardware name.
  * -p, --processor: Print the processor type, or "unknown".
  * -i, --hardware-platform: Print the hardware platform, or "unknown".
  * -o, --operating-system: Print the operating system.
  * --help: Display a help message, and exit.
  * --version: Display version information, and exit.
* OS Version
  * Ubuntu  --  `lsb_release -a`
  * CentOS  --  `cat /etc/centos-release`
* Environment Variables
  * env  --- view environment variables
  * export MYNAME="Dave"  ---  create and set a variable
  * VARIABLE=/path,command,alias
  * echo $MYNAME
* Set - Displays all bash settings
  * set/unset options
    * `set -o` to see all internal options
    * `set -o noclobber` to set on
    * `set +o noclobber` to set off
  * `set -x` turn on debugging
  * `unset -f [fn]`  Remove a function
  * `unset FOO` to clear the 'FOO' env variable
* Alias -- `alias ll="ls -lh"`
* `function [name]()  {[commands]}`
* `source .bashrc` file (rereads and merges contents of .bashrc file)
  * . (dot) is an alias to source so `. .bashrc` is the same thing
  * `echo alias 'webstat="systemctl status httpd.service"' >> ~/.bashrc`
* shopt  (show options?)
  * `shopt -s [optname]` set/enable an option
* history
  * -c to clear, -r to reread and -w to (over)write~/.bash_history
  * `![cmd#]` runs the command the the specified number
  * `~/.bash_history`
  * $HISTFILESIZE
  * `ctrl+p` and `ctrl+n` = up and down arrow
  * `ctrl+r` and `ctrl+s` reverse and fwd search through history
    * `enter` to run, `esc` to edit and `ctrl+g` to stop search
  * `history` to see all commands
  * `!!` to execute last
  * `![num]` execute that command as numbered in history
  * `![text]` execute a command that starts with text
  * `!$` inserts last arg from prev cmd
  * `!?[text]` execute command with text anywhere in the lin
* Quotes
  * double are weak and single are strong  (weak still expands a variable)

### 103.2 Process text streams using filters
* Description: Candidates should be able to apply filters to text streams.
* Key Knowledge Areas:
  * Send text files and output streams through text utility filters to modify the output using standard UNIX commands found in the GNU textutils package.
* The following is a partial list of the used files, terms and utilities:
  * bzcat - decompress to stdout
  * cat
  * cut
  * head
  * less
  * md5sum
  * nl
  * od
  * paste
  * sed
  * sha256sum
  * sha512sum
  * sort
  * split
  * tail
  * tr
  * uniq
  * wc
  * xzcat
  * zcat - decompress to stdout
* cat
  * -A show all (equiv -vET)
  * -E lines ends with $
  * -n line numbers
  * -s suppress repeated blank lines
  * -T show tabs
  * -v non print chrs
* tac - concatenate and print files in reverse
* head/tail - first or last lines of a file
  * `sudo tail -f /var/log/secure`  follows the log file (shows entries as they are added)
  * -c -bytes=k (-k negative?)
    * `head -c 10 [file]` first 10 bytes
  * -n -lines=k
    * `head [file] -n 5`  5 lines
  * -q never print hearders
  * -v always print headers
  * tail only??
    * -f follow (appends data live)
    * --pid= with -f, terminate after pid dies
    * -s sleep with -f
* more/less
  * more is an old version of less
  * less
    * pgup/pgdn
    * search with `/`  (n for next)  `?` searches from the bottom
    * [num] shft+g to go to a line by number
    * -N line numbers
* cut - remove sections from each line of files
  * `cut -d',' -f 3 [file]` extract the 3rd column, comma delim
  * -s do not use lines that do not contain delimiters
  * ` ps -A | tac | head -5 | cut -b 1-5`
    * -b, --bytes=LIST select only these bytes
  * `cut -d":" -f 1,3 /etc/passwd` usernames and UID on the system
  * `cut -d":" -f 1,3,7 /etc/passwd | grep nologin | sort` sorted nologin shell users
* sort - sort lines of text files
  * -n sort first columns as a number
  * sort -t "," -k2 (sort on second comma delim column)
  * `sort -u [file]` sort and unique
  * -r reverse
  * -n numeric
  * -h human readable
  * -M month
  * -k Key sort (column or field)
  * `sort wordlist | nl | head -5` top five (sorted) words in a file, with line numbers
  * -k, --key=KEYDEF sort via a key
  * `sort [file] -k 2`  soft on the second 'field'
* fmt - lines are 75 chr wide (wraps lines)
* pr - adds a date and page number header
* expand/unexpand (-a for all) tabs into spaces, spaces into tabs
* join - combine two files like a database join
* paste - merge lines of files
  * `paste [file1] [file2]`  merges two files ( line1 + line1, line2 + line2)  -d overrides the \t delim (-s files in series rather than paralell)
* split - split a file into pieces
  * splits a file, 1,000 lines? per file
  * `split -l 50 ~/.bash_history` 50 lines per file
  * -b 100, split to 100 byte files
  * -d --verbose -n2, 2 files with numeric naming
  * -n number of files to split into
* `od -c (chrs) -a -x (hex)` - dump files in octal and other formats

You have a Bash shell script that you are troubleshooting. There seems to be an extra character somewhere in the file. You decide to use the od command to locate it. Which command option would best suit this scenario? - `od -c` This will display the characters in the file and their escape sequences. 

* uniq - report or omit repeated lines  (--group)
  * `cat .bash_history | grep ls | sort | uniq`
* nl - number lines of files (-b a) to include blank lines
  * `nl [file]` adds line numbers to the output
* wc - print newline, word, and byte counts for each file 
  * (-w just words, -l lines, -c bytes, -m) chrs
  * by itself will show all three
* sed - stream editor, usually used for substitution
  * `sed 's/[findstr]/[replstr]/Ig' [filename]`
    * g = global, multiple replace
    * I = case insensitive
    * -i modifies the file
  * `cat /etc/passwd | sed 's/bash/zsh/g' > ~/passwd`
* tr - translate (replace) or delete characters
  * `cat [file] | tr ',' ':'`
  * `cat [file] | tr -d ','`  (delete the commas)
  * `cat [file] | tr 'A-Z 'a-z'` ToLower
  * `tr -d '\r' < dosfile > unixfile` create unix file from dos file replace CR/LF with LF
* Message Digest (Hash)
  * md5sum (-c check)
  * sha256sum
  * sha512sum
* strip - Discard symbols from object files
* awk - pattern scanning and processing language
```
[vagrant@localhost ~]$ sha256sum code.sh
bc0bdaef8a34d56e433400242005c945fe63db6025a35927186018cac5653f5a  code.sh
[vagrant@localhost ~]$ sha256sum code.sh > code.sha256
[vagrant@localhost ~]$ sha256sum -c code.sha256
code.sh: OK
```

### 103.3 Perform basic file management
* Description: Candidates should be able to use the basic Linux commands to manage files and directories.
* Key Knowledge Areas:
  * Copy, move and remove files and directories individually.
  * Copy multiple files and directories recursively.
  * Remove files and directories recursively.
  * Use simple and advanced wildcard specifications in commands.
  * Using find to locate and act on files based on type, size, or time.
  * Usage of tar, cpio and dd.
* The following is a partial list of the used files, terms and utilities:
  * cp
  * find
  * mkdir
  * mv
  * ls
  * rm
  * rmdir
  * touch
  * tar
  * cpio
  * dd
  * file
  * gzip
  * gunzip
  * bzip2
  * bunzip2
  * xz
  * unxz
  * file globbing
* Use `find` to locate a file or pattern of files ex: `find ./ -name la.txt`
  * `find . -name [name]` recursive by name
  * searches file system live
  * `find . -ctime 1` files changed last 1 day  (-atime accessed, -mtime modified)
  * -newer [than a file]
  * -empty -type f (empty files)
  * `find . -empty -type f -exec rm -f {} \;`  remove empty files
  * `find ~ -name "*.tar.*" -exec cp -v {} /dest/folder \;`
  * `find -mtime +7 -maxdepth 1`
* Searching files for text
  * bash: `find /etc -type f -exec grep -l 'coateds' {} \;`
  * bash: `grep -rl coateds /etc`
    * This does NOT work: ls /etc -r | sls "coateds"  ---  ls in this case is the actual linux ls command and therefore its output cannot be piped to a PS command
* cpio and dd  --  https://www.youtube.com/watch?v=j725PcShWq4
  * `ls | cpio -ov > ~/tmp.cpio` backup file of /tmp
  * `cpio -iv < tmp.cpio`
    * -o to add files to an archive
    * -i to extract
    * -v verbose
  * `dd` copy, convert and backup files
    * can copy data that cannot be copied with cp, such as a partition or boot record
    * `sudo dd if=boot.img of=/dev/sdc` create bootable usb
    * `sudo dd if=/dev/xvda of=/tmpmbr.img bs=512 count=1`  backup of master boot record
      * (first block of 512 bytes)
    * `dd if=/dev/urandom of=file bs=1024k count=10` make a file of 10 mb
    * `dd if=/dev/zero of=filename bs=1M count=1024` file full of zeros that is 1 GB in size
* Compression and tar
* compressed files: zcat, bzczt, xzcat to view
  * `tar -c (create), -f (filename) [target file] [source]`
  * -t list contents, -x extract, -z gzip compression, -v verbose (-j bz2 compresion)
  * `tar -czf file.tgz/.tar.gz source
  * -cjf (create bz2 file)
  * -xzf or -xjf to extract
  * gzip/gunzip/bzip2/bunzip2/xz/unxz
* globbing
  * [abc] match any char in the list
  * [^abc] match any char except those in the list
  * [0-9] matches a range of numbers

### 103.4 Use streams, pipes and redirects
* Description: Candidates should be able to redirect streams and connect them in order to efficiently process textual data. Tasks include redirecting standard input, standard output and standard error, piping the output of one command to the input of another command, using the output of one command as arguments to another command and sending output to both stdout and a file.
* Key Knowledge Areas:
  * Redirecting standard input, standard output and standard error.
  * Pipe the output of one command to the input of another command.
  * Use the output of one command as arguments to another command.
  * Send output to both stdout and a file.
* The following is a partial list of the used files, terms and utilities:
  * tee
  * xargs
* standard input, standard output and standard error
  * stdin - file descriptor 0 - operator < 
  * stdout - file descriptor 1 - operator >
  * stderr - file descriptor 2 - operator >
  * stdin, stdout, stderr
    * file handles stdin:0, stdout:1, stderr:2
    * `[scriptwerror.sh] 2> error.log`  redirect file handle 2 (errors) to the error.log
    * 2>&1 combines stdout and stderr redirected to whatever
* xargs - build and execute command lines from standard input (converts stdin to arguments for a command)
  * execute a command for each item in a list
  * `printf "1\n2\n3\n" | xargs touch` will create 3 files 1,2,3
  * `ls | xargs rm` removes all files in a directory
  * -i replace text  `printf "1\n2\n3\n" | xargs -i touch {}.txt`
  * `printf "1\t2\t3\t" | xargs -d "\t" -i touch {}.txt` custom delimiter
  * `find test/ -empty | xargs rm -f`
  * runs against all files at once, the exec option goes one at a time  
* tee - read from standard input and write to standard output and files

### 103.5 Create, monitor and kill processes
* Description: Candidates should be able to perform basic process management.
* Key Knowledge Areas:
  * Run jobs in the foreground and background.
  * Signal a program to continue running after logout.
  * Monitor active processes.
  * Select and sort processes for display.
  * Send signals to processes.
* The following is a partial list of the used files, terms and utilities:
* & - run in the background
* bg
* fg
* jobs
* kill
* nohup
* ps
* top
* free
* uptime
* pgrep
* pkill
* killall
* watch
* screen
* tmux
* `ps` - just the processes of the current shell
  * `ps -u <username>`
  * -e  every process, -H hierarchy, -f full format (more columns) -l long fmt
  * comes from the /proc directory
  * inside top, press k then pid of process to kill
  * `ps -e | grep bash | cut -b 1-6` returns just the pid of bash
  * no switches (launched/running in current shell)
  * `ps -eH` (Everything with Hierarchy)
  * `ps -u [username]` (all for a user)
  * -f switch to see switches used to launch and path to executable
* Monitoring
  * `uptime` includes load average
  * `free -mt` shows memory utilization in mb, and totals
  * `pgrep -a httpd`  all details for httpd processes. 
    * -u username
    * -P parent process id
    * -f process name
    * -l display process name
  * `kill -l` list signals
    * read man 7 signal
    * 1: SIGHUP - Restart with the same pid
    * 2: SIGINT - sends ctrl+c to process
    * 9: SIGKILL  kill is ungraceful stop, leaves resources behind
    * 15: SIGTERM  graceful  - kill with no options is sigterm, cleans up used resources
  * `pkill (-f) httpd` kills all httpd processes, integrates grep functionality
  * pgrep and pkill can be used to search and kill processes based on patterns and not a pid
    * While attempting to shut down the Apache service with "systemctl stop httpd" you notice that there are httpd processes that are refusing to shut down. How might you send a SIGTERM signal to try and gently stop the processes to all httpd processes? https://linuxacademy.com/cp/courses/lesson/course/2170/lesson/2/module/214 
    * `killall httpd`  (-s 9)
  * `watch` runs the same command every 2 sec  (-n 5 for 5 sec)
  * `screen` run a shell from which you can disconnect
    * `ctrl+a d` to detach
    * `screen -r [scrid]` to reattach
    * `screen -ls` to list running sessions
    * `exit` (while attached)
  * `tmux` to open a new shell
    * `ctrl+b d` to dettach 
    * `ctrl+b $` to rename
    * `ctrl+b c` to create a new window
    *   " split top/bottom
    *   % split left/right
    * `tmux ls`
    * `tmux attach-session -t [numsession]`
    * `exit` or `ctrl+b &`
  * `nohup`
    * a nohup process will continue even when the shell that created it is exited
  * `nohup ping www.google.com &`  sends the command to the background
    * `jobs` to see these background processes
    * writes to nohup.out file which can be "tailed"
    * `fg [num]` to bring back to foreground
    * Ctrl+z to send to background (stops job)
    * `bg %1` background
    * kill pid to stop the job
  * top
    * u key and enter username, r pid enter new level to renice
    * run top as root to lower the nice level (higher priority)
    * Columns
      * PID
      * USER
      * PR - Priority (0 is higher priority)
      * NI - Nice
      * VIRT - virtual memory
      * RES - Resident size (physical RAM)
      * SHR - Shared memory
      * S - Status (D uninteruptibly sleeping, R Running, S Sleeping, T Traced/Stopped, Z Zombied)
      * %CPU
      * %MEM
      * TIME+
      * COMMAND
    * kill a process from top
      * press k
      * enter the pid
      * press enter x2

### 103.6 Modify process execution priorities
* https://www.youtube.com/watch?v=NY58UXpaC-s&list=PLq1noKggzASu92gX_ARJRk-W9aX_4OL7d&index=65
* Description: Candidates should should be able to manage process execution priorities.
  * Key Knowledge Areas:
  * Know the default priority of a job that is created.
  * Run a program with higher or lower priority than the default.
  * Change the priority of a running process.
* The following is a partial list of the used files, terms and utilities:
  * nice
  * ps
  * renice
  * top
* Process priority (nice levels)
  * -20 highest, 0 default, 19 lowest
  * `ps -o pid,nice,cmd,user`
  * `nice -n 5 [cmd]`  runs the cmd with a nice level 5 (lower pri)
  * `sudo renice -n -1 [pid]` change nice level to -1
  * niceness values range from -20 to 19, with the former being most favorable,while latter being least
  * A value of -20 represents the highest priority level, whereas 19 representsthe lowest. (A 19 is "nicer" than -20)
  * Only root can assign a nice value lower than zero

### 103.7 Search text files using regular expressions
* Description: Candidates should be able to manipulate files and text data using regular expressions. This objective includes creating simple regular expressions containing several notational elements as well as understanding the differences between basic and extended regular expressions. It also includes using regular expression tools to perform searches through a filesystem or file content.
* Key Knowledge Areas:
  * Create simple regular expressions containing several notational elements.
  * Understand the differences between basic and extended regular expressions.
  * Understand the concepts of special characters, character classes, quantifiers and anchors.
  * Use regular expression tools to perform searches through a filesystem or file content.
  * Use regular expressions to delete, change and substitute text.
* The following is a partial list of the used files, terms and utilities:
  * grep
  * egrep
  * fgrep
  * sed
  * regex(7)
* Regular Expressions
  * `grep g.m [file]`  1st chr g, 2nd anything, 3rd m
  * `grep ^rpc /etc/passwd` line starts with rpc
  * `grep bash$ /etc/passwd` line ends with bash
  * `grep [v] /etc/passwd` line with a 'v'
  * -i case insensitive
  * `grep ^[Aa].[Aa][^h] /etc/passwd` 1st and 3rd chr is a or A, no h 4th
  * be careful of '*' char, it means to match some combination of the string before it. This one is odd, prob not used much.
  * sed
    * `cat passwd | sed -n '/nologin$/p'` lines end in nologin
    * `cat passwd | sed '/nologin$/d'` delete nologin lines
  * egrep - extended grep (same as grep -E)
    * `egrep 'bash$' passwd` lines that end in bash, -c for count
    * `egrep '^rpc|nologin$' passwd` starts with rpd OR ends with nologin
  * fgrep will interpret the pattern as plain text strings to match (same as grep -F)
    * to search for '$' (special chr) it must be escaped with grep, but not fgrep
      * `grep '\$' [file]` is the same as
      * `fgrep '$' [file]`
    * `fgrep -f [file with strings] [file to be searched]`
    * file to be searched can use file globbing
* Grep notes
  * ^goober  ---  all lines that begin with 'goober'
  * goober$ lines that end with 'goober'
  * [] match any of the characters in the brackets
  * ^[] match lines that start with a character in the brackets
  * [a-j] all characters between a and j
  * -c  ---  count

### 103.8 Basic file editing
* Description: Candidates should be able to edit text files using vi. This objective includes vi navigation, vi modes, inserting, editing, deleting, copying and finding text. It also includes awareness of other common editors and setting the default editor.
* Key Knowledge Areas:
  * Navigate a document using vi.
  * Understand and use vi modes.
  * Insert, edit, delete, copy and find text in vi.
  * Awareness of Emacs, nano and vim.
  * Configure the standard editor.
* Terms and Utilities:
  * vi
  * /, ?
  * h,j,k,l
  * i, o, a
  * d, p, y, dd, yy
  * ZZ, :w!, :q!
  * EDITOR
* Text Files
  * vi/vim 
    * insert to replace mode:  First hit ESC key, then the shift + R keys.
    * All delete commands begin with a 'd', and the 'e' refers to a word under the cursor that is to be deleted, without   deleting the space after the word
    * Given that you are already in insert mode, which steps would you take to enter into replace mode? First hit ESC key,   then the shift + R keys.
    * vim visual mode (v), yank (y), put (p)
    * vim end of file `G`

## Topic 104: Devices, Linux Filesystems, Filesystem Hierarchy Standard
### 104.1 Create partitions and filesystems
* Description: Candidates should be able to configure disk partitions and then create filesystems on media such as hard disks. This includes the handling of swap partitions.
* Key Knowledge Areas:
  * Manage MBR and GPT partition tables
  * Use various mkfs commands to create various filesystems such as: 
    * ext2/ext3/ext4
    * XFS
    * VFAT
    * exFAT
  * Basic feature knowledge of Btrfs, including multi-device filesystems, compression and subvolumes.
* The following is a partial list of the used files, terms and utilities:
  * fdisk
  * gdisk
  * parted
  * mkfs
  * mkswap
* Linux File Systems
  * Non-Journaling
    * ext2  second extended fs
      * Max file 2 TB
      * Max vol size 4 TB
      * Max name 255 chrs
      * Long recovery time
  * Journaling - eliminates long recoveries
    * ext3 - slightly slower
    * Reiser FS - not compatible with ext2
    * ext4
      * Max file 16 TB
      * Mac vol 1 exabyte
      * Max name 255 chrs
      * checksums on Journal
    * XFS
      * requires installtion of xfs support for the kernel
  * Btrfs - still in development
    * Cow Copy on Write
    * Subvolumes/Storage Pools (same?)
      * Alternative to Partitioning
    * Snapshots
  * FAT FS
    * VFAT - allows for long file names
    * EFI boot partitions need to use FAT
  * exFAT (extended)
    * allows for files larger then 2GB
  * `mkfs -t ext4`
  * `mkfs.ext4 -L label /dev/sda1`
  * `lsblk -f` to see file systems
* mkswap, swapon, swapoff
* mke2fs - create an ext2/ext3/ext4 filesystem
  * /etc.mke2fs.conf - contains defaults
* `mkfs.[fs]` minix,ntfs,bfs,ext4,msdos,cramfs,ext3,ext2,vfat,xfs
  * runs commands found in /sbin
* `mkfs -t [fs type] /dev/xxxx`
  * -b blocksize 1024/2048/4096
  * -N inodes
  * -i bytes_per_inode
  * -j create journal (can convert ext2 to ext3)
* `mk2fs`
  * -L label
* Superblock is first block of the partition
* `mkreiserfs`
* Disk Partitioning Utilities
  * Delete partition scheme?  
    * `dd if=/dev/zero of=/dev/sd[x] bs=512 count=1` This zeros out the mbr
    * `wipefs -a /dev/sda`  Does the same thing (perhaps a bit cleaner)
  * fdisk for mbr
  * gdisk for gpt
    ```
    gdisk commands (partial) (fdisk is largely the same)
    d	delete a partition
    i	show detailed information on a partition
    l	list known partition types
    n	add a new partition
    o	create a new empty GUID partition table (GPT)
    p	print the partition table
    q	quit without saving changes
    t	change a partition's type code
    w	write table to disk and exit
    ?	print this menu
    ```
  * parted for both?
    * `parted -l` to see if a disk is mbr/gpt/loop(- this is raw disk access without a partition table)

### 104.2 Maintain the integrity of filesystems
* Description: Candidates should be able to maintain a standard filesystem, as well as the extra data associated with a journaling filesystem.
* Key Knowledge Areas:
  * Verify the integrity of filesystems.
  * Monitor free space and inodes.
  * Repair simple filesystem problems.
* The following is a partial list of the used files, terms and utilities:
  * du
  * df
  * fsck
  * e2fsck - for ext2 fs
  * mke2fs
  * tune2fs
  * xfs_repair
    * `xfs_repair /dev/sdd1`
  * xfs_fsr
  * xfs_db
* Disk Utilization
  * `df -h /` - disk free  
    * man: report file system disk space usage
    * -T for type
    * `-i --inode` inode utilization
  * `du -h /`
    * man: estimate file space usage
    * `du -sh /tmp --max-depth=2`  
    * recursive
    * provide summary of disk space used by each file recursively
  * `lsof` Man: list open files
    * -s size
    * -t terse output
    * -u username
  * `fuser` what processes have files open
    * man: identify processes using files or sockets
    * -a all files
    * -k kill process accessing a file
    * -i interactive/confirm
    * -u user  `fuser -u /usr/bin/top` what user is running top
* File System Maintenance
  * fsck - must umount first
    * -r report
    * front end to multiple specfic to fs utilities
  * e2fsck can check ext2/3/4
    * e2fsck -f -b backup_superblock device
      * -f force
      * -p to repair
  * tune2fs - adjust tunable filesystem parameters on ext2/ext3/ext4 filesystems
    * -l to list current settings
    * -i modify the amount of time between file system checks on and EXT4 file system (3w for 3 weeks etc)
    * Errors behavior, Check interval
  * xfs_repair - repair an XFS filesystem
  * xfs_fsr - filesystem reorganizer for XFS (defrag)
  * xfs_db - debug an XFS filesystem

## 104.3 Control mounting and unmounting of filesystems
* Description: Candidates should be able to configure the mounting of a filesystem.
* Key Knowledge Areas:
  * Manually mount and unmount filesystems.
  * Configure filesystem mounting on bootup.
  * Configure user mountable removable filesystems.
  * Use of labels and UUIDs for identifying and mounting file systems.
  * Awareness of systemd mount units.
* The following is a partial list of the used files, terms and utilities:
  * /etc/fstab
  * /media/
  * mount
  * umount
  * blkid
  * lsblk
* mount /dev/sdxx /dir
* Mounted and mounting file systems
  * /etc/mtab, /etc/mtab -> /proc/mounts
* Example fstab entries
  * UUID=8e8965c3-970c-4f56-87e6-782dd56b154d         /part1         ext2   defaults
  * LABEL=cloudimg-rootfs	/	 ext4	defaults	0 0
  * LABEL=part1-ext2	/part1 	 ext2 	defaults 	0 0
  * LABEL=part2-ext3        /part2   ext3   defaults        0 0
  * LABEL=part3-ext4        /part3   ext4   defaults        0 0
* The last 0 runs fsck for the partition when the system deems it necessary

### 104.5 Manage file permissions and ownership
* Description: Candidates should be able to control file access through the proper use of permissions and ownerships.
* Key Knowledge Areas:
  * Manage access permissions on regular and special files as well as directories.
  * Use access modes such as suid, sgid and the sticky bit to maintain security.
  * Know how to change the file creation mask.
  * Use the group field to grant file access to group members.
* The following is a partial list of the used files, terms and utilities:
  * chmod
  * umask
  * chown
  * chgrp
* FS perms
  * chmod
    * `chmod o=rx [file]`
  * chgrp
  * `chown [owner]:[group] [file]`
  * suid - set user bit, not used much any more `chmod 4xxx file`. `chmod u+s file`
    * Largely deprecated due to security concerns
    * SUID (Set owner User ID up on execution)
    * rwSrwxrwx - Cap S indicates owner does NOT have execute permissions
    * rwsrwxrwx - lower s indicates owner does have execute permissions
    * users will get file owner’s permissions as well as owner UID and GID when executing a file/program/command.
    * The utility 'ping' has the suid bit set on it
      ```
      ls -ll /bin/ping
      -rwsr-xr-x 1 root root 64424 Mar  9  2017 /bin/ping
      ```
    * This allows users to use it. That is users will have root permission for this command only. Without the bit, users will get permission denied
    * A simple script cannot use this functionality. An app needs to be written specifically to utilize it.  
  * sgid = set group bit `chmod -R 2xxx file` `chmod g+s file`
    * files inherit the group of the folder, useful for collaboration
    * used on a file, an application can run as the group assigned to the app
    * used on a directlry files inherit the group of the directory, useful for collaboration
    * users will get file Group’s permissions when executing a Folder/file/program/command. 
    * SGID is similar to SUID. The difference between both is that SUID assumes owner of the file permissions and SGID assumes group’s permissions when executing a file instead of logged in user inherit permissions. Also most file systems are mounted with the nosuid option
    * set sgid on a dir has another use
      * files created in a dir with the sgid bit set will inherit the group that is assigned to the dir
    * `chmod 2xxx -R /path/to/dir` will change existing file permissions recursively, but will not change the group
    * Therefore a chgrp -R would be necessary on existing files  
  * sticky bit - t in place of x in last column `chmod 1xxx file`, `chmod o+t /opt/dump/` or `chmod +t /opt/dump/`
    * only owner of a file can remove a file even if others or group has w access
    * -rw-rw-r-t/T
    * https://www.linuxnix.com/sticky-bit-set-linux/
    * After setting Sticky Bit to a file/folder, if you see ‘T’ in the file permission area that indicates the file/folder does not have executable permissions for all users on that particular file/folder.
    * The sticky bit is already set on the /tmp dir  
  * umask - value to subtact from default permissions, 666 for files and 777 for directories
    * set in the /etc/bashrc file and /home/[user]/.bashrc
    * `umask u=rwx,g=,o=` or `umask 0077`
    * root has a umask of 0022
    * users typically has a mask of 0002
    * set symbolically, `umask u=rwx,g=,o=`

### 104.6 Create and change hard and symbolic links
* Description: Candidates should be able to create and manage hard and symbolic links to a file.
* Key Knowledge Areas:
  * Create links.
  * Identify hard and/or soft links.
  * Copying versus linking files.
  * Use links to support system administration tasks.
* The following is a partial list of the used files, terms and utilities:
  * ln
  * ls
* Links 
  * A hard link does not become disconnected from the underlying file if the file is moved.
* Symbolic Links
  * These are really just shortcuts
  * `ln -s Documents/my-file.txt my-file.txt.lnk`
  * `unlink my-file.txt.lnk`
* symbolic link
  * The -s option must be provided to the ln command for symbolic links. 
  * The item to be linked must come before the name of the link itself. 

### 104.7 Find system files and place files in the correct location
* Description: Candidates should be thoroughly familiar with the Filesystem Hierarchy Standard (FHS), including typical file locations and directory classifications.
* Key Knowledge Areas:
  * Understand the correct locations of files under the FHS.
  * Find files and commands on a Linux system.
  * Know the location and purpose of important file and directories as defined in the FHS.
* The following is a partial list of the used files, terms and utilities:
  * find
  * locate
  * updatedb
  * whereis
  * which
  * type
  * /etc/updatedb.conf

# Exam 102
## Topic 105: Shells and Shell Scripting
### 105.1 Customize and use the shell environment
* Description: Candidates should be able to customize shell environments to meet users' needs. Candidates should be able to modify global and user profiles.
* Key Knowledge Areas:
  * Set environment variables (e.g. PATH) at login or when spawning a new shell.
  * Write Bash functions for frequently used sequences of commands.
  * Maintain skeleton directories for new user accounts.
  * Set command search path with the proper directory.
* The following is a partial list of the used files, terms and utilities:
  * .
  * source
  * /etc/bash.bashrc
  * /etc/profile
  * env
  * export
  * set
  * unset
  * ~/.bash_profile
  * ~/.bash_login
  * ~/.profile
  * ~/.bashrc
  * ~/.bash_logout
  * function
  * alias
* Logon configuration files
  * ~/.bashrc (read by non-login shells as well as others)
  * /etc/profile (not recommended)
  * /etc/profile.d/[file].sh  ---  All .sh files here are run for every user logon.
  * bash configuration file sequence: read first when a login bash shell is run:  The /etc/profile configuration file is read first in the sequence. The other files are called via the /etc/profile. 
* Shell environments
  * Interactive at console
    * /etc/profile
      * Do not make changes here, rather add a file to profile.d directory
      * sets up path and history file size
      * umask
    * /etc/profile.d/*
    * ~/.bash_profile (some systems, like Ubuntu, will be ~/.profile)
      * calls .bashrc
      * further sets up path
      * customize PATH here
    * ~/.bashrc
      * calls /etc/bashrc
      * !!set up customizations here!!
    * /etc/bashrc
      * sets up the terminal appearance
      * shell options
  * Interactive via SSH
  * Interactive Non-Login Shell (terminal application like GNOME terminal)
    * ~/.bashrc
    * /etc/bashrc
* `echo $0` to see which environment the shell is in:
  * -bash indicates a login shell
  * bash (no dash, non-login shell)
* /etc/skel -- directory could to which add files so that a newly created user will automatically have them when they first log in
  * includes .bash_logout, .bash_profile, .bashrc
* ~/.bash_login file --  Optional
* Configure /root/bin for scripts
  * Logon as root with root profile `sudo su -`
  * Create bin dir in root home
  * Create/Edit .bash_profile
    ```
    # .bash_profile
    
    PATH=$PATH:$HOME/bin:/scripts
    export PATH
    ```
* from the bash man page:

  * /bin/bash
    * The bash executable
  * /etc/profile
    * The systemwide initialization file, executed for login shells
  * /etc/bash.bash_logout
    * The  systemwide  login shell cleanup file, executed when a login shell exits
  * ~/.bash_profile
    * The personal initialization file, executed for login shells
  * ~/.bashrc
    * The individual per-interactive-shell startup file
  * ~/.bash_logout
    * The individual login shell cleanup file, executed when a login shell exits
  * ~/.inputrc
    * Individual readline initialization file


First, ~/.bash_profile and ~/.profile are the same file. Some distros use one, some use the other (e.g. Archlinux uses the former, openSuSE uses the latter). The profile is only invoked on "login" shells, the bash "run control", ~/.bashrc is invoked for each interactive shell. So things you only invoke on login go in your profile, everything else goes in the run control file.


### 105.2 Customize or write simple scripts
* Description: Candidates should be able to customize existing scripts, or write simple new Bash scripts.
* Key Knowledge Areas:
  * Use standard sh syntax (loops, tests).
  * Use command substitution.
  * Test return values for success or failure or other information provided by a command.
  * Execute chained commands.
  * Perform conditional mailing to the superuser.
  * Correctly select the script interpreter through the shebang (#!) line.
  * Manage the location, ownership, execution and suid-rights of scripts.
* The following is a partial list of the used files, terms and utilities:
  * for
  * while
  * test
  * if
  * read
  * seq
  * exec
  * ||
  * &&

## Topic 106: User Interfaces and Desktops
### 106.1 Install and configure X11
* Description: Candidates should be able to install and configure X11.
* Key Knowledge Areas:
  * Understanding of the X11 architecture.
  * Basic understanding and knowledge of the X Window configuration file.
  * Overwrite specific aspects of Xorg configuration, such as keyboard layout.
  * Understand the components of desktop environments, such as display managers and window managers.
  * Manage access to the X server and display applications on remote X servers.
  * Awareness of Wayland.
* The following is a partial list of the used files, terms and utilities:
  * /etc/X11/xorg.conf
  * /etc/X11/xorg.conf.d/
  * ~/.xsession-errors
  * xhost
  * xauth
  * DISPLAY
  * X

## 106.2 Graphical Desktops
* Description: Candidates should be aware of major Linux desktops. Furthermore, candidates should be aware of protocols used to access remote desktop sessions.
* Key Knowledge Areas:
  * Awareness of major desktop environments
  * Awareness of protocols to access remote desktop sessions
* The following is a partial list of the used files, terms and utilities:
  * KDE
  * Gnome
  * Xfce
  * X11
  * XDMCP
  * VNC
  * Spice
  * RDP
* Gui etc
  * GTK+
    * Gnome
    * XFCE
  * Qt Based
    * KDE
  * Alt+F2 is like a 'run' text box
  ```
  Remote access.  Currently, it is possilbe to ssh from Ubuntu box:  172.28.128.4 to CentOS box:  172.28.128.5
  
  Set up CentOS for (Tiger) VNC Server
  
  As root:
  yum install tigervnc-server -y
  
  copy systemd template file
  and assign each session its own unique number (implies more than one could be running?)
  cp /usr/lib/systemd/system/vncserver@.service /etc/systemd/system/vncserver@:1.service
  
  Configure the service to work with a user
  vim /etc/systemd/system/vncserver@:1.service
  Use sed to replace "<USER>" with "vagrant"
  :%s/<USER>/vagrant/g
  Then save/close the file
  
  reload systemd for changes to take effect
  systemctl daemon-reload
  
  As vagrant user (open new terminal)
  vncpasswd  (vagrant)  n to view-only
  
  As root again (original terminal)
  systemctl start vncserver@:1
  systemctl status vncserver@:1
  systemctl enable vncserver@:1
  
  ss -tlpn | vnc
  to verify VNC is running on port 5901
  
  If ncessessary open port on firewall
  firewall-cmd --permanent --add-port=5901/tcp
  firewall-cmd --reload
  
  Ubuntu client
  sudo apt install vinagre
  Run vinagre from Activities
  Connect, VNC
  Host: 172.28.128.5:5901
  Connect button then password
  ```

### 106.3 Accessibility
* Description: Demonstrate knowledge and awareness of accessibility technologies.
* Key Knowledge Areas:
  * Basic knowledge of visual settings and themes.
  * Basic knowledge of assistive technology.
* The following is a partial list of the used files, terms and utilities:
  * High Contrast/Large Print Desktop Themes.
  * Screen Reader.
  * Braille Display.
  * Screen Magnifier.
  * On-Screen Keyboard.
  * Sticky/Repeat keys.
  * Slow/Bounce/Toggle keys.
  * Mouse keys.
  * Gestures.
  * Voice recognition.

## Topic 107: Administrative Tasks
### 107.1 Manage user and group accounts and related system files
* Description: Candidates should be able to add, remove, suspend and change user accounts.
* Key Knowledge Areas:
  * Add, modify and remove users and groups.
  * Manage user/group info in password/group databases.
  * Create and manage special purpose and limited accounts.
* The following is a partial list of the used files, terms and utilities:
  * /etc/passwd
  * /etc/shadow
  * /etc/group
  * /etc/skel/
  * chage
  * getent
  * groupadd
  * groupdel
  * groupmod
  * passwd
  * useradd
  * userdel
  * usermod
* `useradd`
  * -m homedir
  * -c comment (often the user full name)
  * -s shell (/bin/tcsh is advanced c shell)
  * `useradd -G 1001/curators -m -c "Eva Doe" eva`
    * -G supplementary group
  * `cat /etc/default/useradd` default settings for useradd
  * system users (run daemons, id usually less than 1000?)
* `passwd`
  * -e expire
* `userdel`
  * -r remove user home dir
* `usermod`
  * mostly same switches as useradd
  * `usermod -a -G [groupname] [username]`  -a appends to existing user groups
  * `usermod -L [username]` lock an account (! is first chr /etc/shadow)
    * -U unlock
    * -r system account
    * -d home directory (must create and give ownership of directory)
* `chage -E 2020-01-01 [username]`  Change Age
  * -l  list password age/expiration details
  * -W  pw exp warn period
* `groups`
  * groups that logged on user is a member of
* `groupadd curators` (gid 1001)
* `groupdel`
* `groupmod -g 1100 [groupname]` change GID
  * -n new name
* `gpasswd` - administer /etc/group and /etc/gshadow
* `cat /etc/passwd`
  * username:password(x):UID:Pri GID:Comment:Home Dir Path:Shell
* `cat /etc/shadow`
* `cat /etc/group`
  * groupname:password(x):GID:Other users in group
* `ls  -a /etc/skel`
* `cat /etc/default/useradd` useradd configuration
* `cat /etc/login.defs`  overrides useradd config
* `getent group 100`
  * Get Entries
  * same as cat /etc/passwd or group with a grep for specific entry
* `who` or `w` to see the logged on users
* `id [username]` details of logged on user
* wheel group (can run sudo) /etc/sudoers
* dcoate is NOT in /etc/passwd
* `passwd eva` change the password for eva
* `last` recent logins

### 107.2 Automate system administration tasks by scheduling jobs
* Description: Candidates should be able to use cron and systemd timers to run jobs at regular intervals and to use at to run jobs at a specific time.
* Key Knowledge Areas:
  * Manage cron and at jobs.
  * Configure user access to cron and at services.
  * Understand systemd timer units.
* The following is a partial list of the used files, terms and utilities:
  * /etc/cron.{d,daily,hourly,monthly,weekly}/
  * /etc/at.deny
  * /etc/at.allow
  * /etc/crontab
  * /etc/cron.allow
  * /etc/cron.deny
  * /var/spool/cron/
  * crontab
  * at
  * atq
  * atrm
  * systemctl
  * systemd-run
* `crontab -e` edit the logged on user's crontab
  * -l to list the contents
  * /var/spool/cron/[username]
  * -r to delete
  * -u another user's crontab (given permissions)
* `sudo ls /etc/cron*`  (Ubuntu)
  ```
  /etc/crontab
  
  /etc/cron.d:
  anacron  mdadm	popularity-contest
  
  /etc/cron.daily:
  0anacron      cracklib-runtime	mdadm		    ubuntu-advantage-tools
  apport	      dpkg		mlocate		    update-notifier-common
  apt-compat    logrotate		passwd
  bsdmainutils  man-db		popularity-contest
  
  /etc/cron.hourly:
  
  /etc/cron.monthly:
  0anacron
  
  /etc/cron.weekly:
  0anacron  man-db  update-notifier-common
  ```
* Users in /etc/cron.deny cannot run cron jobs
* AT Jobs - One time, ad-hoc jobs scheduled in the future
  * `sudo yum/apt -install at`
  * `systemctl start atd.service`
  * `systemctl enable atd.service`
  * `at now + 5 min` Then enter commands, ctrl+d (EOT)
  * `at 4:00 AM tomorrow`
  * `atq`  at queue, returns job num and info
  * `atrm [num]` to remove
  * `at -f path/to/script.sh 10:15 PM Oct 8`
  * /etc/at.allow or deny
* Systemd Timer Unit Files
  * Monotonic (sort of like AT)
    * OnBootSec, OnUnitActioveSec
  * Realtime (sort of like cron)
    * OnCalendar
  * Transient (also like AT?)
  * `systemctl list-timers --all`
  * `systemctl cat [unit-from-list-timers]`
  * `systemctl cat [activates-from-list-timers]`
* Simplest possible service unit
  * Make file /etc/systemd/system/web-backup.service as root/sudo
  * `sudo systemctl daemon-reload`
  * `sudo systemctl start web-backup.service`
  ```
  [Unit]
  Description=MyTimer
  
  [Service]
  ExecStart=/bin/bash /home/vagrant/web-backup.sh
  ```
* A Timer Unit to go with the service
  * Make file /etc/systemd/system/web-backup.timer as root/sudo
  * sudo systemctl start web-backup.timer
  * sudo systemctl enable web-backup.timer ????
  ```
  [Unit]
  Description=Runs web-backup every min
  
  [Timer]
  OnUnitActiveSec=1m
  Unit=web-backup.service
  
  [Install]
  WantedBy=graphical.target
  ```

### 107.3 Localisation and internationalisation
* Description: Candidates should be able to localize a system in a different language than English. As well, an understanding of why LANG=C is useful when scripting.
* Key Knowledge Areas:
  * Configure locale settings and environment variables.
  * Configure timezone settings and environment variables.
* The following is a partial list of the used files, terms and utilities:
  * /etc/timezone
  * /etc/localtime
  * /usr/share/zoneinfo/
  * LC_*
  * LC_ALL
  * LANG
  * TZ
  * /usr/bin/locale
  * tzselect
  * timedatectl
  * date
  * iconv
  * UTF-8
  * ISO-8859
  * ASCII
  * Unicode

## Topic 108: Essential System Services
### 108.1 Maintain system time
* Description: Candidates should be able to properly maintain the system time and synchronize the clock via NTP.
* Key Knowledge Areas:
  * Set the system date and time.
  * Set the hardware clock to the correct time in UTC.
  * Configure the correct timezone.
  * Basic NTP configuration using ntpd and chrony.
  * Knowledge of using the pool.ntp.org service.
  * Awareness of the ntpq command.
* The following is a partial list of the used files, terms and utilities:
  * /usr/share/zoneinfo/
  * /etc/timezone
  * /etc/localtime
  * /etc/ntp.conf
  * /etc/chrony.conf
  * date
  * hwclock
  * timedatectl
  * ntpd
  * ntpdate
  * chronyc
  * pool.ntp.org

### 108.2 System logging
* Description: Candidates should be able to configure rsyslog. This objective also includes configuring the logging daemon to send log output to a central log server or accept log output as a central log server. Use of the systemd journal subsystem is covered. Also, awareness of syslog and syslog-ng as alternative logging systems is included.
* Key Knowledge Areas:
  * Basic configuration of rsyslog.
  * Understanding of standard facilities, priorities and actions.
  * Query the systemd journal.
  * Filter systemd journal data by criteria such as date, service or priority.
  * Configure persistent systemd journal storage and journal size.
  * Delete old systemd journal data.
  * Retrieve systemd journal data from a rescue system or file system copy.
  * Understand interaction of rsyslog with systemd-journald.
  * Configuration of logrotate.
  * Awareness of syslog and syslog-ng.
* Terms and Utilities:
  * /etc/rsyslog.conf
  * /var/log/
  * logger
  * logrotate
  * /etc/logrotate.conf
  * /etc/logrotate.d/
  * journalctl
  * systemd-cat
  * /etc/systemd/journald.conf
  * /var/log/journal/
  * /var/log
* boot.log
* messages
  * /var/log messages how many times remote users have opened secure shells into the current system
* secure
* kernel ring buffer (in memory, read with dmesg)