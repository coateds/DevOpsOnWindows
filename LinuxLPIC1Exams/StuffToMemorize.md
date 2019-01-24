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

* Main File System Locations
  * / root
  * /var - (variable) dynamic content, log files, websites
    * Should be on separate partition
  * /home
  * /boot - kernal and supporting files
  * /opt - (optional) third party, Enterprise environments
  * /usr
    * local/sbin
  * /swap (older 1.x to 2.0x of RAM, newer no less than 50% of RAM)
  * /etc - system control files
  * /dev quasi-psuedo
  * /sys
  * /proc
  

* FS perms
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
    * used on a file, an application can run as the group assigned to the app
    * used on a directlry files inherit the group of the directory, useful for collaboration
    * users will get file Group’s permissions when executing a Folder/file/program/command. 
    * SGID is similar to SUID. The difference between both is that SUID assumes owner of the file permissions and SGID assumes group’s permissions when executing a file instead of logged in user inherit permissions. Also most file systems are mounted with the nosuid option
    * set sgid on a dir has another use
      * files created in a dir with the sgid bit set will inherit the group that is assigned to the dir
    * `chmod 2xxx -R /path/to/dir` will change existing file permissions recursively, but will not change the group
    * Therefore a chgrp -R would be necessary on existing files
  * sticky bit - t in place of x in last column `chmod 1xxx file`
    * `chmod o+t /opt/dump/` or `chmod +t /opt/dump/`
    * only owner of a file can remove a file even if others or group has w access
    * chmod o+t /opt/dump/
    * -rw-rw-r-t/T
    * https://www.linuxnix.com/sticky-bit-set-linux/
    * After setting Sticky Bit to a file/folder, if you see ‘T’ in the file permission area that indicates the file/folder does not have executable permissions for all users on that particular file/folder.
    * The sticky bit is already set on the /tmp dir
  * umask - value to subtact from default permissions, 666 for files and 777 for directories
    * root has a umask of 0022
    * users typically has a mask of 0002
    * /etc/bashrc for the system
    * /etc/[user]/.bashrc (on CentOS, not sure where for Ubuntu)
    * set symbolically, `umask u=rwx,g=,o=`


* Runlevel | Purpose
  * 0 | Halt  (poweroff.target)
  * 1 | Single user mode  (rescue.target)
  * 2 | Multi-user mode (no networking)
  * 3 | Multi-user mode (with networking)  (multi-user.target)
  * 4 | unused
  * 5 | Multi-user, w/net and GUI  (graphical.target)
  * 6 | reboot  (reboot.target)
  * basic.target - used during boot process before another target
  * sysinit.target - system initialization
