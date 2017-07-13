# Using Chef
A great deal of what this DevOps repository has been leading up to is using Chef. This further breaks down into 3 sections:

## Other pages
* <a href="ChefCode/TestResource.md">Chef Testing and Resource Code</a>
  * <a href="ChefCode/FilesTemplates.md">Files and Templates</a>
  * <a href="ChefCode/Packages.md">Packages</a>

## ChefDK/Test Kitchen/HyperV lab guest automation
The ChefDK, by itself, is enough to provide a lot of automation opportunities in a hypervisor environment. Guests can be provisioned and customized with an ever increasing set of tools. See <a href="HypervKitchen.md">My latest Test Kitchen on HyperV installation</a> for notes on installing ChefDK on a HyperV host and creating Windows VMs. At last writing this was with ChefDK 1.4.3. As of July 2017, ChefDK 2.0 is available.

Also over the summer of 2017, I am studying for the Local Cookbook Development Badge towards Chef certification. This is largely about understanding how to use ChefDK. It is obvious that Chef is largely developed for Linux, but trying to service Windows more and more. I see a possible opportunity to learn how to use Chef for Windows environments rather ahead of the herd.

In addition, there is an opportunity to turn this around and use a ChefDK/Test Kitchen/HyperV environment to constantly install new versions of Microsoft back office/server software in evaluation modes.

## Chef Server on Ubuntu/Enterprise automation

## Earning a Chef certification for my resume

### Linux Academy - Main Course Lab

Uses Cloud Server 5

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

<a href="https://linuxacademy.com/cp/exercises/view/id/466/module/122">Create a Template</a>

All this exercise does is to create and assign values to a pair of attributes. These are then utilized in a template along with an Ohai generated value. Finally, this template is placed in a directory where it can be served up by the web server as accessed by Curl.

<a href="https://linuxacademy.com/cp/exercises/view/id/467/module/122">Create a Library</a>

The Library structure is created manually. (There is no generator) Within libraries/default.rb a simple function(?) is created: "index_exists?"

The function is called in a guard in recipes/default.rb. The intent is that httpd is (re)started if the file /var/www/html/index.html exists.

At the very end of the kitchen converge run I see:
```
execute[systemctl start httpd] action run
execute systemctl start httpd
```

A module, LcdWebCookbook::Helpers, is set up in libraries/helpers.rb. It defines two functions: platform_package_httpd and platform_service_httpd.

In recipes/default `package 'httpd'` is replaced with `package platform_package_httpd` to install the web server and `service 'httpd' do` is replaced with `service platform_service_httpd do` as the start of the ruby block that enables and starts the web server.

The net effect here is that this installation and service control of the web server would work on Ubuntu as well as Centos.

The verification is to `kitchen login` and `curl http://localhost/index.html`. Further, `sudo systemctl stop httpd` will cause the curl command to fail as that stops the web server.

<a href="https://linuxacademy.com/cp/exercises/view/id/421/module/122">Use a Custom Resource</a>

Like the libraries, there is no generator for resources. Create manually.

Create the resource 'hello_httpd' in the file resources/hello.rb. This resource includes a property, 'greeting', that can be passed to the function as it is being called. In recipes/default.rb, this resource replaces the package install/control as well as the call to the template.

<a href="https://linuxacademy.com/cp/exercises/view/id/478/module/122">Create a Wrapper Cookbook</a>

Create a new cookbook lcd_haproxy and add a depends statement in the metadata.rb file, including a version, for the haproxy cookbook to be wrapped. At this point, `berks install` will download the haproxy cookbook and its dependencies from the supermarket. These cookbooks are installed to ~/.berkshelf/cookbooks.

Include the 'manual' recipe from haproxy in the default recipe of lcd_haproxy.

Generate an attributes file. The contents of this file will customize the wrapped cookbook.

*Note: look at contents in /etc/haproxy/haproxy.cfg on haproxy machine*

Ultimately, the kitchen.yml file will describe 3 servers to install: 1 haproxy and 2 web servers. These are listed under the suites: section. Note that a `kitchen list` will have multiple instances, one for each subsection in suites. these can be created/converged independently: `kitchen create/converge loadbalancer`.

The other two instances that (will) be listed in the kitchen.yml suites are to be converged with the lcd_web cookbook, but at this time the lcd_haproxy cookbook does not know where to find it.
* Add the path to the lcd_web cookbook in the Berksfile: `cookbook 'lcd_web', path: '../lcd_web'`
* This seems to have been sufficient. The lab instructions hint at running berks install, but was not necessary?

Partial Templates
* chef generate template header.html
* chef generate template footer.html
* header.html.erb
```
<html>
<head>
<title><%= node['fqdn'] %></title>
</head>
```
* index.html.erb
```
<%= render "header.html.erb", cookbook: 'lcd_web' %>
<% if @greeting == "Horked" %>
<%= @greeting %> <%= @greeting_scope %> from <%= @fqdn %>
<% end %>
<%= render "footer.html.erb", cookbook: 'lcd_web' %>
```
* footer.html.erb
```
<p>Goodbye world</p>
</body>
</html>
```

```diff
- NEXT STEPS
  There are more template exercises in Templates Lecture... Headers and Footers, oh my!
  Data Bags
  Search
```

### Linux Academy - Practice Cookbook Lab
uses Cloud Server6?

This looks to be a practice test. The point seems to be to analyze the integration tests in test/smoke/default/default_test.rb. Then write code in to recipes/default.rb to satisfy those tests

kitchen verify brought up 2 instances, one centos and one ubuntu

kitchen.yml
```
---
driver:
  name: docker
  privileged: true
  use_sudo: false

provisioner:
  name: chef_zero
  # You may wish to disable always updating cookbooks in CI or     other testing environments.
  # For example:
  #   always_update_cookbooks: <%= !ENV['CI'] %>
  always_update_cookbooks: true

verifier:
  name: inspec

platforms:
  - name: centos-7.2
    driver_config:
      run_command: /usr/lib/systemd/systemd
  - name: ubuntu-16.04
    driver_config:
      run_command: /bin/systemd
suites:
 - name: default
   run_list:
     - recipe[lcd_basic::default]
   verifier:
     inspec_tests:
       - test/smoke/default
   attributes:
```

test/smoke/default/default_test.rb
```
packages = []

%w(net-tools php-common).each do |item|
  packages << item
end

case os[:family]
when 'redhat'
  packages << 'httpd'
when 'debian'
  packages << 'apache2'
end

packages.each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end

case os[:family]
when 'redhat'
  describe file('/usr/bin/php') do
    it { should exist }
    its('mode') { should cmp '00755' }
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
  end

  describe service('httpd') do
    it { should be_running }
  end

when 'debian'
  describe file('/usr/bin/php7.0') do
    it { should exist }
    its('mode') { should cmp '00755' }
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
  end

  describe service('apache2') do
    it { should be_running }
  end
end

describe group('developers') do
  it { should exist }
end

describe user('webadmin') do
  it { should exist }
  its('group') { should eq 'developers' }
end

describe port(80) do
  it { should be_listening }
end

describe command 'curl http://localhost' do
  its('stdout') { should match(/Greetings, Planet Earth!/) }
end
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