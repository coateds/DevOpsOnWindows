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


## Commands
* sudo shutdown now
* sudo reboot now

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

Powershell grep equiv
* `get-content README.md | select-string -Pattern ^https -casesensitive`
* powershell: `get-childitem -path /etc [-include *.*] -recurse | Select-String -pattern "coateds"`
* With aliasing: `gci /etc -r | sls "coateds"`

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

# Other new info
Use Alt+F2 to get a 'run' command box

# Detritus
## Attempt to install KDE4
using sddm over lightdm

Alt+Ctrl+F3 to get a console

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

Random bits from online tests:  
* Netatalk is file sharing software
* Interpreted prog lang tends to offer more features than compiled
* BSD v GPLv2 - BSD has no copyleft provision
* Open Source Initiative: Eric Raymond and Bruce Perens
* LGPL allows linking to nonGPLed software
* graphical mode access shell with terminal and xterm
* firewall components iptables and gufw
* The onion router for anonymizing Internet browsing

* study the test command
* study man pages
* print cpu info:  arch, lscpu, cat /proc/cpuinfo
* displays information from SMBIOS:  dmidecode
* Swap is sometimes called virtual RAM
* file contains the information passed to the kernel at boot time  --  /proc/cmdline 
* To make changes permanent for kernel parameter files found under /proc/sys, the following file can have entries added to it: /etc/sysctl.conf 
* netstat -r  --  routing table



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


