# PowerShell Resource Examples
To begin with, these are just a series of examples from some past work I have done:
```
powershell_script 'make_test_file' do
    guard_interpreter :powershell_script
    code 'New-Item -Type File -Path c:/scripts/cheftestfile.txt'
    not_if 'test-path c:/scripts/cheftestfile.txt'
end

powershell_script 'set_dns' do
    code <<-EOH
    Set-InternalDNS '192.168.0.110,192.168.0.101'
    EOH
end
```

WARNING, this is only a partial solution to the configure RDP FW Rule
```
script =<<-EOF
    $RDFwRuleEnabled = $true
    ForEach ($Item in Get-NetFirewallRule -DisplayGroup "Remote Desktop"){If ($Item.Enabled -eq "False") {$RDFwRuleEnabled = $false}}
    return $RDFwRuleEnabled
  EOF

cmd = powershell_out(script)
puts "FW Rule Enabled #{cmd.stdout.chop}"

# This is very cool!!
# The script above will return false if the FW Rule is not set
# In which case the code below will get executed
# In other words the FWRule gets enabled if it is not already enabled
# ... if it is alreay enabled, it does nothing
powershell_script 'Enable_FW_Rule' do
  guard_interpreter :powershell_script
  code 'Enable-NetFirewallRule -DisplayGroup "Remote Desktop"'
  not_if script
end
```

Two ways to work the configure RDP FW Rule -- Ruby code logic
```
### attribute
default['my_windows_rdp']['ConfigureFirewall']  = 'True'

### recipe
fw_enabled_script =<<-EOH
  $RDFwRuleEnabled = $true
  ForEach ($Item in Get-NetFirewallRule -DisplayGroup "Remote Desktop"){If ($Item.Enabled -eq "False") {$RDFwRuleEnabled = $false}}
  return $RDFwRuleEnabled
EOH

cmd = powershell_out(fw_enabled_script)
FWEnabled =  "#{cmd.stdout.chop}"
FWShouldBeEnabled = "#{node['my_windows_rdp']['ConfigureFirewall']}"

if FWEnabled == 'True' and FWShouldBeEnabled == 'True'
  # puts "FW rule should be and is enabled. No Action"
elsif FWEnabled == 'False' and FWShouldBeEnabled == 'True'
  # puts "FW rule should be enabled, and is not. Enable it"
  powershell_script 'Enable FW Rule' do
    code 'Enable-NetFirewallRule -DisplayGroup "Remote Desktop"'
  end
elsif FWEnabled == 'False' and FWShouldBeEnabled == 'False'
  # puts "FW rule should NOT be enabled, and is not. No Action"
elsif FWEnabled == 'True' and FWShouldBeEnabled == 'False'
  # puts "FW rule should NOT be enabled, and is. Disable it"
  powershell_script 'Enable FW Rule' do
    code 'Disable-NetFirewallRule -DisplayGroup "Remote Desktop"'
  end
end
```

Logic in PowerShell Guards
```
node.default['MyCookbook']['ShouldEnable'] = 'no'

powershell_script 'Enable Firewall Rule (Allow RDP)' do
  code 'Enable-NetFirewallRule -DisplayGroup "Remote Desktop"'
  only_if <<-TESTSCRIPT
    # Get the Should Configure from Attributes and convert to boolean
    if ('#{node['MyCookbook']['ShouldEnable']}' -eq 'yes') {$ShouldEnable=$true}
    else {$ShouldEnable=$false}

    # some other powershell to determine if it is configured and return a boolean
    $IsConfigured = $true
    ForEach ($Item in Get-NetFirewallRule -DisplayGroup "Remote Desktop"){If ($Item.Enabled -eq "False") {$IsConfigured = $false}}

    # If it should, but is is not, do...
    # Guard returns true and the code is executed
    ($ShouldEnable -and !($IsConfigured))
  TESTSCRIPT
end

powershell_script 'Disable Firewall Rule (Do Not Allow RDP)' do
  code 'Disable-NetFirewallRule -DisplayGroup "Remote Desktop"'
  only_if <<-TESTSCRIPT
    # Get the Should Configure from Attributes and convert to boolean
    if ('#{node['MyCookbook']['ShouldEnable']}' -eq 'yes') {$ShouldEnable=$true}
    else {$ShouldEnable=$false}

    # some other powershell to determine if it is configured and return a boolean
    $IsConfigured = $true
    ForEach ($Item in Get-NetFirewallRule -DisplayGroup "Remote Desktop"){If ($Item.Enabled -eq "False") {$IsConfigured = $false}}

    # If it should, but is is not, do...
    # Guard returns true and the code is executed
    (!($ShouldEnable) -and $IsConfigured)
  TESTSCRIPT
end
```