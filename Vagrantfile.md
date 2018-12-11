# Notes and examples for a Vagrant file

## The simplest possible
This consists of a Ruby loop that configures the box. At a minimum the 'box' needs to have a 
```ruby
Vagrant.configure(2) do |config|
  config.vm.box = "bento/centos-7.4"
end
```

## Networking and HostName
```ruby
# to set the hostname inside the guest OS
config.vm.hostname = "goober"

# two possible IP network settings:
config.vm.network :private_network, ip: "192.168.16.26"
config.vm.network "private_network", type: "dhcp"

# Port forwarding
# The port 80 on the guest can be accessed from 8080 on the host
config.vm.network "forwarded_port", guest: 80, host: 8080

# More network settings in the initial file... see below
```

## Provider specific configurations
At this point, I am only using VirtualBox:
```ruby
# This loop gets nested inside the main loop
config.vm.provider "virtualbox" do |vb|
  # To set the name VirtualBox uses for the vm
  vb.name = "Gooberette"

  # The following will create a 1 GB disk and attach it to the VM
  # use this var to name the disk file
  file_to_disk = "gooberdisk.vmdk"
  # Only create the file if it does not exist
  # `vagrant destroy` will delete this file
  unless File.exist?(file_to_disk)
    vb.customize [ "createmedium", "disk", "--filename", file_to_disk, "--format", "vmdk", "--size", 1024 ]
  end
  # attach the file
  # in Linux this will appear as "sdb" in the lsblk output
  vb.customize [ "storageattach", :id, "--storagectl", "SATA Controller", "--port", 1, "--device", 0, "--type", "hdd", "--medium", file_to_disk ]
end
```

## Provisioning
```ruby
# On a Linux Guest, run a bash script
config.vm.provision "shell", path: "provision.sh"

# A better (to me) process is to use the chef solo provisioner

config.vm.provision "chef_solo" do |chef|
  chef.add_recipe "recipe1"
  chef.add_recipe "recipe2"
  chef.add_recipe "recipe2"
end

# Chef cookbooks/recipes
# vm root folder
#   cookbooks
#     recipe1 (or 2, 3)
#       recipes
#         default.rb
```

chef_solo documentation
* https://www.vagrantup.com/docs/provisioning/chef_solo.html
* https://www.vagrantup.com/docs/provisioning/chef_common.html
* https://andrewtarry.com/chef_with_vagrant/

Chef Zero with Berkshelf:
* https://blog.swiftsoftwaregroup.com/how-to-use-berkshelf-chef-zero-vagrant-and-virtualbox


## ref: a fresh vagrant file from the init command
```ruby
# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "base"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
end
```