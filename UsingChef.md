This is the ChefDocs Branch, OK to edit this here...

# Using Chef
For instructions to set up a test kitchen VM:
https://github.com/coateds/DevOpsOnWindows/blob/master/VagrantAndVirtualBox.md

Copy files/content from https://github.com/learningchef

## Cookbooks
* There are now two methods for generating a cookbook. Knife is the old way. Chef generate is preferred.
* chef generate cookbook motd  -- (message of the day)
  The motd folder is under git version control from the outset
* Edit the .kitchen.yml file as needed
* Use the chef generate tool to create more resources
  chef generate file motd  (a file resource)
    edit files/default/motd
    edit recipes/default.rb

## Performing a Converge
* This process: deploys a cookbook to a node and applies a run list
* From inside the motd directory:
  kitchen converge default-centos65
* converge will run kitchen create and kitche setup as needed
* The point of this exercise was to install a VM, Install the chef-client on that VM and then creating a file resource as defined in motd\files\recipes\default.rb
  The file itself can be found in motd\files\default