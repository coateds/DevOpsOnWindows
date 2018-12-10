# LPIC 1 Exam Notes

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
      * umask??
    * /etc/profile.d/*
    * ~/.bash_profile (some systems will be ~/.profile)
    * ~/.bashrc
    * /etc/bashrc
  * Interactive via SSH
  * Interactive Non-Login Shell (terminal application like GNOME terminal)
    * ~/.bashrc
    * /etc/bashrc
* `echo $0` to see which environment the shell is in:
  * -bash indicates a login shell
  * bash (no dash, non-login shell)