# Using Linux
In practical terms, this will be my notes about using Ubuntu Server and Desktop on HyperV

## Desktop
Having worked through (most of at this time) the Linux Academy lesson on Ubuntu Desktop, I have decided to just work with the Unity GUI for now. (Default and possibly lighteset weight)

## Software to install
VIM
PowerShell
VSCode

## Virtual Terminals
Alt+Ctrl+F1..F7 (or more)
Switches between Virtual Terminals
So Alt+Ctrl+F1 will switch to VT1 and allow logon to a text based terminal
VT7 (Alt+Ctrl+F7) is often, but not always the GUI

# Repositories
Software & Updates is a GUI for:
/etc/apt/sources.list

sudo add-apt-repository ppa:webupd8team/java

# Detritus
## Attempt to install KDE4
using sddm over lightdm

Alt+Ctrl+F3 to get a console

sudo apt-get update
sudo apt-get dist-upgrade -f
sudo dpkg --configure -a