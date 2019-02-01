# LPIC 1 Exam Notes

## Resources
http://www.gocertify.com/quizzes/linux-practice-questions/linux-lpi101-lx0101-quiz.html

https://itbeginner.net/linux-essentials-exam-answer-test-online-pdf
https://itbeginner.net/linux-essentials-chapter-1-test-online-2016.html

These exams are from 2011
http://gnosis.cx/publish/programming/exam101.html
http://gnosis.cx/publish/programming/exam102.html

https://www.lpi.org/our-certifications/exam-101-objectives

https://developer.ibm.com/tutorials/l-lpic1-map/

http://www.linuxdoc.org/ - BEST first internet site to go to for information about how to perform an unfamiliar Linux task

youtube videos?
https://www.youtube.com/user/AnthonyIrwinVideos/playlists

## To Be sorted
* `xfs_repair /dev/sdd1`
* mtime ????
  * Partitions /dev/sd[a,b,c][1,2,3]  (sda1 is first partition of first drive)
  * `lsblk`
  * `sudo fdisk -l /dev/sda`
  * `swapon -summary`
  * mkdir -p Projects/{ancient,classical,medieval}

## Consoles
* tty1 through tty6

* On CentOS in Gui mode
  * open a terminal here
    * `tty` will return /dev/pts/0 (or 1..?)
    * This is a pseudo console
    * open another terminal and `tty` will return /dev/pts/1 (or next in seq)
    * ssh to this box from elsewhere and `tty` will return /dev/pts/2 (or next in seq)
  * Alt+Ctrl+F2..F7 will switch to text based (physical) console
    * `tty` will return /dev/tty2, a physical/virtual terminal
  * Alt+Ctrl+F1 will go back to the Gui.
  * `chvt [num]` will swtich as well
  * `who` will list all of the terminals
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

* Virtual Terminals
  * Alt+Ctrl+F1..F7 (or more)
  * Switches between Virtual Terminals
  * So Alt+Ctrl+F1 will switch to VT1 and allow logon to a text based terminal
  * on Centos GUI is on tty1. VT7 (Alt+Ctrl+F7) is often, but not always the GUI
  * `chvt`

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
* `ctrl+l` clear
* `ctrl+z` to put process in background



## Topic 101: System Architecture
### 101.1 Determine and configure hardware settings
* Weight: 2
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
  * lsmod - Show the status of modules in the Linux Kernel
  * rmmod - Simple program to remove a module from the Linux Kernel
  * insmod - Simple program to insert a module into the Linux Kernel
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

### 101.2 Boot the system
* Description: Candidates should be able to guide the system through the booting process.
* Key Knowledge Areas:
  * Provide common commands to the boot loader and options to the kernel at boot time.
  * Demonstrate knowledge of the boot sequence from BIOS/UEFI to boot completion.
  * Understanding of SysVinit and systemd.
  * Awareness of Upstart.
  * Check boot events in the log files.
The following is a partial list of the used files, terms and utilities:
* dmesg
  * -H human readable
  * -C clear
  * -w wait
* journalctl
* BIOS
* UEFI
* bootloader
* kernel
* initramfs
* init
* SysVinit
* systemd

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
* Init
  * System V (5)
  * Loads services one at a time
  * /sbin/init
  * /etc/inittab
    * `<id>:<runlevel>:<action>:<process>`
  * /etc/rc.d  - Red hat
  * /etc/init.d - Debian
  * `runlevel` to see current runlevel
  * `telinit 3` to change to runlevel 3
