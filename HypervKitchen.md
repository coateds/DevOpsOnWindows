# HyperV Test Kitchen

Going to attempt a documented install of Test-Kitchen Windows instances on Windows10 laptop

## Kitchen Commands
| Command                                 | Description                 |
|-----------------------------------------|-----------------------------|
| kitchen console                         | Kitchen Console!            |
| kitchen converge [INSTANCE,REGEXP,all]  | Change instance state to converge. Use a provisioner to configure one or more instances|
| kitchen create [INSTANCE,REGEXP,all]    | Change instance state to create. Start one or more instances|
| kitchen destroy [INSTANCE,REGEXP,all]   | Change instance state to destroy. Delete all information for one or more instances|
| kitchen diagnose [INSTANCE,REGEXP,all]  | Show computed diagnostic configuration
| kitchen driver                          | Driver subcommands           |
| kitchen driver create [NAME]            | Create a new Kitchen Driver gem project|
| kitchen driver discover                 | Discover Test Kitchen drivers published on RubyGems
| kitchen driver help [COMMAND]           | Describe subcommands or one specific subcommand
| kitchen exec INSTANCE,REGEXP -c REMOTE_COMMAND  | Execute command on one or more instance
| kitchen help [COMMAND] | Describe available commands or one specific command
| kitchen init | Adds some configuration to your cookbook so Kitchen can rock
| kitchen list [INSTANCE/REGEXP/all] | Lists one or more instances
| kitchen login INSTANCE/REGEXP | Log in to one instance
| kitchen package INSTANCE/REGEXP | package an instance
| kitchen setup [INSTANCE/REGEXP/all] | Change instance state to setup. Prepare to run automated tests. Install busser and related gems on one or more instances
| kitchen test [INSTANCE/REGEXP/all] | Test (destroy, create, converge, setup, verify and destroy) one or more instances
| kitchen verify [INSTANCE|REGEXP|all] | Change instance state to verify. Run automated tests on one or more instances
| kitchen version | Print Kitchen's version information

## Versions
* Windows 10 (June 2017)
* ChefDK 1.4.3

## Lessons
A VM guest, when spun up by kitchen create must be able to talk (network working) to the HyperV host running ChefDK or the process will time out and Kitchen will not be entirely aware of the guest. Make sure to call out a Virtual Switch that actually exists.

## Process
* Install HyperV feature on Windows 10
* Configure default network swtich  "ExternalSwitch". Verify this switch is connected to the correct NIC. Can the guest connect to the network when done?
* Try to use the BaseBox1 vhdx from Script box. Just starting with a straight copy of the BaseBox1.vhdx file. Created a VM on HyperV in the laptop and connected it to the BaseBox1.vhdx. Verified the VM will start and I can logon to it.
* gem install kitchen-hyperv  ***This only mostly worked!!***
* Create folder c:\chef and c:\chef\generator
* From within c:\chef\generator,  chef generate generator hyperv_origin
* Create file c:\chef\config.rb with content
```
cookbook_path ['~/documents/cookbooks']
local_mode true
chefdk.generator_cookbook "C:/chef/generator/hyperv_origin"
```
* Edit C:\chef\generator\hyperv_origin\templates\default\kitchen.yml.erb to read


***Pester does not work yet?***

```
---
driver:
  name: hyperv
  parent_vhd_folder: C:\HyperV Resources  (Or appropriate)
  parent_vhd_name: BaseBox1.vhdx  (Or appropriate)
  vm_switch: ExternalSwitch
  memory_startup_bytes: 2GB

provisioner:
  name: chef_zero

transport:
  password: H0rnyBunny

verifier:
  name: pester

platforms:
  - name: windows-2012r2

suites:
  - name: default
    run_list:
      - recipe[<%= cookbook_name %>::default]
    verifier:
      inspec_tests:
        - test/smoke/default
    attributes:
```

* From C:\chef  --  chef generate cookbook ServerX1


```diff
- Error:  Could not load the 'hyperv' driver from the load path. Please ensure that your driver is installed as a gem or included in your Gemfile if using Bundler.
```

```diff
+ gem install kitchen-hyperv
```

C:\chef\ServerX1 [master]> gem install kitchen-hyperv
Fetching: kitchen-hyperv-0.4.1.gem (100%)
WARNING:  You don't have c:\users\dcoate\appdata\local\chefdk\gem\ruby\2.3.0\bin in your PATH,
          gem executables will not run.
Successfully installed kitchen-hyperv-0.4.1
Parsing documentation for kitchen-hyperv-0.4.1
Installing ri documentation for kitchen-hyperv-0.4.1
Done installing documentation for kitchen-hyperv after 3 seconds
1 gem installed
C:\chef\ServerX1 [master]>

C:\chef\ServerX1 [master]> gem install pester  !! This did not work !!
Fetching: pester-1.0.0.gem (100%)
WARNING:  You don't have c:\users\dcoate\appdata\local\chefdk\gem\ruby\2.3.0\bin in your PATH,
          gem executables will not run.
Successfully installed pester-1.0.0
Parsing documentation for pester-1.0.0
Installing ri documentation for pester-1.0.0
Done installing documentation for pester after 2 seconds
1 gem installed

## Creating a Server via Test Kitchen
* chef generate cookbook ServerX1
* cd ServerX1
* kitchen create
  * A VM named default-windows-2012r2 is created
  * All this does is to install the OS
* kitchen converge
  * This will install the chef client and run recipes

## Troubleshooting
I am investigating the possibility the vhdx created on a Server2012R2 box is not entirely working in Kitchen on Windows 10. So I am building a BaseBox2 by installing 2012R2 from the ISO on a Windows 10 laptop