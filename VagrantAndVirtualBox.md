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