# Using Linux
In practical terms, this will be my notes about using Ubuntu Server and Desktop on HyperV

## Desktop
Having worked through (most of at this time) the Linux Academy lesson on Ubuntu Desktop, I have decided to just work with the Unity GUI for now. (Default and possibly lightest weight)

## Installation
* VM: 4096GB + 2 vProc
* Going to try Gen 2 --  Secure Boot has to be disabled
* Boot to ubuntu-16.04.2-desktop-amd64.iso
* Install Ubuntu
* Add Option: Download updates
* Installation type depends on state of disk "Erase disk and install..." when installing over
* Time Zone
* English US keyboard
* Name, computername=ubuntu1, User=coateds, pw
* Require pw to log in
* Reboot (on HyperV, shutdown and restart to dismount CD/DVD)
* Logon to Unity desktop

## Stuff to do after install
* Search for Terminal and drag to start bar
* Settings, Appearance, Behavior, Enable workspaces

## Clipboard does not work - Use Samba
* Allow Connection from Putty - copy paste through Putty
  * sudo apt-get install ssh
  * sudo ufw allow 22

## Change display resolution Ubuntu 16.04 on HyperV
* sudo vim /etc/default/grub
* GRUB_CMDLINE_LINUX_DEFAULT="quiet splash video=hyperv_fb:1920x1080"  (1680x1050,1600x900)
  * Experiment 1: match screen resolution (1920x1080)
* sudo update-grub
* sudo reboot now

## Networks
* View
  * `ip addr show` or `ifconfig`
  * `ip route show`
  * `cat /etc/resolv.conf`
  * `host [domain name]` or `nslookup`
  * `cat /etc/hosts`

* /etc/network/interfaces default
```
auto lo
iface lo inet loopback
```
* Statically Addressed Server
```
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
auto eth0
iface eth0 inet static
	address 192.168.0.106
	netmask 255.255.255.0
	network 192.168.0.0
	gateway 192.168.0.106
	broadcast 192.168.0.255
	# dns-* options are implemented by the resolvconf package, if installed
	dns-nameservers 192.168.0.110
	dns-search coatelab.com
```
* Change 'static' to 'dhcp' and comment subsequent lines to convert
* re-read interfaces file w/o reboot
```
Sudo ifdown eth0
Sudo ifup eth0
```

## Disk commands
* list hard disks and file systems `lsblk`
* To get available disk spack `df -h`

## Process commands
* no switches (launched/running in current shell)
* `ps -eH` (Everything with Hierarchy)
* `ps -u [username]` (all for a user)
* -f switch to see switches used to launch and path to executable
* kill a process from top
  * press k
  * enter the pid
  * press enter x2

## Logs
* /var/log
* boot.log
* messages
* secure
* kernel ring buffer (in memory, read with dmesg)

## Users
* `who` or `w` to see the logged on users
* `id [username]` details of logged on user
* wheel group (can run sudo) /etc/sudoers
* `cat /etc/passwd`
* dcoate is NOT in /etc/passwd
* `cat /etc/group`
* system users (run daemons, id usually less than 1000?)
* `groupadd curators` (gid 1001)
* `useradd -G 1001 -m -c "Eva Doe" eva`
* `cat /etc/default/useradd` default settings for useradd
* `ls  -a /etc/skel`
* `passwd eva` change the password for eva
* `cat /etc/shadow` encrypted passwords
* `last` recent logins

## Symbolic Links
* These are really just shortcuts
* `ln -s Documents/my-file.txt my-file.txt.lnk`
* `unlink my-file.txt.lnk`

## Commands
* sudo shutdown now
* sudo reboot now

OS Version
* lsb_release -a

## Software to install
* rdesktop - Installed
* Git - Installed
* VSCode - Installed
* gksudo - sudo apt-get install gksu
* Samba
* Curl - sudo apt-get install curl
* VIM
* PowerShell
* Ruby

VSCode Install process
* sudo add-apt-repository ppa:ubuntu-desktop/ubuntu-make
* sudo apt-get update
* sudo apt-get install ubuntu-make
* sudo umake web visual-studio-code
* This worked well and installed the latest (1.13) version!!
  * /home/[user]/.local/share/umake/web/visual-studio-code/code
  * right click icon on launcher --  Lock to Launcher
  * install code runner extension
* umake web visual-studio-code --remove  (If needed)

