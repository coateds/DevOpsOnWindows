# HyperV Test Kitchen

Going to attempt a documented install of Test-Kitchen Windows instances on Windows10 laptop

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
* Create file c:\config.rb with content chefdk.generator_cookbook "C:/chef/generator/hyperv_origin"
* Edit C:\chef\generator\hyperv_origin\templates\default\kitchen.yml.erb to read


***Pester does not work yet?***

```
---
driver:
  name: hyperv
  parent_vhd_folder: C:\HyperV Resources
  parent_vhd_name: BaseBox1.vhdx
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

Remove Pester from kitchen.yml for now


C:\chef\ServerX1 [master +0 ~1 -0 !]> kitchen create
-----> Starting Kitchen (v1.16.0)
-----> Creating <default-windows-2012r2>...
       Creating differencing disk for default-windows-2012r2.
       Created differencing disk for default-windows-2012r2.
       Checking for existing virtual machine.
       Creating virtual machine for default-windows-2012r2.
       Created virtual machine for default-windows-2012r2.
>>>>>> ------Exception-------
>>>>>> Class: Kitchen::ActionFailed
>>>>>> Message: 1 actions failed.
>>>>>>     Failed to complete #create action: [command timed out:
---- Begin output of c:\windows\sysnative\windowspowershell\v1.0\powershell.exe -noprofile -executionpolicy bypass -encodedcommand LgAgAEMAOgAvAFUAcwBlAHIAcwAvAGQAYwBvAGEAdABlAC8AQQBwAHAARABhAHQAYQAvAEwAbwBjAGEAbAAvAGMAaABlAGYAZABrAC8AZwBlAG0ALwByAHUAYgB5AC8AMgAuADMALgAwAC8AZwBlAG0AcwAvAGsAaQB0AGMAaABlAG4ALQBoAHkAcABlAHIAdgAtADAALgA0AC4AMQAvAGwAaQBiAC8AawBpAHQAYwBoAGUAbgAvAGQAcgBpAHYAZQByAC8ALgAuAC8ALgAuAC8ALgAuAC8AcwB1AHAAcABvAHIAdAAvAGgAeQBwAGUAcgB2AC4AcABzADEAOwAKAAoAIAAgACAAIAAgACAAIAAgACAAIABHAGUAdAAtAFYAbQBEAGUAdABhAGkAbAAgAC0AaQBkACAAIgAxADkAMAA3AGQANgBlAGYALQBjADkAOAA2AC0ANABkADUAZgAtAGIAYwBiADkALQBmADAAYQBjADAAMwAwAGEAYgA0ADIANgAiACAAfAAgAEMAbwBuAHYAZQByAHQAVABvAC0ASgBzAG8AbgAKAA== -outputformat Text ----
STDOUT:
STDERR: #< CLIXML
---- End output of c:\windows\sysnative\windowspowershell\v1.0\powershell.exe -noprofile -executionpolicy bypass -encodedcommand LgAgAEMAOgAvAFUAcwBlAHIAcwAvAGQAYwBvAGEAdABlAC8AQQBwAHAARABhAHQAYQAvAEwAbwBjAGEAbAAvAGMAaABlAGYAZABrAC8AZwBlAG0ALwByAHUAYgB5AC8AMgAuADMALgAwAC8AZwBlAG0AcwAvAGsAaQB0AGMAaABlAG4ALQBoAHkAcABlAHIAdgAtADAALgA0AC4AMQAvAGwAaQBiAC8AawBpAHQAYwBoAGUAbgAvAGQAcgBpAHYAZQByAC8ALgAuAC8ALgAuAC8ALgAuAC8AcwB1AHAAcABvAHIAdAAvAGgAeQBwAGUAcgB2AC4AcABzADEAOwAKAAoAIAAgACAAIAAgACAAIAAgACAAIABHAGUAdAAtAFYAbQBEAGUAdABhAGkAbAAgAC0AaQBkACAAIgAxADkAMAA3AGQANgBlAGYALQBjADkAOAA2AC0ANABkADUAZgAtAGIAYwBiADkALQBmADAAYQBjADAAMwAwAGEAYgA0ADIANgAiACAAfAAgAEMAbwBuAHYAZQByAHQAVABvAC0ASgBzAG8AbgAKAA== -outputformat Text ----

ProcessId: 10220
app_name: c:\windows\sysnative\windowspowershell\v1.0\powershell.exe
command_line: c:\windows\sysnative\windowspowershell\v1.0\powershell.exe -noprofile -executionpolicy bypass -encodedcommand LgAgAEMAOgAvAFUAcwBlAHIAcwAvAGQAYwBvAGEAdABlAC8AQQBwAHAARABhAHQAYQAvAEwAbwBjAGEAbAAvAGMAaABlAGYAZABrAC8AZwBlAG0ALwByAHUAYgB5AC8AMgAuADMALgAwAC8AZwBlAG0AcwAvAGsAaQB0AGMAaABlAG4ALQBoAHkAcABlAHIAdgAtADAALgA0AC4AMQAvAGwAaQBiAC8AawBpAHQAYwBoAGUAbgAvAGQAcgBpAHYAZQByAC8ALgAuAC8ALgAuAC8ALgAuAC8AcwB1AHAAcABvAHIAdAAvAGgAeQBwAGUAcgB2AC4AcABzADEAOwAKAAoAIAAgACAAIAAgACAAIAAgACAAIABHAGUAdAAtAFYAbQBEAGUAdABhAGkAbAAgAC0AaQBkACAAIgAxADkAMAA3AGQANgBlAGYALQBjADkAOAA2AC0ANABkADUAZgAtAGIAYwBiADkALQBmADAAYQBjADAAMwAwAGEAYgA0ADIANgAiACAAfAAgAEMAbwBuAHYAZQByAHQAVABvAC0ASgBzAG8AbgAKAA== -outputformat Text
timeout: 600] on default-windows-2012r2
>>>>>> ----------------------
>>>>>> Please see .kitchen/logs/kitchen.log for more details
>>>>>> Also try running `kitchen diagnose --all` for configuration

## Troubleshooting
I am investigating the possibility the vhdx created on a Server2012R2 box is not entirely working in Kitchen on Windows 10. So I am building a BaseBox2 by installing 2012R2 from the ISO on a Windows 10 laptop