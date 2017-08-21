# Using Chef Server
I have installed one Chef Server on Ubuntu Server. This is Server6 in HyperV lab 1. It is my intention to install another very similar in HyperV lab 2.

My primary access point to this server was Server9, transferring this access to Server32.

```diff
-Will need to set up knife access.
```

## Connecting a Chef Workstation (ChefDK installed) to a Chef Server
* On Server9: ~/documents/chef
* knife.rb
    ```
    # See https://docs.getchef.com/config_rb_knife.html for more information on knife configuration options

    current_dir = File.dirname(__FILE__)
    log_level                :info
    log_location             STDOUT
    node_name                "coateds"
    client_key               "#{current_dir}/coateds.pem"
    chef_server_url          "https://server6.coatelab.com/organizations/coatelab"
    cookbook_path            ["#{current_dir}/../cookbooks"]
    knife[:editor] = "Notepad"
    ```
* To obtain knife.rb:
  * Logon to chef server (https://Server6.coatelab.com)
  * Administration
  *	Select relevant org
  * Generate Knife Config
  * Save in desired location
  * (C:\Users\administrator.COATELAB\Documents\chef)
  * Adjust as desired/required
* Obtain certs
  * Knife ssl fetch (creates trusted_certs dir)
  * Knife ssl check
* Copy coateds.pem file
* Test knife access: `knife node list`