# Introduction
One task of DevOps is to provide development environments to developers on demand. Building these environments should be quick and automated so if an environment gets trashed, it can be replaced quickly and easily. There is also an interest in using Open Source tools for these environments. This puts a lot of Linux in the DevOps space. What is a Windows geek to do?

I recently set out to learn Python. While it is increasingly my goal to do as many things in a cross platform way as possible. I decided to create a Linux (CentOS) VM in my Windows 10 laptop and use automation to deploy and configure it. This walk through will provide instructions for reproducing this adventure.

# The host software installs
* Chocolatey
* Git
* VSCode
* VirtualBox
* Vagrant

This process is largely about using Vagrant on VirtualBox. I have become increasingly dependent on using VisualStudio code as my workspace. I can document, write scripts, manage files and folders, and even run shells all in one window. It seems to run equally well in Linux (if a GUI is installed) and works nearly identically.

# Basic Vagrant
Start by building a folder to hold your Vagrant Boxes. I like to then open that folder in VSCode and open a terminal in the VSCode environment. From here, you can be logged on to a functioning Linux box in 5 steps:
1. Create a folder in your VagrantBoxes folder
2. cd to that folder in your terminal. PowerShell works just fine for this.
3. `vagrant init [box name]` 'box name' can equal 'hashicorp/precise64' (for ubuntu) or 'bento/centos-7.4' (for centos). There are a lot of possible "boxes" that will work here, but that is a much bigger subject.
4. `vagrant up`
5. `vagrant ssh`

That's it!!  You will now be logged on to a simple linux box as user 'vagrant'. The user has sudo/su rights without a password. Enter `sudo yum -y install git` to get started configuring the box for dev!

When you are done with this VM, type `exit` at the terminal to drop out of the VM to the hose and then `vagrant destroy` will delete it.