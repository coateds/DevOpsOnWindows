```
# Add IIS Feature
powershell_script 'Install IIS' do
  code 'Add-WindowsFeature Web-Server'
  guard_interpreter :powershell_script
  not_if '(Get-WindowsFeature -Name Web-Server).Installed'
end

# Start the IIS Service
service 'w3svc' do
  action [:enable, :start]
end

# Set Permissions
directory 'c:\inetpub\wwwroot' do
  rights :read, 'IIS_IUSRS'
  recursive true
  action :create
end
```