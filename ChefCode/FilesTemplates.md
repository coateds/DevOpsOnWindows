# Chef Files/Templates Test and Resource Code

`chef generate file default`

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