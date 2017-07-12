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

```
Generated lcd_web cookbook with attribute and users recipe

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

<a href="https://linuxacademy.com/cp/exercises/view/id/419/module/122">Create and Run ChefSpec Tests</a>
* ChefSpec/RSpec for unit tests
* for a complete list of available platforms and versions see: https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
* (Includes Windows and Ubuntu versions that will be of interest)
* Note there is a default_spec.rb and users_spec.rb file, one for each recipe file??
```
    ├── spec
    │   ├── spec_helper.rb
    │   └── unit
    │       └── recipes
    │           ├── default_spec.rb
    │           └── users_spec.rb
```
* After entering tests in spec/unit/recipes/default_spec.rb.  Run `chef exec rspec` from root of cookbook.

```
resulting failures:
1) lcd_web::default CentOS installs httpd
2) lcd_web::default CentOS installs net-tools
3) lcd_web::default CentOS enables the httpd service
4) lcd_web::default CentOS starts the httpd service

Resolve these failures by placing the appropriate Ruby/ChefDSL code in recipes/default.rb. This is one possible simple syntax.

  package 'httpd'

  package 'net-tools'

  service 'httpd' do
    action [:enable, :start]
  end

```

* Users tests
```
Resolve failures by writing the appropriate code in recipes/users.rb

  group 'developers'

  user 'webadmin' do
    action :create
    uid '1020'
    gid 'developers'
    home '/home/webadmin'
    shell '/bin/bash'
  end
```

At this point, the ChefSpec unit tests are simply testing to see if the correct blocks of code are contained in the recipes to satisfy the tests. There is no real 'driver' for this and only the syntax *might* be platform dependent. Plainly put, if there is a test that says a web server should be installed then there must be a corresponding package block in the corresponding recipe.

Whether it is CentOS or Windows, first expect it, then install it
* expect(chef_run).to install_package('httpd')
* package 'httpd'
* expect(chef_run).to install_package('iis')
* package 'iis'

From here it is reasonable to start running Kitchen commands
* kitchen list
* kitchen init
* kitchen setup
* kitchen test
* kitchen create
* kitchen login
* kitchen converge
* kitchen verify
* kitchen diagnose
* kitchen destroy
* kitchen driver create
* kitchen driver discover
* kitchen exec
* kitchen version

Verify can run
* kitchen list
* kitchen create
* kitchen login
* kitchen converge
* kitchen verify
* kitchen destroy

<a href="https://linuxacademy.com/cp/exercises/view/id/420/module/122">Create and Run InSpec Tests</a>
* The Integration tests run here are analogous to the unit tests run above
* When doing this for Windows, use Pester???
* To show functionality, comment out Ruby blocks in recipes/default.rb and recipes/users.rb
* Create tests in test/smoke/default
* `kitchen verify`
* tests fail
* put recipes functionality back and watch tests pass
  * `kitchen destroy` and `kitchen verify`
  * -or- `kitchen converge` and `kitchen verify`

Use Kitchen Verify to run InSpec for integration tests
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