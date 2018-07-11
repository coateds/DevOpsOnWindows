# Using Ruby

Notes about Ruby scripting on both Linux and Windows. Also how it might apply to Chef.

## run Ruby scripts
* Install Ruby, on Windows just use Chocolatey
* to run a script: `ruby [path/to/file.rb]`
* To install on Linux, use rvm

## Interactive
* run irb (quit to quit)
* Variables are dynamic, .class to view type
* String.public_methods.sort to see a class' methods

## Study Environments
* A distribution (simple install) Package was installed to Ubuntu Workstation (VM on my work script box)
* RVM Install on Cloud Server 1, Linux Academy
  * browse to rvm.io use the command found there (should be similar to the curl command below)
  * gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
  * \curl -sSL https://get.rvm.io | bash -s stable
  * source /home/user/.rvm/scripts/rvm
* sudo yum install -y kernel-headers --disableexcludes=all
* rvm install ruby

## Variable Scopes
Local: begin with lowercase letter
Instance: begin with @
class: begin with @@
global: begin with $

## Shell commands from Ruby
backticks can be used to encapsulate shell commands and use their return
on Windows, the default shell is cmd, use `powershell` keyword to invoke
PowerShell
The system method can also be used, but I will hold on examples until I decide 
it is necessary to use this option in some cases

```ruby
res = `time /t`
puts res

res = `powershell get-date`
puts res
```

## Classes and Objects
* Class names start with a capital letter and use CamelCase
* class [child classname] < [parent classname]