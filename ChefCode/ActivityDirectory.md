https://supermarket.chef.io/cookbooks/windows_ad
https://github.com/TAMUArch/cookbook.windows_ad


Default.rb
```
# This will turn the local machine into a domain controller
# include_recipe 'windows_ad::default'


# Join expcoatelab.com domain
windows_ad_computer 'ServerX5' do
  action :join
  domain_pass 'H0rnyBunny'
  domain_user 'Administrator'
  domain_name 'expcoatelab.com'
  restart true
end
```

Meatadata.rb
```
depends 'windows_ad'
```