# Chef Packages Test and Resource Code

## Ubuntu example
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

Chocolatey package example on Windows
```diff
metadata.rb:
depends 'chocolatey'

ChefSpec Test:
it 'installs a specific version of a package with options' do
  expect(chef_run).to install_chocolatey_package('git').with(
    options: '--params /GitAndUnixToolsOnPath'
  )
end

- InSpec Test is not available for Chocolatey at this time

Recipe
# Include the cookbook
include_recipe 'chocolatey::default'

chocolatey_package 'chocolatey' do
  action :upgrade
end

chocolatey_package 'git' do
  options '--params /GitAndUnixToolsOnPath'
end

chocolatey_package 'visualstudiocode'

- Not possible to do MSU (such as PowerShell) packages via Chocolatey at this time.
```

MSU package example
```diff
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

To install Chocolatey if necessary
* In metadata.rb:  `depends 'chocolatey'`
* `berks install
* In recipes\default.rb: `include_recipe 'chocolatey::default'`
