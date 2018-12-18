# LPIC 1 Exam Notes

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
* yum
* `yum search http`  
* `yum info httpd`  
* `sudo yum install httpd`  
* `yum list installed`  
* `yum list installed open*`  
* `yum deplist httpd` (dependency list)  
* `yum remove httpd`  
* `sudo yum autoremove httpd`  
* `yum repolist`  
* `cd /etc/yum.repos.d`  
* `yum clean all`  
* `yum update`  
* 
* `rpm -ivh [pkg.rpm]`  (i) install, (v) verbose, (h) progress bar

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
  * `yum grouplist`
  * RPM database /var/lib/rpm --  `rpm --rebuilddb`
  * rpm -qpi (info), -qpl (list files), rpm -qa (list installed pkgs), -U (upgrades), -e (erase), -Va (verify)
  * rpm2cpio some.rpm | cpio -idmv convert to archive file  ---  Extraction tool
  * exclude packages in /etc/yum.conf  Example: `exclude=xorg-x11* gnome* `  under [main] section