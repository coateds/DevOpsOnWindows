# Using Azure

`chef gem install azure`  --  wrong
`chef gem install kitchen-azurerm`

## The Azure CLI
* This utility may turn out to be crucial
* https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest
* choco install azure-cli  (as of 9/19/17 installs v2.0.10. The latest version v2.0.17 is in moderation)
* choco upgrade azure-cli --version 2.0.17

## Set up the credential file:
* https://github.com/pendrica/azure-credentials (Author says this is old)
* Newer:  https://gist.github.com/binamov/57b187c77833d70e7928ecf56235d8df
* @stuartpreston on the #azure channel
* az login:
```
[
  {
    "cloudName": "AzureCloud",
    "id": "829eeca2-0445-402d-bf81-4d00f1093c64",
    "isDefault": true,
    "name": "Coate Subscription",
    "state": "Enabled",
    "tenantId": "94331f23-5693-4f7b-a776-be11eac6610b",
    "user": {
      "name": "coateds@outlook.com",
      "type": "user"
    }
  }
]
```

Create file ~\.azure\credentials
See file on exp scriptbox for example

.kitchen.yml
```
---
driver:
  name: azurerm

driver_config:
  subscription_id: 829eeca2-0445-402d-bf81-4d00f1093c64
  location: West US
  machine_size: Standard_D2

transport:
  ssh_key: ~/.ssh/id_kitchen-azurerm
  username: azure
  password: P2ssw0rd

provisioner:
  name: chef_zero

platforms:
  - name: ubuntu-14.04
    driver_config:
      image_urn: Canonical:UbuntuServer:14.04.4-LTS:latest
      vm_name: trusty-vm
      vm_tags:
        ostype: linux
        distro: ubuntu

suites:
  - name: default
    run_list:
      - recipe[azurex2::default]
    verifier:
      inspec_tests:
        - test/smoke/default
    attributes:

```

.kitchen.yml
```
---
driver:
  name: azurerm

driver_config:
  subscription_id: 829eeca2-0445-402d-bf81-4d00f1093c64
  location: West US
  machine_size: Standard_D2

provisioner:
  name: chef_zero

verifier:
  name: inspec

platforms:
  - name: windows2012-r2
    driver_config:
      image_urn: MicrosoftWindowsServer:WindowsServer:2012-R2-Datacenter:latest
    transport:
      name: winrm
      username: azure
      password: P2ssw0rd

suites:
  - name: default
    run_list:
      - recipe[AzureX1::default]
    verifier:
      inspec_tests:
        - test/smoke/default
    attributes:
```

`

## Azure Testing
Test Web Apps
* dcoatetest.azurewebsites.net
* dcoatetest1.azurewebsites.net

## Working processes for a simple static web site
Try this: https://docs.microsoft.com/en-us/azure/app-service-web/app-service-deploy-local-git
* This works!
* git remote add azure https://<username>@localgitdeployment.scm.azurewebsites.net:443/localgitdeployment.git
* git push azure master

Is it possible to do a git clone this way. The first time I tried this, it did not work, but the contents were empty
* https://coateds@dcoatetest.scm.azurewebsites.net:443/dcoatetest.git
* yes, it is possible to git clone, apparently there just needs to be some content.

So the Azure Website creation and connect to git process is just a bit different.
* Create the web site
  * portal.azure.com
  * New, Web + Mobile, Web App
  * Name it, subscription, Resource Group (been using Default-Networking), OS, App Svc Plan
    * Svc plan is where you select pricing plan
    * dcoate test is free West US, use that for now
  * Select Pin to Dashboard
  * Create
* Set up Deployment via Git
  * Click the web site on the dashboard
  * Deployment options
  * Configure required settings
  * Local Git Repository
  * OK
* Now when open the Web App from the Dashboard, there is a Git clone url
* Also note the Deployment credentials option
  * There is one deployment PW for Git/FTP deployments for the subscription
* It does not seem to be possible to `git clone` a new, empty Azure Web App
  * Create a new Git repository with the same name as the web app
  * use `git init`
  * Create some content. (Index.html, for instance)
  * `git add` and `git commit`
  * in the properties of the Web App on the portal, locate the CloneURL
  * `git remote add origin [CloneURL]`
* This puts content into the web app and a normal git clone will work with the CloneURL

To reset the Deployment PW
* Install the Azure CLI (az cli)
  * install from https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest
  * azure-cli-2.0.17.msi
  * run from cmd (from PS too?)
  * `az login`
  * follow the prompts
* `az webapp deployment user set --user-name [your deployment user] --password [your new password]`

## Access to blob storage
* Chocolatey:  azcopy, azurestorageexplorer