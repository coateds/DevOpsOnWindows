# Using Chef
A great deal of what this DevOps repository has been leading up to is using Chef. This further breaks down into 3 sections:

## ChefDK/Test Kitchen/HyperV lab guest automation
The ChefDK, by itself, is enough to provide a lot of automation opportunities in a hypervisor environment. Guests can be provisioned and customized with an ever increasing set of tools. See <a href="HypervKitchen.md">My latest Test Kitchen on HyperV installation</a> for notes on installing ChefDK on a HyperV host and creating Windows VMs. At last writing this was with ChefDK 1.4.3. As of July 2017, ChefDK 2.0 is available.

Also over the summer of 2017, I am studying for the Local Cookbook Development Badge towards Chef certification. This is largely about understanding how to use ChefDK. It is obvious that Chef is largely developed for Linux, but trying to service Windows more and more. I see a possible opportunity to learn how to use Chef for Windows environments rather ahead of the herd.

In addition, there is an opportunity to turn this around and use a ChefDK/Test Kitchen/HyperV environment to constantly install new versions of Microsoft back office/server software in evaluation modes.

## Chef Server on Ubuntu/Enterprise automation

## Earning a Chef certification for my resume

Linux Academy

Hands-on Labs: Chef Cookbook - Develop a Simple Cookbook and Create a Wrapper Cookbook
* Make sure to use the North Virginia (N. Virginia) region to launch resources.


<a href="https://linuxacademy.com/cp/exercises/view/id/417/module/122">Development Environment Setup</a>
* `chef --version` to see the installed version.
* The instructions install the latest version which jumped from 1.4.3 to 2.0.26 in July 2017
* Git is installed along the way
* Docker is installed and configured

<a href="https://linuxacademy.com/cp/exercises/view/id/418/module/122">Generate with a Generator</a>
* Edit kitchen.yml.erb
* Edit metadata.rb.erb (not in this exercise)
* Edit spec_helper.rb
* Edit README.md.erb
* Create config.rb file  ---  Create ~/.chef directory

Generated lcd_web cookbook with attribute and users recipe
```
└── lcd_web
    ├── attributes
    │   └── default.rb
    ├── Berksfile
    ├── chefignore
    ├── metadata.rb
    ├── README.md
    ├── recipes
    │   ├── default.rb
    │   └── users.rb
    ├── spec
    │   ├── spec_helper.rb
    │   └── unit
    │       └── recipes
    │           ├── default_spec.rb
    │           └── users_spec.rb
    └── test
        └── smoke
            └── default
                ├── default_test.rb
                └── users_test.rb
```

Testing  ---  trying to keep this straight  ***VERIFY THIS!!!***
* ChefSpec/RSpec for unit tests?

```
├── spec
│   ├── spec_helper.rb
│   └── unit
│       └── recipes
│           └── default_spec.rb
```

* Inspec for integration tests??  'in'spec
```
└── test
    └── smoke
        └── default
            └── default_test.rb
```

# Detritus
For instructions to set up a test kitchen VM:
https://github.com/coateds/DevOpsOnWindows/blob/master/VagrantAndVirtualBox.md

Copy files/content from https://github.com/learningchef

## Cookbooks
* There are now two methods for generating a cookbook. Knife is the old way. Chef generate is preferred.
* chef generate cookbook motd  -- (message of the day)
  The motd folder is under git version control from the outset
* Edit the .kitchen.yml file as needed
* Use the chef generate tool to create more resources
  chef generate file motd  (a file resource)
    edit files/default/motd
    edit recipes/default.rb

## Performing a Converge
* This process: deploys a cookbook to a node and applies a run list
* From inside the motd directory:
  kitchen converge default-centos65
* converge will run kitchen create and kitchen setup as needed
* The point of this exercise was to install a VM, Install the chef-client on that VM and then creating a file resource as defined in motd\files\recipes\default.rb
  The file itself can be found in motd\files\default