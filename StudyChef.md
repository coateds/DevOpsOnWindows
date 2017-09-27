## Kitchen
* Kitchen by default uses a vagrant driver

## Attributes
* attributes/default.rb is always loaded first, after which lexical sorting is applied to any other attribute file names.

## Rubocop, Foodcritic
* `rubocop --auto-gen-config` will create the todo file, you then need to inherit_from the todo file within the .rubocop.yml file.
* `foodcritic ./ -t ~FC011` will exclude FC011 rule

## Berks/Supermarket/vendoring
* The Berksfile can allow you to specify the path to a local cookbook to override the default behavior of obtaining the cookbook from the supermarket.
* "knife cookbook site show java" will list available versions on the supermarket of java to install.
* In order to vendor the "tar" cookbook into your cookbooks directory, which steps would you perform?
  * Run "knife cookbook site download tar" and if the cookbook's directory is a git repository then run "knife cookbook site install tar"
  * knife cookbook site download tar will download the latest available version. If the cookbooks directory is a git repository then the knife cookbook site install tar command will install it, vendoring the tar cookbook

## kitchen.yml
* The `require_chef_omnibus` setting in the provisioner section can be specified with the version of chef-client you wish to install.

## Resources/Libraries
* You cannot by default use DSL resources in a Library.