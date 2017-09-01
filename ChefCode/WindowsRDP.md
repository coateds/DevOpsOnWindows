# Windows RDP

Sources:
* https://supermarket.chef.io/cookbooks/windows_rdp
* https://github.com/jrnker/windows_rdp

Metadata.rb
```diff
-depends 'windows_rdp', '>= 0.1.0'
```

Recipes\Default.rb
```diff
-include_recipe 'windows_rdp'
```

attributes/default.rb

`chef generate attribute default`
```diff
-override['windows_rdp']['Configure']          = true
-override['windows_rdp']['AllowConnections']   = 'yes'
-override['windows_rdp']['AllowOnlyNLA']       = 'yes'
-override['windows_rdp']['ConfigureFirewall']  = 'yes'
```

berksfile
```diff
-cookbook "windows_rdp", "~> 0.1.2", git: "https://github.com/coateds/windows_rdp.git", ref: "182a75894087584f266c7f0d784ccc3cabb48764"
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
	# Mixlib::ShellOut.new('netsh advfirewall firewall set rule group="remote esktop" new enable=Yes')
	powershell_script 'enable_fw' do
		code <<-EOH
		Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
		EOH
	end
end
if ConfigureFirewall == 'no' && fwRuleActive == true
	puts "Disabling firewall RDP connections"
	# Chef::Log.info("Disabling firewall RDP connections")
	# Mixlib::ShellOut.new('netsh advfirewall firewall set rule group="remote esktop" new enable=No')
	powershell_script 'enable_fw' do
		code <<-EOH
		Disable-NetFirewallRule -DisplayGroup "Remote Desktop"
		EOH
	end
end
```

## Solutions for using the modified cookbook
My first inclination was to modify the cached copy of the cookbook. Use `berks show windows_rdp` to get the path of the cache. Changes to the files in this location are immediately available to the test kitchen instance for testing.

When I asked a question on Linux Academy for a more proper solution, it was suggested that I fork the original project and reference the forked version directly out of git.

So I went to the original project in git. (See link at the top of this page) When I clicked the fork button, it created a copy in my Github account:  https://github.com/coateds/windows_rdp. Then I can reference this version in my berks file with `cookbook "windows_rdp", "~> 0.1.1", git: "https://github.com/coateds/windows_rdp.git"`

kitchen converge created the folder  C:\Users\dcoate\.berkshelf\.cache with a git repo in it??

I put in a '-' when it should have been a '_', but the end result seems to have worked. There is now a new version of the cookbook  `windows_rdp-c4ded5e3a9067af444d173792762b1dbd4170026` in the cache location.

Of course now the version in cache does not have my fixes in it so I should clone the forked cookbook so that I can introduce the changes to a local copy on my workstation. Then push the changes back to GitHub with a new version in metadata.rb.

After pushing the changes back to GitHub, updated the Berksfile to:
```cookbook "windows_rdp", "~> 0.1.2", git: "https://github.com/coateds/windows_rdp.git", ref: "182a75894087584f266c7f0d784ccc3cabb48764"``` where 182... is the Git revision that can be obtained with `git log`.

Finally, run `berks update windows_rdp` before running the kitchen converge