```
  Runlevel | Purpose
  |-|-
  0 | Halt
  1 | Single user mode
  2 | Multi-user mode (no networking)
  3 | Multi-user mode (with networking)
  4 | unused
  5 | Multi-user, w/net and GUI
  6 | reboot

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
  * Target types
    * multi-user.target (like runlevel 3)
    * graphical.target (like runlevel 5)
    * rescue.target (like runlevel 1)
    * basic.target - used during boot process before another target
    * sysinit.target - system initialization
    * Docs
      * man 5 systemd.target
      * man 7 system.special
  * `systemctl cat [some].target`
  * `systemctl list-unit-files -t target`
  * `systemctl list-units -t target` list active
  * `systemctl get-default`  default target
  * `systemctl set-default` 
  * `systemctl isolate multi-user.target` change targets (allow isolate must be enabled)
  * `systemctl rescue`
  * `systemctl poweroff`
  * `systemctl reboot`

* systemd systems
  * see https://www.digitalocean.com/community/tutorials/how-to-use-systemctl-to-manage-systemd-services-and-units for a better organized overview?
 * Target types (found in /usr/lib/systemd/system)
    * halt.target (like runlevel 0)
    * poweroff.target (better to use than halt)
    * multi-user.target (like runlevel 3)
    * graphical.target (like runlevel 5)
    * rescue.target (like runlevel 1)
    * basic.target - used during boot process before another target
    * sysinit.target - system initialization
    * reboot.target (like runlevel 6)
  * Adjusting the System State (Runlevel) with Targets
    * `systemctl get-default` shows current runlevel/target
    * `sudo systemctl set-default graphical.target`
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
  * `systemctl show cups.service -p Conflicts` Conflists property
  * `sudo systemctl edit cups.service --full`
    * the changed file will be written to /etc/systemd/system
    * To remove any additions, delete the unit's .d configuration directory or the   modified service file from /etc/systemd/system. 
    * `sudo rm -r /etc/systemd/system/nginx.service.d`
    * `sudo rm /etc/systemd/system/nginx.service`

https://www.digitalocean.com/community/tutorials/understanding-systemd-units-and-unit-files

  * `systemctl list-unit-files` --type/-t service/timer
  * `systemctl list-timers` --all to see inactive
    * mask = disabled

* `sudo journalctl -u mytimer.timer`  -f to view the log from the end

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

* Main File System Locations
  * / root
  * /var - (variable) dynamic content, log files, websites
    * Should be on separate partition
  * /home
  * /boot - kernal and supporting files
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
  * /srv - not used on CentOS uses /var instead. Might put databases here
  * /usr
    * Sample: bin etc games include lib lib64 libexec local sbin share src tmp
    * /usr/share/doc - location for more docs for apps
  * /opt - (optional) third party, Enterprise environments
  * /swap (older 1.x to 2.0x of RAM, newer no less than 50% of RAM)
  * /dev quasi-pseudo
  * /sys - pseudo  (sysfs)  --  devices etc
  * /proc - pseudo  --  processes, can view things as txt files like the cmdline to start the process


* /etc file system (system-related configuration files)
  * /etc/default/grub
  * /etc/resolv.conf
  * /etc/hosts
  * /etc/network/interfaces
  * /etc/network/interfaces.d/*
  * /etc/samba/smb.conf
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
  * /etc/ld.so.conf
  * /etc/acpi

File System Hierarchy Std:  http://www.pathname.com/fhs/ and https://wiki.linuxfoundation.org/lsb/start
http://refspecs.linuxfoundation.org/FHS_3.0/fhs/index.html
* bin
* boot
* dev
* etc
* home
* lib
* lib64 - .so (shared object) files
* media
* mnt
* opt
* proc
* root
* sbin
* srv
* sys
* tmp
* usr
* var


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



  * (This might still be grub2, but deb based systems use grub and not grub2 for commands???)
  * There is no /boot/efi so it appears to be just grub
* used with MBR

  * grub.conf (rh)/menu.lst(deb)
  * device.map
* run grub to get into the grub shell (my systems do not have this)
* `sudo vim /etc/default/grub`, then `update-grub`

* 

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


sudo yum list installed pow*
* Installed Packages
* powershell.x86_64          6.1.2-1.rhel.7           @packages-microsoft-com-prod
sudo rpm -qa pow*
* powershell-6.1.2-1.rhel.7.x86_64


* rpm2cpio some.rpm | cpio -idmv convert to cpio archive file  ---  Extraction tool
  * cpio is an archive program similar to tar
  * rpm pkgs are cpio files with added metadata
  * use this command to extract the files from .rpm via the cpio format
  
  * RPM database /var/lib/rpm --  `rpm --rebuilddb`
  * , , , -U (upgrades), -e (erase), -Va (verify)
  
  * exclude packages in /etc/yum.conf  Example: `exclude=xorg-x11* gnome* `  under [main] section

<a href='https://linuxacademy.com/cp/livelabs/view/id/238'>Repositories and the Apt Tools - Linux Academy Lab</a>

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
    * `cat /etc/system-release`  links to centos release

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

* history
  * -c to clear, -r to reread and -w to (over)write~/.bash_history
  * `![cmd#]` runs the command the the specified number
  * ~/.bash_history
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

### 103.2 Process text streams using filters
* Description: Candidates should be able to apply filters to text streams.
* Key Knowledge Areas:
  * Send text files and output streams through text utility filters to modify the output using standard UNIX commands found in the GNU textutils package.
* The following is a partial list of the used files, terms and utilities:
  * bzcat
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
  * zcat


## Text files and manipulation
```
stdin - file descriptor 0 - operator < 
stdout - file descriptor 1 - operator >
stderr - file descriptor 2 - operator >
```
* stdin, stdout, stderr
  * file handles stdin:0, stdour:1, stderr:2
  * `[scriptwerror.sh] 2> error.log`  redirect file handle 2 (errors) to the error log
  * 2>&1 combines stdout and stderr redirected to whatever
  * pipe to `tee` command to split streams to text and file
* xargs converts stdin to arguments for a command
  * `find test/ -empty | xargs rm -f`
  * runs against all files at once, the exec option goes one at a time

* head/tail - first or last lines of a file
  * `sudo tail -f /var/log/secure`  follows the log file (shows entries as they are added)
* nl - number lines of files (-b a) to include blank lines
  * `nl [file]` adds line numbers to the output
* wc - print newline, word, and byte counts for each file (-w just words, -l lines, -c bytes)
* `od -c -a` - dump files in octal and other formats
* sort - sort lines of text files
  * -n sort first columns as a number
  * sort -t "," -k2 (sort on second comma delim column)
  * `sort -u [file]` sort and unique
  * `sort wordlist | nl | head -5` top five (sorted) words in a file, with line numbers
  * -k, --key=KEYDEF sort via a key
  * `sort [file] -k 2`  soft on the second 'field'
* uniq - report or omit repeated lines  (--group)
* tr - translate (replace) or delete characters
  * `cat [file] | tr ',' ':'`
  * `cat [file] | tr -d ','`  (delete the commas)
  * `cat [file] | tr 'A-Z 'a-z'` ToLower
  * `tr -d '\r' < dosfile > unixfile` create unix file from dos file replace CR/LF with LF
* sed - stream editor
  * `sed 's/[findstr]/[replstr]/Ig' [filename]`
    * g = global, multiple replace
    * I = case insensitive
    * -i modifies the file
* split - split a file into pieces
  * splits a file, 1,000 characters per file
  * -b 100, split to 100 byte files
  * -d --verbose -n2, 2 files with numeric naming
* strip - Discard symbols from object files
* cut - remove sections from each line of files
  * `cut -d',' -f 3 [file]` extract the 3rd column, comma delim
  * ` ps -A | tac | head -5 | cut -b 1-5`
    * -b, --bytes=LIST select only these bytes
* awk - pattern scanning and processing language
* paste - merge lines of files
  * `paste [file1] [file2]`  merges two files ( line1 + line1, line2 + line2)  -d overrides the \t delim (-s files in series rather than paralell)
* tac - concatenate and print files in reverse
* xargs - build and execute command lines from standard input
* tee - read from standard input and write to standard output and files

Text Files
* vi/vim 
  * insert to replace mode:  First hit ESC key, then the shift + R keys.
  * All delete commands begin with a 'd', and the 'e' refers to a word under the cursor that is to be deleted, without deleting the space after the word
  * Given that you are already in insert mode, which steps would you take to enter into replace mode? First hit ESC key, then the shift + R keys.

* Message Digest (Hash)
  * md5sum (-c check)
  * sha256sum
  * sha512sum

```
[vagrant@localhost ~]$ sha256sum code.sh
bc0bdaef8a34d56e433400242005c945fe63db6025a35927186018cac5653f5a  code.sh
[vagrant@localhost ~]$ sha256sum code.sh > code.sha256
[vagrant@localhost ~]$ sha256sum -c code.sha256
code.sh: OK
```




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
* shopt  (show options?)
  * `shopt -s [optname]` set/enable an option

* Quotes
  * double are weak and single are strong  (weak still expands a variable)

* Scripting
  * Study notes are being placed directly in Comparitive-Scripting repo


## Disks and File Systems
* LVM - Logical Volume Management
  * use for any volume except for boot, resize, snapshot
  * `pvs`  - Display information about physical volumes
 vagrant boxes are using LVM??
  * `vgs` - Display information about volume groups
  * `lvs` - Display information about logical volumes
  * `pvcreate` - Initialize physical volume(s) for use by LVM
  * `vgextend` - Add physical volumes to a volume group
  * `lvextend` - Add space to a logical volume
* partition IDs
  * 83 - std Linux  (same as ext2??)
  * 82 - Linux Swap
  * 8e - LVM
* parted - Modern command to create MBR or GPT partitions
* mkswap, swapon, swapoff
* Linux File Systems
  * Non-Journaling
    * ext2  second extended fs
  * Journaling
    * ext3
    * ext4
    * XFS
  * Btrfs - still in development
    * Cow Copy on Write
    * Subvolumes
    * Snapshots
  * FAT FS
    * VFAT - allows for long file names
    * EFI boot partitions need to use FAT
  * exFAT (extended)
    * allows for files larger then 2GB
  * `mkfs -t ext4`
  * `mkfs.ext4 -L label /dev/sda1`
  * `lsblk -f` to see file systems
* Disk Utilization
  * `df -h /` - disk free
  * `du -sh /tmp --max-depth=2`
* File System Maintenance
  * fsck, e2fsck, mke2fs, tune2fs
  * /etc.mke2fs.conf
  * xfs_repair, xfs_fsr, xfs_db
* Mounted and mounting file systems
  * /etc/mtab, /etc/mtab -> /proc/mounts
* Logical partions have numbers greater than 4?
* Quotas
  * configure quota for a user `edquota [username]`
  * for a group `edquota -g [groupname]`

* Links 
  * A hard link does not become disconnected from the underlying file if the file is moved.
* Symbolic Links
  * These are really just shortcuts
  * `ln -s Documents/my-file.txt my-file.txt.lnk`
  * `unlink my-file.txt.lnk`







## Users, Groups and File Permissions
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

## Users and Groups
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



## Processes and Monitoring
* `ps`
  * `ps -u <username>`
  * -e  every process, -H hierarchy, -f full format
  * comes from the /proc directory
  * inside top, press k then pid of process to kill
  * `ps -e | grep bash | cut -b 1-6` returns just the pid of bash
* Monitoring
  * `uptime` includes load average
  * `free -m` shows memory utilization in mb
  * `pgrep -a httpd`  all details for httpd processes. -u username
  * read man 7 signal
    * 1: SIGHUP
    * 9: SIGKILL  kill is ungraceful stop
    * 15: SIGTERM  graceful  - kill with no options is sigterm
  * `pkill httpd` kills all httpd processes
  * `killall httpd`  (-s 9)
  * `watch` runs the same command every 2 sec  (-n 5 for 5 sec)
  * `screen` run a shell from which you can disconnect
    * `ctrl+a d` to detach
    * `screen -r [scrid]` to reattach
    * `screen -ls` to list running sessions
    * `exit` (while attached)
  * `tmux` to open a new shell
    * `ctrl+b d` to dettach 
    * `tmux ls`
    * `tmux attach-session -t [numsession]`
    * `exit`
  * `nohup ping www.google.com &`  sends the command to the background
    * `jobs` to see these background processes
    * writes to nohup.out file which can be "tailed"
    * `fg [num]` to bring back to foreground
    * Ctrl+z to send to background (stops job)
    * `bg %1` background
    * kill pid to stop the job
  * Process priority (nice levels)
    * -20 highest, 0 default, 19 lowest
    * `ps -o pid,nice,cmd,user`
    * `nice -n 5 [cmd]`  runs the cmd with a nice level 5 (lower pri)
    * `sudo renice -n -1 [pid]` change nice level to -1
    * niceness values range from -20 to 19, with the former being most favorable, while latter being least
    * A value of -20 represents the highest priority level, whereas 19 represents the lowest. (A 19 is "nicer" than -20)
  * top
    * u key and enter username, r pid enter new level to renice
    * run top as root to lower the nice level (higher priority)

## Scheduling jobs
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



## Searching the file system
* bash: `find /etc -type f -exec grep -l 'coateds' {} \;`
* bash: `grep -rl coateds /etc`
* Use `find` to locate a file or pattern of files ex: `find ./ -name la.txt`
* find
  * `find . -name [name]` recursive by name
  * searches file system live
  * `find . -ctime 1` files changed last 1 day  (-atime accessed)
  * -newer [than a file]
  * -empty -type f (empty files)
  * `find . -empty -type f -exec rm -f {} \;`  remove empty files
  * `find ~ -name "*.tar.*" -exec cp -v {} /dest/folder \;`

## Compression and tar
* compressed files: zcat, bzczt, xzcat to view
  * `dd` copy, convert and backup files
    * `sudo dd if=boot.img of=/dev/sdc` create bootable usb
    * `sudo dd if=/dev/xvda of=/tmpmbr.img bs=512 count=1`  backup of master boot record
    * `dd if=/dev/urandom of=file bs=1024k count=10` make a file of 10 mb
    * ls -h (human readable)
  * `tar -c (create), -f (filename) [target file] [source]`
  * -t list contents, -x extract, -z gzip compression -v verbose
  * `tar -czf file.tgz/.tar.gz source
  * -cjf (create bz2 file)
  * -xzf or -xjf to extract
  * gzip/gunzip/bzip2/bunzip2/xz/unxz

## Regular Expressions
* `grep g.m [file]`  1st chr g, 2nd anything, 3rd m
* `grep ^rpc /etc/passwd` line starts with rpc
* `grep bash$ /etc/passwd` line ends with bash
* `grep [v] /etc/passwd` line with a 'v'
* -i case insensitive
* `grep ^[Aa].[Aa][^h] /etc/passwd` 1st and 3rd chr is a or A, no h 4th
* `cat passwd | sed -n '/nologin$/p'` lines end in nologin
* `cat passwd | sed '/nologin$/d'` delete nologin lines
* `egrep 'bash$' passwd` lines that end in bash, -c for count
* `egrep '^rpc|nologin$' passwd` starts with rpd OR ends with nologin
* fgrep uses a file of patterns to match

## Grep notes
* ^goober  ---  all lines that begin with 'goober'
* goober$ lines that end with 'goober'
* [] match any of the characters in the brackets
* ^[] match lines that start with a character in the brackets
* [a-j] all characters between a and j
* -c  ---  count

## Grub

### Ubuntu 18.04 vagrant install
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

### Ubuntu 12.04 vagrant install
* ubuntu/precise64 - /etc/default/grub
  * #GRUB_HIDEN_TIMEOUT=0
  * #GRUB_HIDEN_TIMEOUT_QUIET=0
* /boot/grub/menu.lst??  --  This does not modify the boot menu??
* v12.04 seems to be in a weird no man's land zone: grub v1.99
* Menu comes from /boot/grub/grub.cfg




### Change display resolution Ubuntu 16.04 on HyperV
* sudo vim /etc/default/grub
* GRUB_CMDLINE_LINUX_DEFAULT="quiet splash video=hyperv_fb:1920x1080"  (1680x1050,1600x900)
  * Experiment 1: match screen resolution (1920x1080)
* sudo update-grub
* sudo reboot now

## Gui etc
* GTK+
  * Gnome
  * XFCE
Qt Based
  * KDE
* Alt+F2 is like a 'run' text box



Remote access.  Currently, it is possilbe to ssh from Ubuntu box:  172.28.128.4 to CentOS box:  172.28.128.5

### Set up CentOS for (Tiger) VNC Server

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

### Ubuntu client
sudo apt install vinagre
Run vinagre from Activities
Connect, VNC
Host: 172.28.128.5:5901
Connect button then password

