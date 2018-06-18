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

Environment Variables
* env  --- view environment variables
* export MYNAME="Dave"  ---  create and set a variable
* echo $MYNAME

Bash logon configuration files
* ~/.bashrd
* /etc/profile (not recommended)
* /etc/profile.d/[file].sh  ---  All .sh files here are run for every user logon.

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

Configure /root/bin for scripts
* Logon as root with root profile `sudo su -`
* Create bin dir in root home
* Create/Edit .bash_profile
```
# .bash_profile

PATH=$PATH:$HOME/bin:/scripts
export PATH
```
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

I attempted to make a BaseBox image and start spinning up test kitchen instances on the Expedia Server2012R2 box. This was ultimately unsuccessful. Some things I learned and should explore further.
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