VSCode Upgrade process
* sudo apt-get update (optional?)
* umake web visual-studio-code

PowerShell Install process
* (Source https://github.com/PowerShell/PowerShell/blob/master/README.md)
* Import the public repository GPG keys: curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
* Register the Microsoft Ubuntu repository: curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list | sudo tee /etc/apt/sources.list.d/microsoft.list
* sudo apt-get update
* sudo apt-get install -y powershell
* Start PowerShell:  powershell
* shortcut: /usr/bin/powershell  -->  /opt/microsoft/powershell/6.0.0-beta.2

Samba Install and configure process  --  Note: this will set up a wide open share, anyone can write to it. For an isolated lab, this should be fine for sharing files. I am using this process because it is known to me. There may be better ways in the long run.
* sudo apt-get install samba
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

## Virtual Terminals
Alt+Ctrl+F1..F7 (or more)
Switches between Virtual Terminals
So Alt+Ctrl+F1 will switch to VT1 and allow logon to a text based terminal
VT7 (Alt+Ctrl+F7) is often, but not always the GUI

## Repositories
Software & Updates is a GUI for:
/etc/apt/sources.list

sudo add-apt-repository ppa:webupd8team/java

Get updates to packages
* sudo apt-get upgrade
* sudo apt-get dist-upgrade (smart version of above, might remove packages)

Other repositories are listed in (dir) /etc/apt/sources.list.d

Uninstall
* sudo apt-get remove [pkg]
* sudo apt-get purge [pkg]  (removes conf files)

View installed packages
* apt list --installed
* apt list --installed | grep [package]

<a href='https://linuxacademy.com/cp/livelabs/view/id/238'>Repositories and the Apt Tools - Linux Academy Lab</a>

## Remote Desktop
* rdesktop -g 1024x768 BELR901HC8V
    * failed to connect, CredSSP required by server
    * This appears to be due to trying to connect to a domain joined machine/server.

```diff
- Make this a project
Insecure connection made
* Disable Firewall
* Allow remote connections
  * Deslect Allow connections NLA only
```

Command line keyboard shortcuts
* Ctrl+a beginning of the line
* Ctrl+e end of the line
* Ctrl+k clear all after the cursor
* Ctrl+l clear the screen except current line
* Ctrl+u clear all before the cursor
* Ctrl+w delete one word before the cursor
* Ctrl+t swap current char with one before - correct dyslexic typing



Bash logon configuration files
* See  LPIC 1 exam notes

Grep notes
* ^goober  ---  all lines that begin with 'goober'
* goober$ lines that end with 'goober'
* [] match any of the characters in the brackets
* ^[] match lines that start with a character in the brackets
* [a-j] all characters between a and j
* -c  ---  count

Powershell grep equiv
* `get-content README.md | select-string -Pattern ^https -casesensitive`

Searching files for text
* bash: `find /etc -type f -exec grep -l 'coateds' {} \;`
* bash: `grep -rl coateds /etc`
* powershell: `get-childitem -path /etc [-include *.*] -recurse | Select-String -pattern "coateds"`
  * With aliasing: `gci /etc -r | sls "coateds"`
  * This does NOT work: ls /etc -r | sls "coateds"  ---  ls in this case is the actual linux ls command and therefore its output cannot be piped to a PS command

# Linux Scripting
## Setting up the environment for root (Ubuntu)

<a href='https://github.com/coateds/BashScripting'>My Bash Notes</a>


## Edit files in VSCode
* VSCode is opened as coateds
* As root create directory /scripts
* usermod -a -G coateds coateds
* chgrp coateds /scripts
* chmod 770 /scripts
* Create and edit files in VSCode (as coateds)
* Open bash terminal (Ctrl+`) and sudo to root (sudo su -)
* As files are created, chmod u+x [file]

## Bash script basics
* file must start with #!/bin/bash
* chmod u+x [file]

## Cygwin bash on Windows
Just to totally rock the boat, I have been reverse engineering a bash solution on a Windows server. Here are some generic notes...
* Jenkins calls a .cmd file
* cmd /c start /wait /high %CYGWINHOME%\bash.exe -x [bashscriptfile].sh
* The bash script writes to a log in UNIX format as a testable output
* %CYGWINHOME%\unix2dos.exe [logfilename].log to convert to DOS format

## Systemd
* `sudo yum install -y httpd`
* `rpm -ql httpd | grep system` view systemd files in a pkg
* `systemctl status httpd` note the pkg installs disabled by default
* `sudo systemctl enable httpd.service` Note the name from the "loaded" line??
  * Created symlink from /etc/systemd/system/multi-user.target.wants/httpd.service to /usr/lib/systemd/system/httpd.service.
  * now it is enabled, but still dead/inactive
* `sudo systemctl start httpd.service`
* `systemctl help xrdp.service`
* `systemctl -H [host or ip] status xrdp.service` ssh keys must be set up


The bash script:
* starts with #!/usr/bin/bash
* echo "foo" >> [logfilename].log to capture an output

# Somthings to try:
* xrdp  ---  www.xrdp.com
* VSCode, xrdp on kubuntu  ---  http://gunnarpeipman.com/2016/11/vs-code-linux/

## Server

### Sep '17
Using ubuntu-16.04.3-server-amd64.iso

LIS
* sudo apt-get install linux-virtual-lts-xenial linux-tools-virtual-lts-xenial linux-cloud-tools-virtual-lts-xenial
* https://docs.microsoft.com/en-us/windows-server/virtualization/hyper-v/supported-ubuntu-virtual-machines-on-hyper-v

I attempted to make a BaseBox image and start spinning up test kitchen instances on the Server2012R2 box. This was ultimately unsuccessful. Some things I learned and should explore further.
* This might work better with a Gen 1 box
* There is a update to the kitchen hyperv driver  `gem install kitchen-hyperv`
* This might work better on my Win10 box at home

### Older information
Using ubuntu-16.04.1-server-amd64.iso


HyperV Settings
	Gen 2  --  Secure Boot has to be disabled
		Confirmed off
Memory 8192

Gen 2  --  Secure Boot has to be disabled
8192 Memory
C:\Users\Public\Documents\Hyper-V\Virtual hard disks\Server19_Ubuntu.vhdx
D:\HyperVResources\ISO\ubuntu-16.04.1-server-amd64.iso
Disable Secure Boot in Firmware VM property page
Force UEFI
Keyboard layout needs to be just US (no intl)
	(Change XKBVARIANT in /etc/default/keyboard from intl to nothing and reboot)

Better to set up on External net



Going to try to dual home and set up IP forwarding:
http://www.revsys.com/writings/quicktips/nat.html
https://help.ubuntu.com/community/NetworkConfigurationCommandLine/Automatic
https://help.ubuntu.com/community/Router

* To see a list of NICs: ls /sys/class/net


Example of a dual homed Ubuntu Server's /etc/network/interfaces:
```
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
auto eth0
iface eth0 inet dhcp

# The second (internal net) NIC
auto eth1
iface eth1 inet static
address 192.168.0.121
netmask 255.255.255.0
broadcast 192.168.0.255

```

Turn IPForwarding on temporarily
* If IP forwarding on, sysctl net.ipv4.ip_forward will = 1
* To turn it on:
* (sudo su)
* sudo sysctl -w net.ipv4.ip_forward=1


Turn IPForwarding on Perm:
* Edit /etc/sysctl.conf
* uncomment this line: net.ipv4.ip_forward = 1
* sudo sysctl -p /etc/sysctl.conf

Turn on NAT
* sudo iptables --table nat --append POSTROUTING --out-interface eth0 -j MASQUERADE
* sudo iptables --append FORWARD --in-interface eth1 -j ACCEPT
* make a script, nat.sh of these two lines
* sudo cp nat.sh /etc/init.d/
* sudo ln -s /etc/init.d/nat.sh /etc/rc2.d/S95masquradescript

Edit the /etc/rc.local file:
```
#!/bin/sh -e
iptables --table nat --append POSTROUTING --out-interface eth0 -j MASQUERADE
iptables --append FORWARD --in-interface eth1 -j ACCEPT

exit 0
```

Current server (not nat) network config:
```

# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
auto eth0
iface eth0 inet static
address 192.168.0.119
netmask 255.255.255.0
broadcast 192.168.0.255
gateway 192.168.0.121
dns-search expcoatelab.com
dns-nameservers 192.168.0.135

```

# Using CentOS 7 (differences)

## yum
`yum search http`  
`yum info httpd`  
`sudo yum install httpd`  
`yum list installed`  
`yum list installed open*`  
`yum deplist httpd` (dependency list)  
`yum remove httpd`  
`sudo yum autoremove httpd`  
`yum repolist`  
`cd /etc/yum.repos.d`  
`yum clean all`  
`yum update`  

`rpm -ivh [pkg.rpm]`  (i) install, (v) verbose, (h) progress bar

# Other new info
Use Alt+F2 to get a 'run' command box

# Detritus
## Attempt to install KDE4
using sddm over lightdm

Alt+Ctrl+F3 to get a console

sudo apt-get update
sudo apt-get dist-upgrade -f
sudo dpkg --configure -a

make a change from a Linux box

# systemd
* Which command(s) enabled a service to be enabled at boot time on a Red Hat based system?: ntsysv, chkconfig
* Which init runlevel is for single-user mode?: 1
* Which init runlevel is typically used for a graphical desktop?: 5
* What program does the kernel look for to get the system started?: /sbin/init
* Which init runlevel shuts down a system?: 0
* Which init runlevel reboots a system?: 6
* Which of the following is the correct boot order for Linux?: boot disk, kernel, initial RAM disk, init 
* What directory traditionally contained the initialization scripts for services on a Debian-based system?: /etc/init.d 
* Who originally wrote systemd?: Lennart Poettering 

* Which systemd command will list all units on a system, along with their status of active or inactive?: systemctl list-unit-files 
* What command can be used to view the differences between a stock unit file and one that has been modified?: systemd-delta 

* systemctl list-unit-files
* systemctl list-units -t service   --  list all services with their state!!

# Systemd containers
* yum -y install --releasever=7 --installroot=/var/lib/machines/qa install systemd passwd redhat-release vim-minimal yum
* setenforce 0
* systemd-nspawn -D /var/lib/machines/qa
* passwd (root pw)
* mv /etc/securetty /etc/securetty.disable
* systemctl enable systemd-nspawn@qa.service
* machinectl start qa
* machinectl login qa (as root)

# LPI Exams
## Linux Essentials
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
* vi/vim 
  * insert to replace mode:  First hit ESC key, then the shift + R keys.
  * All delete commands begin with a 'd', and the 'e' refers to a word under the cursor that is to be deleted, without deleting the space after the word
* `#!/bin/bash`
* What command will print a list of all running processes on our system
* symbolic link
  * The -s option must be provided to the ln command for symbolic links. 
  * The item to be linked must come before the name of the link itself. 
* Microsoft SQL Server has recently been ported to Linux
* Use `find` to locate a file or pattern of files ex: `find ./ -name la.txt`
* Net utils
  * `ping -c 5 host.example.com`  5 packets
  * Traceroute and tracepath are both used to follow the network path to outside systems. 
  * View default gateway:  route, netstat -r
  * DNS resolution: /etc/hosts, /etc/resolv.conf
* File System
  * directory will you find system-related configuration files /etc?
  * contains filesystem management utilities such as cp or mv  /bin and /usr/bin
* view network configuration - 2 commands
  * ip addr show, ifconfig
* `~/.bash_history`
* tar, bunzip2 (.bz2), gzip (.gz)
* useradd swtches!
* The 'who' and 'w' commands will list currently logged in users 
* two primary Dev models Bazaar and Cathedral Models (Bazaar is less structured)
* CUPS and SAMBA for printing

## Linux+ and LPIC-1: System Administrator Exam 101 
* Pseudo File Systems
  * /proc  --  processes, can view things as txt files like the cmdline to start the process
  * /sys  --  devices etc
  * sysfs is a pseudo file system
* kernal modules
  * lsmod
  * modprobe
* devices
  * udev, /dev
  * lspci
  * lsusb
  * lscpu
  * lsblk
* Boot process
  * GRUB  --  Grand Unified Boot Loader  --  
  * looks for Boot Sector
  * linux Kernal
  * Initial RAM disk
  * Initialization System
* Boot Logs, dmesg and journalctl -k  (systemd)
* Init
  * System V (5)
  * Loads services one at a time
  * /sbin/init
  * /etc/inittab
    * `<id>:<runlevel>:<action>:<process>`
* /etc/rc.d  - Red hat
* /etc/init.d - Debian

#
  Runlevel | Purpose
  |-|-
  0 | Halt
  1 | Single user mode
  2 | Multi-user mode (no networking)
  3 | Multi-user mode (with networking)
  4 | unused
  5 | Multi-user, w/net and GUI
  6 | reboot

`runlevel` to see current runlevel
`telinit 3` to change to runlevel 3

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
#
* Main File System Locations
  * / root
  * /var - (variable) dynamic content, log files, websites
    * Should be on separate partition
  * /home
  * /boot - kernal and supporting files
  * /opt - (optional) third party, Enterprise environments
  * /swap (older 1.x to 2.0x of RAM, newer no less than 50% of RAM)
  * Partitions /dev/sd[a,b,c][1,2,3]  (sda1 is first partition of first drive)
  * `mount`
  * `lsblk`
  * `sudo fdisk -l /dev/sda`
  * `swapon -summary`
* LVM - Logical Volume Manager
  * use for any volume except for boot, resize, snapshot
  * `pvs`  vagrant boxes are using LVM??
  * `vgs`
  * `lvs`
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
* FS perms
  * suid - set user bit, not used much any more `chmod 4xxx file`. `chmod u+s file`
  * sgid = set group bit `chmod -R 2xxx file`, 
    * files inherit the group of the folder, useful for collaboration
  * sticky bit - t in place of x in last column `chmod 1xxx file`
    * only owner of a file can remove a file
  * umask - value to subtact from default permissions, 666 for files and 777 for directories
    * set in the /etc/bashrc file and /home/[user]/.bashrc
    * `umask u=rwx,g=,o=` or `umask 0077`
#
* Grub
  * grub2 install command `grub-install /dev/[disk]`



# 
* Shared Libraries
  * Dynamic .so (shared object) extension or Statically linked .a extension
  * /lib, /usrlib (32 bit), /usr/lib64, /usr/local/lib, /usr/share
  * `ldd` list library dependencies for a program
  * `ldconfig` cached listing of recently used libraries
    * /etc/ld.so.conf
  * LD_LIBRARY_PATH - legacy environment variable
# 
* Debian APT (includes dependencies)
  * /etc/apt/sources.list
  * `apt-get update` updates local cache
  * `apt-get remove/purge`
  * `apt-get dist-upgrade` upgrades to the next release of the distribution
  * `apt-get-download`
  * `apt-cache [search/show/showpkg]`  (local cache)
  * `sudo do-release-upgrade` to upgrade to the latest version of the OS (such as 18.04)
  * dpkg to install .deb files
  * dpkg --info, --status, -l (list), -i (install), -L (list files), -r (remove), -P (purge), -S (search the pkg db), 
  * `dpkg-reconfigure`  --  reruns a pkg's setup?
* RRM Package Manager YUM  (SUSE Linux uses Zypper, Fedora uses DNF)
  * /etc/yum.conf
  * /etc/yum.repos.d
  * /var/cache/yum
  * `yum update`
  * `yum search`
  * `yum info`
  * `yum list installed`
  * `yum clean all`
  * `yum install`
  * `yum remove`
  * `yum autoremove`  (purge)
  * `yum whatprovides`  (what package installs a given file)
  * `yum reinstall`
  * `sudo yum install yum-utils`
  * `yumdownloader [pkg]`
  * RPM database /var/lib/rpm --  `rpm --rebuilddb`
  * rpm -qpi (info), -qpl (list files), rpm -qa (list installed pkgs), -U (upgrades), -e (erase), -Va (verify)
  * rpm2cpio some.rpm | cpio -idmv convert to archive file  ---  Extraction tool
#
* BASH


# 
* Text files
  * `sudo tail -f /var/log/secure`  follows the log file (shows entries as they are added)
  * `nl` num of lines in a file  (-b a) to include blank lines
  * `wc` word count (lines, words, bytes)  (-w just words, -l lines, -c bytes)
  * `od -c -a` octal dump
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
* text manipulation
  * sort (-n sort first colums as a number)
    * sort -t "," -k2 (sort on second comma delim column)
  * uniq (--group)
  * `sort -u [file]` sort and unique
  * tr (translate/replace)
    * `cat [file] | tr ',' ':'`
    * `cat [file] | tr -d ','`  (delete the commas)
    * `cat [file] | tr 'A-Z 'a-z'` ToLower
    * `cut -d',' -f 3 [file]` extract the 3rd column, comma delim
    * `paste [file1] [file2]`  merges two files ( line1 + line1, line2 + line2)  -d overrides the \t delim (-s files in series rather than paralell)
  * sed  (stream editor)
    * `sed 's/[findstr]/[replstr]/Ig' [filename]`
      * g = global, multiple replace
      * I = case insensitive
      * -i modifies the file
  * split
    * splits a file, 1,000 characters per file
    * -b 100, split to 100 byte files
    * -d --verbose -n2, 2 files with numeric naming
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
* find
  * `find . -name [name]` recursive by name
  * searches file system live
  * `find . -ctime 1` files changed last 1 day  (-atime accessed)
  * -newer [than a file]
  * -empty -type f (empty files)
  * `find . -empty -type f -exec rm -f {} \;`  remove empty files
  * `find ~ -name "*.tar.*" -exec cp -v {} /dest/folder \;`
* globbing
  * [abc] match any char in the list
  * [^abc] match any char except those in the list
  * [0-9] matches a range of numbers
# 
Unsorted
* mkdir -p Projects/{ancient,classical,medieval}

#

* stdin, stdout, stderr
  * file handles stdin:0, stdour:1, stderr:2
  * `[scriptwerror.sh] 2> error.log`  redirect file handle 2 (errors) to the error log
  * 2>&1 combines stdout and stderr redirected to whatever
  * pipe to `tee` command to split streams to text and file
* xargs converts stdin to arguments for a command
  * `find test/ -empty | xargs rm -f`
  * runs against all files at once, the exec option goes one at a time

# 

Processes
* `ps`
* `ps -u <username>`
* -e  every process, -H hierarchy, -f full format
* comes from the /proc directory
* inside top, press k then pid of process to kill

Monitoring
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
* top
  * u key and enter username, r pid enter new level to renice
  * run top as root to lower the nice level (higher priority)
  
#

* Regular Expressions
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

#

http://www.gocertify.com/quizzes/linux-practice-questions/linux-lpi101-lx0101-quiz.html

https://itbeginner.net/linux-essentials-exam-answer-test-online-pdf
https://itbeginner.net/linux-essentials-chapter-1-test-online-2016.html

Random bits from online tests:  
* Netatalk is file sharing software
* Interpreted prog lang tends to offer more features than compiled
* BSD v GPLv2 - BSD has no copyleft provision
* Open Source Initiative: Eric Raymond and Bruce Perens
* LGPL allows linking to nonGPLed software
* graphical mode access shell with terminal and xterm
* firewall components iptables and gufw
* The onion router for anonymizing Internet browsing
* vim visual mode (v), yank (y), put (p)
* study the test command
* study man pages
* print cpu info:  arch, lscpu, cat /proc/cpuinfo
* displays information from SMBIOS:  dmidecode
* Swap is sometimes called virtual RAM
* file contains the information passed to the kernel at boot time  --  /proc/cmdline 
* To make changes permanent for kernel parameter files found under /proc/sys, the following file can have entries added to it: /etc/sysctl.conf 
* netstat -r  --  routing table
* Must study useradd. usermod, groupadd, groupmod
* chmod o=rx [file]

# lsblk output from various VMs
Runway CentOS build:
```
NAME           MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
fd0            2:0    1    4K  0 disk 
sda            8:0    0   32G  0 disk 
├─sda1         8:1    0  512M  0 part /boot
└─sda2         8:2    0 31.5G  0 part 
  ├─vg0-root 253:0    0 30.5G  0 lvm  /
  └─vg0-swap 253:1    0    1G  0 lvm  [SWAP]
sr0           11:0    1 1024M  0 rom  
```

CentOS vagrant box Dec '18 on Hyperhost
```
NAME            MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
sda               8:0    0  64G  0 disk 
├─sda1            8:1    0   1G  0 part /boot
└─sda2            8:2    0  63G  0 part 
  ├─centos-root 253:0    0  41G  0 lvm  /
  ├─centos-swap 253:1    0   2G  0 lvm  [SWAP]
  └─centos-home 253:2    0  20G  0 lvm  /home
```

Ubuntu vagrant box
```
NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda      8:0    0   10G  0 disk 
└─sda1   8:1    0   10G  0 part /
sdb      8:16   0   10M  0 disk 
sr0     11:0    1 55.3M  0 rom  
```

File System Hierarchy Std
* bin
* boot
* dev
* etc
* home
* lib
* lib64
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
