# LPIC 1 Exam Notes

## Resources
http://www.gocertify.com/quizzes/linux-practice-questions/linux-lpi101-lx0101-quiz.html

https://itbeginner.net/linux-essentials-exam-answer-test-online-pdf
https://itbeginner.net/linux-essentials-chapter-1-test-online-2016.html


## Help and man pages
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

## BASH, Shells and Shell Scripting
* Logon configuration files
  * ~/.bashrc (read by non-login shells as well as others)
  * /etc/profile (not recommended)
  * /etc/profile.d/[file].sh  ---  All .sh files here are run for every user logon.
  * bash configuration file sequence: read first when a login bash shell is run:  The /etc/profile configuration file is read first in the sequence. The other files are called via the /etc/profile. 
  * Set umask in the /etc/bashrc file and /home/[user]/.bashrc
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
* Environment Variables
  * env  --- view environment variables
  * export MYNAME="Dave"  ---  create and set a variable
  * VARIABLE=/path,command,alias
  * echo $MYNAME
* Set - Displays all bash settings
  * set/unset options
  * `set -x` turn on debugging
  * `unset -f [fn]`  Remove a function
  * `unset FOO` to clear the 'FOO' env variable
* Alias -- `alias ll="ls -lh"`
* `function [name]()  {[commands]}`
* `source .bashrc` file (rereads and merges contents of .bashrc file)
  * . (dot) is an alias to source so `. .bashrc` is the same thing
  * `echo alias 'webstat="systemctl status httpd.service"' >> ~/.bashrc`
* Configure /root/bin for scripts
  * Logon as root with root profile `sudo su -`
  * Create bin dir in root home
  * Create/Edit .bash_profile
```
# .bash_profile

PATH=$PATH:$HOME/bin:/scripts
export PATH
```
* shopt  (show opttions?)
  * `shopt -s [optname]` set/enable an option
* type - is something a fn, file, alias, built-in, or keyword
  * -P will give path like which
* Quotes
  * double are weak and single are strong  (weak still expands a variable)
* history
  * `![cmd#]` runs the command the the specified number
  * ~/.bash_history
  * $HISTFILESIZE
* Scripting
  * Study notes are being placed directly in Comparitive-Scripting repo


## Text Files
* vi/vim 
  * insert to replace mode:  First hit ESC key, then the shift + R keys.
  * All delete commands begin with a 'd', and the 'e' refers to a word under the cursor that is to be deleted, without deleting the space after the word
  * Given that you are already in insert mode, which steps would you take to enter into replace mode? First hit ESC key, then the shift + R keys.

## Package Managers (yum and apt-get)
* RRM Package Manager YUM  (SUSE Linux uses Zypper, Fedora uses DNF)
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
  * `yum update`  
  * `yum whatprovides`  (what package installs a given file)
  * `sudo yum install yum-utils`
  * `yumdownloader [pkg]`
  * `yum grouplist`
  * `rpm -ivh [pkg.rpm]`  (i) install, (v) verbose, (h) progress bar
  * RPM database /var/lib/rpm --  `rpm --rebuilddb`
  * rpm -qpi (info), -qpl (list files), rpm -qa (list installed pkgs), -U (upgrades), -e (erase), -Va (verify)
  * rpm2cpio some.rpm | cpio -idmv convert to archive file  ---  Extraction tool
  * exclude packages in /etc/yum.conf  Example: `exclude=xorg-x11* gnome* `  under [main] section
* Debian APT (includes dependencies)
  * /etc/apt/sources.list
  * `apt-get update` updates local cache
  * `apt-get upgrade`
  * `apt-get remove/purge`
  * `apt-get dist-upgrade` upgrades to the next release of the distribution
  * `apt-get-download`
  * `apt-cache [search/show/showpkg]`  (local cache)
  * `sudo do-release-upgrade` to upgrade to the latest version of the OS (such as 18.04)
  * `apt-key add`
  * `apt list --installed`
  * `apt list --installed | grep [package]`
  * dpkg to install .deb files
  * dpkg --info, --status, -l (list), -i (install), -L (list files), -r (remove), -P (purge), -S (search the pkg db), 
  * `dpkg-reconfigure`  --  reruns a pkg's setup?
  * `add-apt-repository`  (add-apt-repository ppa:webupd8team/java)
  * /etc/apt/sources.list.d

More apt stuff
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


## Version info
`uname`  --  kernel info
-s, --kernel-name: Print the kernel name.
-n, --nodename: Print the network node hostname.
-r, --kernel-release: Print the kernel release.
-v, --kernel-version: Print the kernel version.
-m, --machine: Print the machine hardware name.
-p, --processor: Print the processor type, or "unknown".
-i, --hardware-platform: Print the hardware platform, or "unknown".
-o, --operating-system: Print the operating system.
--help: Display a help message, and exit.
--version: Display version information, and exit.

OS Version
Ubuntu  --  `lsb_release -a`
CentOS  --  `cat /etc/centos-release`

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

 * Target types
    * multi-user.target (like runlevel 3)
    * graphical.target (like runlevel 5)
    * rescue.target (like runlevel 1)
    * basic.target - used during boot process before another target
    * sysinit.target - system initialization

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

### Legacy Grub
* At this time (jan '19) my Ubuntu/Deb Vagrant box uses grub... NO!!
* All of my vagrant boxes seem to use grub 2
  * See  /boot/grub/menu.lst
  * (This might still be grub2, but deb based systems use grub and not grub2 for commands???)
  * There is no /boot/efi so it appears to be just grub
* used with MBR
* Stage 1:  boot.img
* Stage 1.5:  core.img
* Stage 2:  /boot/grub/
  * grub.conf (rh)/menu.lst(deb)
  * device.map
* run grub to get into the grub shell (my systems do not have this)
* `sudo vim /etc/default/grub`, then `update-grub`

* grub2 install command `grub-install /dev/[disk]`

### Grub2
* At this time (jan '19) my CentOS Vagrant box uses grub2
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
  * edit the file /etc/default/grub  (exists for legacy and grub2)
  * grub2-mkconfig modifies /boot/grub2/grub.cfg on CentOS systems
  * `update-grub` to make modifications on Deb Systems

### Change display resolution Ubuntu 16.04 on HyperV
* sudo vim /etc/default/grub
* GRUB_CMDLINE_LINUX_DEFAULT="quiet splash video=hyperv_fb:1920x1080"  (1680x1050,1600x900)
  * Experiment 1: match screen resolution (1920x1080)
* sudo update-grub
* sudo reboot now