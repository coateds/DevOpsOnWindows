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