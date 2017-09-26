# Chef Files/Templates Test and Resource Code

Chef includes several resources for directory and file manipulation. In the packages discussion, I hinted at including a software source file (a .msu in this case) in the recipe to be copied during a converge so it can be accessed during the installation of that software. The first thing to do is create the file scaffolding in the cookbook for your test kitchen instance:

`chef generate file index.html`

## Building out some simple web pages on an Ubuntu server.
Start by editing files\default\index.html that was created with the command above. Note that it is not necessary to create the file in this way after the generate command has been run once. Just create the file in this location as you normally would. Include a link to page2/page2.html. ( For instance: `<a href="page2/page2.html">Page 2</a>`)

```
# This will copy the file from the scaffolding
cookbook_file '/var/www/html/index.html' do
  source 'index.html'
end

# Create a directory
directory '/var/www/html/page2'

# This will simply create a blank file with content
file '/var/www/html/page2/page2.html' do
  content '<html>This is page 2<html>'
end
```

Unit and Integration Tests: ChefSpec is used for unit testing and InSpec is used for Integration Testing. From the command line of the Chef Wrokstation:
* ChefSpec: `chef exec rspec`
* InSpec: `kitchen verify`
```
# ChefSpec
it 'creates a directory' do
  expect(chef_run).to create_directory('/var/www/html/page2')
end

it 'creates the file index.html' do
  expect(chef_run).to create_file('/var/www/html/index.html')
end

it 'creates the file page2.html' do
  expect(chef_run).to create_file('/var/www/html/page2/page2.html')
end

# InSpec
describe directory('/var/www/html/page2') do
  it { should exist }
end

describe file('/var/www/html/index.html') do
  it { should exist }
end

describe file('/var/www/html/page2/page2.html') do
  it { should exist }
end
```

## Building out a template web page with Ohai data on an Ubuntu server
Attributes were used in a simple wrappered cookbook to determine the behavior of that cookbook. In addition to setting arbitrary attributes, chef uses Ohai/Fauxhai to generate automatic attributes containing values that describe the system. These values can be plugged into a template. The example may make this clearer. Start by building the templates scaffolding just like the files:

`chef generate template server-info.html`

Edit the file templates\server-info.html.erb to look something like:
```
<html>
  <head>
    <meta content="text/html; charset=windows-1252" http-equiv="content-type">
  </head>
  <body>
    <h2>Server Properties</h2>
    <br>
    <table border="1" width="60%">
      <tbody>
        <tr>
          <td>Platform</td>
          <td><%= node['platform'] %></td>
        </tr>
        <tr>
          <td>Platform Version</td>
          <td><%= node['platform_version'] %></td>
        </tr>
        <tr>
          <td>Platform Family</td>
          <td><%= node['platform_family'] %></td>
        </tr>
        <tr>
          <td>IP Address</td>
          <td><%= node['ipaddress'] %></td>
        </tr>
      </tbody>
    </table>
  </body>
</html>
```

Add to the recipe\default.rb
```
template '/var/www/html/server-info.html' do # ~FC033
  source 'server-info.html.erb'
end
```

## Simplest possible file example on CentOS
```
ChefSpec Test:
  it 'creates a file with the default action' do
      expect(chef_run).to create_file('/tmp/default_action')
  end

InSpec Test:
describe file('/tmp/default_action') do
  it { should exist }
end

Recipe:
  file '/tmp/default_action'
```

## Simple Example Windows Directory
```
ChefSpec Test:
  it 'creates a directory with an explicit action' do
    expect(chef_run).to create_directory('C:\scripts')
  end

InSpec Test:
describe directory('C:\scripts') do
  it { should exist }
end

Recipe:
  directory 'C:\scripts'
```

## Simple Example Windows File
```
ChefSpec Test:
  it 'creates a file with the default action' do
      expect(chef_run).to create_file('C:\scripts\script.ps1')
  end

InSpec Test:
describe file('C:\TestFile.txt') do
  it { should exist }
end

Recipe:
file 'C:\TestFile.txt'
```

## Cookbook_File example (Windows)
```
ChefSpec:  Appears to be identical to 'file' resource??

InSpec:  identical to 'file' resource?

Recipe:
cookbook_file 'c:\SourceSoftware\Win8.1AndW2K12R2-KB3191564-x64.msu' do
	source 'Win8.1AndW2K12R2-KB3191564-x64.msu'
end
```

## Permissions
```
# Set Permissions
directory 'c:\inetpub\wwwroot' do
  rights :read, 'IIS_IUSRS'
  recursive true
  action :create
end
```