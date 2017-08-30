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

Note: The default action of this recipe is to open firewall to private only?