# Introduction
One task of DevOps is to provide development environments to developers on demand. Building these environments should be quick and automated so if an environment gets trashed, it can be replaced quickly and easily. There is also an interest in using Open Source tools for these environments. This puts a lot of Linux in the DevOps space. What is a Windows geek to do?

I recently set out to learn Python. While it is increasingly my goal to do as many things in a cross platform way as possible. I decided to create a Linux (CentOS) VM in my Windows 10 laptop and use automation to deploy and configure it. This walk through will provide instructions for reproducing this adventure.

# The host software installs
* Chocolatey
* Git
* VSCode
* VirtualBox - HyperV and other hypervisors need to be at least shutdown, if not removed.
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

When you are done with this VM, type `exit` at the terminal to drop out of the VM to the host and then `vagrant destroy` will delete it.

At this point, take notice of the VirtualBox Manager GUI on the Windows machine. Find this in your start menu and open it. Now watch this as you `vagrant up` and `vagrant destroy` your box. Vagrant is running as a front end for Virtual Box! As long as you are working in terminal mode on your linux boxes, you can largely igonre the VBox GUI. I wanted to install a GUI so I could work in VSCode, so I will return to this.

Next take a look at the Vagrantfile in the working folder. It was created by the `vagrant init` command. This file is in Ruby code and once all the commented lines are removed, it boils down to just 3 lines:

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "bento/centos-7.4" 
  # or "hashicorp/precise64" if you are doing ubuntu
end
```

# Provision for python at the command line
Once a box is up, it is possible for Vargrant to provision (further configure) it. There are a couple of provisioners. 

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~  bash:  (or something like that)  ~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

chef:
Add this to your Vagrantfile
```ruby
  config.vm.provision "chef_solo" do |chef|
    chef.add_recipe "python"
  end
```
Add this file structure starting at the root of the working directory:
```
└───cookbooks
    └───python
        └───recipes
```
Note: python = python in the Vfile and dir structure. the names are arbitrary, but must match. Then in the recipes folder there is a default.rb. The following version of the file will install python for use at the linux console.
```ruby
execute "yum -y install http://opensource.wandisco.com/centos/7/git/x86_64/wandisco-git-release-7-2.noarch.rpm"
package "git"

execute "yum -y install yum-utils"
execute "yum -y groupinstall development"
execute "yum -y install https://centos7.iuscommunity.org/ius-release.rpm"

package "python36u"

package "python36u-pip"
package "python36u-devel"

package "vim-enhanced"

# New
package "kernel-devel"
```

`vagrant halt`

Add to the Vagrantfile
```ruby
  config.vm.provider "virtualbox" do |vb|
    vb.gui = true  # brings up the vm in gui window
    vb.memory = 2048
    vb.cpus = 2
  end
```
* In the VBoxManager GUI
* Add a CD ROM
* Increase display memory to 64 MB. (Or 128 if this proves inadequate)

`vagrant up`

Install VBoxGuestAdditions from the console
* The goals here are
  * seamless integration of the mouse pointer
  * increased screen resolution 
  * shared clipboard
* Do not try this from the GUI
* `yum install kernel-devel` is a prerequisite. (moved to chef provisioning script)
* Must install VirtualBox Guest additions specific to host version of VirtualBox
* `vboxmanage --version`  = 5.2.12r122591
* Therefore, downloading VBoxGuestAdditions_5.2.12.iso from http://download.virtualbox.org/virtualbox/5.2.12/ to my downloads on laptop (host)
* Make a place to mount the iso and then mount it.
  * `mkdir /mnt/VBoxLinuxAdditions`
  * `mount /dev/cdrom /mnt/VBoxLinuxAdditions`
* Run the install script - `sh /mnt/VBoxLinuxAdditions/VBoxLinuxAdditions.run`
* restart the guest
* Source:  https://www.megajason.com/2017/06/10/install-virtualbox-guest-additions-on-centos-7/

Customize the VBox GUI
* Set the screen resolution. Tray icons. (If set to highest and maximize the window, it seems to adjust itself just fine)
* Shared Folders do not work in this mode??
* From devices menu, turn on shared clipboard bidirectional (this works well!)
* Other customizations??

Install VSCode
* sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
* sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
* yum check-update
* sudo yum install code -y
* After a restart, the Applications menu of Gnome will get a Programming folder in which a 'Visual Studio Code' icon will be placed.

Set display resolution to 1920 X 1200

# Coming back to this after several months
I have a new goal to build a Python 2.7 box with GUI. It seems a good time to review and consolidate the knowledge collected here

Build process
* Create a folder:  "python-27-gui" in ~\Documents\VagrantBoxes
* Create and start building Vagrantfile (`vagrant up` can be run at any time after a minimal Vagrantfile exists)
* Create and start building the chef recipe: python-27-gui\cookbooks\python-27-gui\recipes\default.rb
* `vagrant provision` to start using Chef solo as a provisioner
  * keep using the provision command as recipe is developed
  * `vagrant relaod` will reboot the vm, but no run chef
  * chef solo is idempotent from here
  