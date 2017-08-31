https://supermarket.chef.io/cookbooks/windows_rdp
https://github.com/jrnker/windows_rdp

Metadata.rb
```
depends 'windows_rdp', '>= 0.1.0'
```

Recipes\Default.rb
```
include_recipe "windows_rdp"
```

attributes/default.rb
```
override['windows_rdp']['Configure']          = true
override['windows_rdp']['AllowConnections']   = 'yes'
override['windows_rdp']['AllowOnlyNLA']       = 'yes'
override['windows_rdp']['ConfigureFirewall']  = 'yes'
```

Note: The cookbook on the Supermarket does not work. Here are some modifications that do work:

default.rb
```
	# Debug
		# puts "fwRuleActive: #{fwRuleActive}"
		# puts "ConfigureFirewall: #{ConfigureFirewall}"

	if ConfigureFirewall == 'yes' && fwRuleActive == false
		puts "Enabling firewall RDP connections"
		# Chef::Log.info("Enabling firewall RDP connections")
		# Mixlib::ShellOut.new('netsh advfirewall firewall set rule group="remote desktop" new enable=Yes')
		powershell_script 'enable_fw' do
			code <<-EOH
			Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
			EOH
		end
	end

	if ConfigureFirewall == 'no' && fwRuleActive == true
		puts "Disabling firewall RDP connections"
		# Chef::Log.info("Disabling firewall RDP connections")
		# Mixlib::ShellOut.new('netsh advfirewall firewall set rule group="remote desktop" new enable=No')
		powershell_script 'enable_fw' do
			code <<-EOH
			Disable-NetFirewallRule -DisplayGroup "Remote Desktop"
			EOH
		end
	end
```