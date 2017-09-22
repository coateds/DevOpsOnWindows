# Chef Packages Test and Resource Code

## Ubuntu example
This introduces very simple resources with coresponding unit and integration tests. Then it moves on to installing muliple packages with an array and loop and finally some limitied programming based on the value of Ohai/Fauxhai attributes.

It is possible to use these attributes in recipes and integration testing, however I have not figured out how to do so in unit tests/ChefSpec.

Simple Single Package
```
# ChefSpec
describe 'azurex2::default' do
  context 'When all attributes are default, on an Ubuntu 16.04' do
    let(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04')
      runner.converge(described_recipe)
    end

    it 'installs net-tools' do
      expect(chef_run).to install_package('samba')
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end
end

# InSpec
unless os.windows?
  # This is an example test, replace with your own test.
  describe user('root') do
    it { should exist }
  end
end

describe package('samba') do
  it { should be_installed }
end

Recipe
package 'samba'
```

Install 3 packages from an array
```
# ChefSpec
# This code works to test the installation of each element an array
packages = []

%w(net-tools php-common apache2).each do |item|
  packages << item
end

packages.each do |pkg|
  it 'installs apache2' do
    expect(chef_run).to install_package(pkg)
  end
end

# InSpec
packages = []

%w(net-tools php-common apache2).each do |item|
  packages << item
end

packages.each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end

# Recipe
%w(net-tools php-common apache2).each do |item|
    package item
end
```

Install httpd or apache2 depnding on OS family
```
# ChefSpec
# I do not know how to do this

# InSpec
case os[:family]
when 'redhat'
  describe package('httpd') do
    it { should be_installed }
  end
when 'debian'
  describe package('apache2') do
    it { should be_installed }
  end
end

# Recipe
case node['platform_family']
when 'redhat'
  package 'httpd'
when 'debian'
  package 'apache2'
end
```

## Windows Chocolatey examples
This will introduce using external cookbooks. Although there are a number of software installation resources available from Chef for Windows, the most useful is a cookbook for Chocolatey. To utilize this takes 2 lines.
```
# Metadata.rb
depends 'chocolatey'

# In the recipe
include_recipe 'chocolatey::default'
```

The default recipe of the chocolatey cookbook installs chocolatey if it is not already installed. Note this will install the current version at the time of the converge. Subsequent upgrades will require an explicit resource with the :upgrade action.

To install a chocolatey package after chocolatey is installed is a single line of code, or a full resource block if there is something extra to do.
```diff
# ChefSpec

- I do not have a unit test for the installation of Chocolatey

it 'installs a package' do
  expect(chef_run).to install_chocolatey_package('visualstudiocode')
end

it 'installs a package with options' do
  expect(chef_run).to install_chocolatey_package('git').with(
    options: '--params /GitAndUnixToolsOnPath'
  )
end

- InSpec Test is not available for Chocolatey at this time

# In the recipe
chocolatey_package 'visualstudiocode'

chocolatey_package 'git' do
  options '--params /GitAndUnixToolsOnPath'
end

# If the chocolatey package itself gets upgraded  during the lifecycle of a test machine, upgrade it
chocolatey_package 'chocolatey' do
  action :upgrade
end

- Not possible to do MSU (such as PowerShell) packages via Chocolatey at this time.
```

## The Install_Packages Cookbook
As of this writing, I authored this cookbook as a simple demonstration for placing a cookbook on GitHub that can be included in local cookbooks. This makes the local cookbook a "wrapper" cookbook and there is a good argument to be make that nearly all functionality ought to work this way.

Another benefit of doing it this way is that I can add resources for every Chocolatey package (and others?) I can think of and control whether they are utilized with attributes. This is consistent with the way wrapper cookbooks are designed to work with resource cookbooks on the Internet.

The cookbook can be found <a href="https://github.com/coateds/Install_Packages">here</a>. Instructions are largely included in the README.

The first new concept is the berksfile. Berks is a dependency manager. Its job is to go find and load needed cookbooks during a converge. By default, the contents of the file direct the cookbook to the Chef Supermarket and the metadata file.

To use the Install_Packages cookbook:
```
# metadata.rb
depends 'Install_Packages', '>= 0.1.0'

# Berksfile
cookbook "Install_Packages", "~> 0.1.0", git: "https://github.com/coateds/Install_Packages.git", ref: "42f15fcadbbdae33dae1daaa291b68bbaccbe9fb"

# default recipe
include_recipe 'Install_Packages'
```

With just these three additions to a blank cookbook take a look at the output from `kitchen converge`

```diff
resolving cookbooks for run list: ["azurex1::default"]
Synchronizing Cookbooks:
  - Install_Packages (0.1.0)
  - chocolatey (1.2.1)
  - windows (3.1.3)
  - ohai (5.2.0)
  - azurex1 (0.1.0)

-Why did visualstudiocode get installed?
```

The chocolatey, windows and ohai cookbooks are added by Berks because some other recipe depends on it. The exact dependency relationships can be seen in the Berksfile.lock file.

## Windows MSU package example
This is a somewhat advanced example for installing PowerShell 5.1. This installation is treated like a security patch, and the Chocolatey_packege resource cannot do it. This issue is really about running this remotely. Chocolately is capable of installing PowerShell when run locally or via RDP.

To prep for these resources, it may be necessary to build the scaffolding for it in the Test-Kitchen cookbook. `chef generate file default` Then place a copy of the .msu file into [cookbook\files\default]. I intend to place a fuller explanation for this in the FilesTemplates.md file.
```diff
-To Do: Add Inspec and ChefSpec tests for these resources

cookbook_file 'c:\SourceSoftware\Win8.1AndW2K12R2-KB3191564-x64.msu' do
	source 'Win8.1AndW2K12R2-KB3191564-x64.msu'
end

reboot 'Restart Computer' do
  action :nothing
end

msu_package 'Install Windows WMF5.1 KB3191564' do
  source 'C:\SourceSoftware\Win8.1AndW2K12R2-KB3191564-x64.msu'
  # action :remove
  action :install
  notifies :reboot_now, 'reboot[Restart Computer]', :immediately
end

- Note that there is a Windows Package (.msi) resource as well
```

Steps to automate to patch
```
Install-PackageProvider -Name "NuGet" -Force
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
Install-Module -name PSWindowsUpdate
Add-WUServiceManager -ServiceID 7971f918-a847-4430-9279-4a52d1efe18d -confirm:$False
Get-WUInstall –MicrosoftUpdate –AcceptAll –AutoReboot
```
# Detritus

Simple package example on CentOS
```
ChefSpec Test:
  require 'spec_helper'

  describe 'lcd_web::default' do
    context 'CentOS' do
      let(:chef_run) do
        runner = ChefSpec::ServerRunner.new(platform: 'centos', version: '7.2.1511')
        runner.converge(described_recipe)
      end

      it 'converges successfully' do
        expect { chef_run }.to_not raise_error
      end

      it 'installs httpd' do
        expect(chef_run).to install_package('httpd')
      end

      it 'installs net-tools' do
        expect(chef_run).to install_package('net-tools')
      end

      it 'enables the httpd service' do
        expect(chef_run).to enable_service('httpd')
      end

      it 'starts the httpd service' do
        expect(chef_run).to start_service('httpd')
      end

    end
  end


InSpec Test:
  ['net-tools', 'httpd'].each do |pkg|
    describe package(pkg) do
      it { should be_installed }
    end
  end

Recipe:

package 'httpd'
package 'net-tools'

service 'httpd' do
service platform_service_httpd do
  action [:enable, :start]
end

```

