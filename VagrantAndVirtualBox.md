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