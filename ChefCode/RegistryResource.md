```
# This resource will set the registry, but does not produce the expected behavior
registry_key 'HKEY_LOCAL_MACHINE\Software\Microsoft\ServerManager' do
  values [{
    :name => 'DoNotOpenServerManagerAtLogon',
    :type => :dword,
    :data => 0
  }]
  action :create
end
```