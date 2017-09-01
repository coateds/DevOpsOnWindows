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