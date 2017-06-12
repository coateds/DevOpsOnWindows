# Using Linux
In practical terms, this will be my notes about using Ubuntu Server and Desktop on HyperV

## Desktop
Having worked through (most of at this time) the Linux Academy lesson on Ubuntu Desktop, I have decided to just work with the Unity GUI for now. (Default and possibly lightest weight)

## Installation
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

## Software to install
* rdesktop - Installed
* Git - Installed
* VSCode - Installed
* gksudo - sudo apt-get install gksu
* Samba
* Curl - sudo apt-get install curl
* VIM
* PowerShell

VSCode Install process
* sudo add-apt-repository ppa:ubuntu-desktop/ubuntu-make
* sudo apt-get update
* sudo apt-get install ubuntu-make
* umake web visual-studio-code
* This worked well and installed the latest (1.13) version!!
* umake web visual-studio-code --remove  (If needed)

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

## Remote Desktop
* rdesktop -g 1024x768 BELR901HC8V
    * failed to connect, CredSSP required by server
    * This appears to be due to trying to connect to a domain joined machine/server. 

```diff
- Make this a project
```

# Detritus
## Attempt to install KDE4
using sddm over lightdm

Alt+Ctrl+F3 to get a console

sudo apt-get update
sudo apt-get dist-upgrade -f
sudo dpkg --configure -a