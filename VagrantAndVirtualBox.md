# Using Vagrant (With Virtual Box)

## Basic create VM
* create a directory to house a vagrant box
* `vagrant init hashicorp/precise64`
* `vagrant up`
* `vagrant reload` will halt and restart a VM and apply config changes

## Learning environment
* C:\Users\dcoate\Documents\VagrantBoxes
  * data (sync'd folder)
  * LinuxAcademy (first project box)

## Shared/Syncd folders
* In vagrant file:  config.vm.synced_folder "../data", "/vagrant_data"
* "../data" folder must exist on host for a `vagrant up` command to work.
* "/vagrant_data" will be created in the guest and files placed there will show up in ../data on the host

## Networking
* In vagrant file: `config.vm.network "forwarded_port", guest: 80, host: 8080`
* Windows defender warning: Allow for Domain networks: vboxheadless.exe

## Provisioning
Multiple ways to install Apache on Ubuntu Precise64 box

### Manually
Install apache
`apt-get install -y apache2`
Delete the default apache content directory
`sudo rm -rf /var/www`
Create a symbolic link from sync folders to apache content directory
`sudo ln -fs /vagrant_data /var/www`
Add/modify content at host: C:\Users\dcoate\Documents\VagrantBoxes\data

### Call a bash shell script from the Vagrantfile
* in the Vagrantfile after port forwarding
* `config.vm.provision "shell", path: "provision.sh"`

Contents of provision.sh
```bash
#!/usr/bin/env bash

echo "installing apache and setting it up... please wait"
apt-get update >/dev/null 2>&1
apt-get install -y apache2
sudo rm -rf /var/www
sudo ln -fs /vagrant_data /var/www
```

Note on a Windows laptop with git bash installed, the vagrant up + call to bash script can be run in git bash OR PowerShell!!

### The Chef (_solo) provisioner
* in the Vagrant file replace the shell provisioner line
```ruby
config.vm.provision "chef_solo" do |chef|
  chef.add_recipe "vagrant_la"
end
```

* Create structure in vagrant folder (LinuxAcademy)
```
C:.
├───.vagrant
│   └───machines
│       └───default
│           └───virtualbox
└───cookbooks
    └───vagrant_la
        └───recipes
```
* Create recipe file default.rb in recipes at the bottom of the tree above
```ruby
execute "apt-get update"
package "apache2"
execute "rm -rf /var/www"
link "/var/www" do 
    to "/vagrant_data"
end
```
* `vagrant up`
  * If chef is not installed, it will install Chef
  * Apparently, the Chef installation is temporary???

# Vagrant Boxes
* `vagrant box add [name] [url]`
* `vagrant box list`
* `vagrant box remove [name] [provider]`
* `vagrant box repackage`

Packaging
* `vagrant package [name]`
* use name only if there is more than one box in the project (directory)
* `vagrant box add [name] package.box` adds the packaged box to the available boxes on the system
* `vagrant box list` to see/confirm the box is available
* `vagrant init [name]` from a new project/directory to initialize a VM from the box
* `vagrant up`   etc....

# CentOS Vagrant images
* http://cloud.centos.org/centos/7/vagrant/x86_64/images/
* Therefore `vagrant init CentOS7 http://cloud.centos.org/centos/7/vagrant/x86_64/images/CentOS-7-x86_64-Vagrant-1805_01.VirtualBox.box`

# Old Information
Location of vmdk file for raw image
C:\Users\dcoate\.vagrant.d\boxes\learningchef-VAGRANTSLASH-centos65\1.0.7\virtualbox

This is where the VMs are being built and stored:
C:\Users\dcoate\VirtualBox VMs

Theory:  Must build an ssh cert for my user on the host before installing V&V

A folder to be aware of:  
C:\Users\dcoate\AppData\Local\chefdk\gem\ruby\2.3.0\gems\kitchen-vagrant-1.0.2

## To create a VM sandbox for Chef
1. From the ChefDK PS shell
2. Create an empty folder  
  in C:\Users\dcoate\documents\chef for instance  
3. From within the new folder  
  kitchen-init --create-gemfile
  bundle install
4. edit the .kitchen.yml file

    ---  
    driver:  
    name: vagrant  

    provisioner:  
    name: chef_solo  

    platforms:  
    - name: centos65  
        driver:  
        box: learningchef/centos65  
        box_url: learningchef/centos65  

    suites:  
    - name: default  
        run_list:  
        attributes:  

5. kitchen create default-centos65
6. Access the VM if desired
  * kitchen login default-centos65
  * exit
7. kitchen setup default-centos65
  * installs the chef-client
  * kitchen setup runs a provisioner. In this case chef_solo
8. kitchen-list to see last action (and last error?)
9. kitchen destroy default-centos65


Create a vagrant box:
* `vagrant package --output centosgui`
* `vagrant box add CentOSGui centosgui`


Add a disk to a vagrant machine:
* https://realworlditblog.wordpress.com/2016/09/23/vagrant-tricks-add-extra-disk-to-box/

Attempt to add a disk...
* starting output of lsblk
```
NAME            MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
sda               8:0    0  64G  0 disk
├─sda1            8:1    0   1G  0 part /boot
└─sda2            8:2    0  63G  0 part
  ├─centos-root 253:0    0  41G  0 lvm  /
  ├─centos-swap 253:1    0   2G  0 lvm  [SWAP]
  └─centos-home 253:2    0  20G  0 lvm  /home

This is MBR style as boot partition would read /boot/efi
```

Add to Vagrantfile
```
  config.vm.provider :virtualbox do |vb|
    vb.name = "myvm"
    vb.customize [ "createmedium", "disk", "--filename", "testdisk2.vmdk", "--format", "vmdk", "--size", 1024 ]
    vb.customize [ "storageattach", :id, "--storagectl", "SATA Controller", "--port", 1, "--device", 0, "--type", "hdd", "--medium", "testdisk2.vmdk" ]
  end
```

After adding the drive:
```
sdb               8:16   0   1G  0 disk
```
Shows up at the bottom of lsblk

```
sudo fdisk /dev/sdb
n for new partition
p for primary partition
1 (default partition number)
defaults for start and size

Partition table is now:
Device Boot      Start         End      Blocks   Id  System
/dev/sdb1            2048     2097151     1047552   83  Linux

w to write
```

lsblk now shows
```
sdb               8:16   0    1G  0 disk
└─sdb1            8:17   0 1023M  0 part
```

Now use parted
```
help
p print partition list
mklabel msdos
mkpart
primary
accept ext2
start at 1 (MB, just enter 1 by itself)
end 1024
q to quit
```

Create FS

```
mkfs -t ext4 
mkfs.ext4 -L newfs /dev/sdb1
```

Mount
```
sudo mount /dev/sdb1 /newfs
sudo umount /newfs
```

lsblk -f
```
NAME            FSTYPE      LABEL UUID                                   MOUNTPOINT
sda
├─sda1          xfs               6bd03c61-c02b-4d0f-9951-1c0c84c784d8   /boot
└─sda2          LVM2_member       1s5MWk-HhGy-lUHo-CIj5-Fd9e-8dWv-FJXO7c
  ├─centos-root xfs               ddd13445-3f39-4393-b903-0ff187f7cf6b   /
  ├─centos-swap swap              1d86da61-6a50-490d-8b80-969fcf391f4c   [SWAP]
  └─centos-home xfs               1cdc35a1-9e9a-4e8c-b46b-6181b3e4a2b1   /home
sdb
└─sdb1          ext4        newfs ae38206f-b96d-4de1-91da-6307ba08be9e   /newfs
```

In /etc/fstab
`LABEL=newfs  /newfs  ext4  defaults 0 2`

#

Guest additions/x-11/gnome conflict
* placed in etc/yum.conf:  exclude=xorg-x11* gnome*
* installed is:  VBoxGuestAdditions-5.2.18

Set up a sata optical disk then insert guest additions cd
The distribution packages containing the headers are probably:
    kernel-devel kernel-devel-3.10.0-862.11.6.el7.x86_64

    sudo yum install kernel-devel gcc epel-release dkms --enablerepo=extras

    sudo yum install gcc make kernel-devel bzip2 binutils patch libgomp glibc-headers glibc-devel kernel-headers epel-release dkms --enablerepo=extras -y

yum install kernel-devel-3.10.0-862.11.6.el7.x86_64
yum install kernel-devel-3.10.0-862.11.6.el7.x86_64 --enablerepo=extras -y

$ yum update
$ yum install dkms gcc make kernel-devel bzip2 binutils patch libgomp glibc-headers glibc-devel kernel-headers

#

sudo yum update
sudo yum install dkms gcc make kernel-devel bzip2 binutils patch libgomp glibc-headers glibc-devel kernel-headers
sudo yum install dkms --enablerepo=extras -y
sudo yum install epel-release dkms --enablerepo=extras -y
ls /usr/src/kernels
sudo yum install kernel-devel-3.10.0-957.el7.x86_64
vagrant halt
Add sata optical drive
vagrant up
mount guest additons and run

VirtualBox Guest Additions: Look at /var/log/vboxadd-setup.log to find out what went wrong

https://sobo.red/2017/04/27/installing-virtualbox-guest-additions-on-centos-7/

sudo vim /usr/share/X11/xorg.conf.d/10-monitor.conf
```
Section "Screen"
	Identifier	"Default Screen"
	Device		"VirtualBox graphics card"
	Monitor		"Generic Monitor"
	DefaultDepth	24
	SubSection "Display"
		Depth		24
		Modes		"1920x1080"
	EndSubSection
EndSection
```