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

## To Be Sorted
* `ls -ld` to see a long listing on one dir
* `declare` - Declare variables and give them attributes.

## Disks and File Systems
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

* Main File System Locations
  * / root
  * /var - (variable) dynamic content, log files, websites
    * Should be on separate partition
  * /home
  * /boot - kernal and supporting files
  * /opt - (optional) third party, Enterprise environments
  * /swap (older 1.x to 2.0x of RAM, newer no less than 50% of RAM)
  * /dev quasi-psuedo
  * /sys
  * /proc
  * Partitions /dev/sd[a,b,c][1,2,3]  (sda1 is first partition of first drive)
  * `mount`
  * `lsblk`
  * `sudo fdisk -l /dev/sda`
  * `swapon -summary`
* Pseudo File Systems
  * /proc  --  processes, can view things as txt files like the cmdline to start the process
  * /sys  --  devices etc
  * sysfs is a pseudo file system

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
  * /usr/share/doc - location for more docs for apps
* var

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

## Text files and manipulation
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

* stdin, stdout, stderr
  * file handles stdin:0, stdour:1, stderr:2
  * `[scriptwerror.sh] 2> error.log`  redirect file handle 2 (errors) to the error log
  * 2>&1 combines stdout and stderr redirected to whatever
  * pipe to `tee` command to split streams to text and file
* xargs converts stdin to arguments for a command
  * `find test/ -empty | xargs rm -f`
  * runs against all files at once, the exec option goes one at a time

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

## Systemd
see https://www.digitalocean.com/community/tutorials/how-to-use-systemctl-to-manage-systemd-services-and-units for a better organized overview?

### Service Management
* `systemctl start/stop/restart/reload/kill/status/enable/disable/mask/unmask [unitname]`
* `sudo systemctl stop/start cups(.service)` The .service is optional
* `enable` sym link from svc file in /lib/systemd/system or /etc/systemd/system
* `systemctl status cups`
* `systemctl is-active/is-failed/is-enabled cups` will show active/inactive

### System State Overview
* `systemctl list-units`
* `systemctl list-units --all | grep cups.service`  will show running/dead
* `systemctl list-units --state=enabled,running --type=service`
  * This shows more columns than the list-unit-files below

The list-units command only displays units that systemd has attempted to parse and load into memory. Since systemd will only read units that it thinks it needs, this will not necessarily include all of the available units on the system. To see every available unit file within the systemd paths, including those that systemd has not attempted to load, you can use the list-unit-files command instead:

* `systemctl list-unit-files --state=enabled,running --type=service`
* lists file and state:  The state enabled, disabled, static (does not contain an install section), masked (mark a unit as completely unstartable), generated, transient, indirect, enabled-runtime

### Unit Management
* `systemctl cat [something.unit]`
* `systemctl list-dependencies cups.service`  --reverse, --before, --after
* `systemctl show cups.service`
* `systemctl show cups.service -p Conflicts` Conflists property
* `sudo systemctl edit cups.service --full`
  * the changed file will be written to /etc/systemd/system
  * To remove any additions, delete the unit's .d configuration directory or the modified service file from /etc/systemd/system. 
  * `sudo rm -r /etc/systemd/system/nginx.service.d`
  * `sudo rm /etc/systemd/system/nginx.service`

### Adjusting the System State (Runlevel) with Targets
  * `systemctl get-default` shows current runlevel/target
  * `sudo systemctl set-default graphical.target`
  * `systemctl list-unit-files --type=target`  all targets
  * `systemctl list-units --type=target`  active targets
  * `sudo systemctl isolate multi-user.target` changes the target immediately if possible
  * `sudo systemctl rescue/halt/poweroff/reboot` These are shortcuts, often with added functionality

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


/etc/systemd/system is for user-defined unit files
  modify here as these will take precedence over the /usr/lib files
/usr/lib/systemd/system is for unit files from user-installed software


Somehow, placing the files in /etc/systemd/system fixed the issue with the timer???

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

## BASH, Shells and Shell Scripting
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
* shopt  (show options?)
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
  * Software & Updates is a GUI for: /etc/apt/sources.list
  * Other repositories are listed in (dir) /etc/apt/sources.list.d

Get updates to packages
* sudo apt-get upgrade
* sudo apt-get dist-upgrade (smart version of above, might remove packages)

Uninstall
* sudo apt-get remove [pkg]
* sudo apt-get purge [pkg]  (removes conf files)

View installed packages
* apt list --installed
* apt list --installed | grep [package]

<a href='https://linuxacademy.com/cp/livelabs/view/id/238'>Repositories and the Apt Tools - Linux Academy Lab</a>


## Version info
`uname`  --  kernel info
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

OS Version
* Ubuntu  --  `lsb_release -a`
* CentOS  --  `cat /etc/centos-release`

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
* Your GRUB2 install has become corrupt; what might you do in order to resolve the issue? (Choose Two) 
  * Reinstall the GRUB bootloader grub-install /device 
  * Recreate the grub.cfg configuration file grub-mkconfig > /boot/grub/grub.cfg 


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

