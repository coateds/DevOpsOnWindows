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
    "id": "12345678-abcd-abcd-abcd-123456abcdef",
    "isDefault": true,
    "name": "Coate Subscription",
    "state": "Enabled",
    "tenantId": "12345678-abcd-abcd-abcd-123456abcdef",
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
  subscription_id: 12345678-abcd-abcd-abcd-123456abcdef
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
  subscription_id: 12345678-abcd-abcd-abcd-123456abcdef
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

## SSH access to Linux VMs
* Reference:
  * https://docs.microsoft.com/en-us/azure/virtual-machines/linux/ssh-from-windows
  * https://docs.microsoft.com/en-us/azure/virtual-machines/linux/mac-create-ssh-keys
* Key Pairs
  * Every machine from which an SSH connection will be made must have a private key
  * Every client to which an SSH connection is made must have a matching public key in ~/.ssh/authorized_keys
* Public keys in ~/.ssh/authorized_keys (there can be many...)
  * This text document on each Linux machine has one line per key with three elements separated by a single space each:
    * 'ssh-rsa'  (no quotes)
    * a-big-ass-long-string-of-characters-no-line-breaks
    * a comment, perhaps with the name of the client or group of clients
  * This file is created when an Azure VM is built using SSH authentication. There is a place to paste in ONE!! public keys
    * Even if an attempt is made to copy more than one, only the first key is added to the authorized_keys file
    * It may be easier to create the VM with a Windows public key and then use a Linux utility to copy a publick key from another Linux box: `ssh-copy-id`

Proposed process for creating a Linux Azure VM and adding both a Windows SSH public key and a Linux SSH Public Key
* Start a new Virtual Machine
  * VM name - arbitrary
  * User name - *keep this name handy!*  (coateds)
  * Authentication type - SSH public key
  * SSH public key - [paste in the public key]
  * etc
* Connect via PuTTy
  * use the IP address from the portal
  * use the .ppk file for authentication
  * logon as coateds (or user entered in ne VM wiz)
  * add comment to public key in authorized_users
  * add other public keys as needed
* Generating public/private keys
  * Linux
    * `ssh-keygen`
    * by default creates `id_rsa` and `id_rsa.pub`
    * copy the contents of the .pub file for the public key and leave the other one alone
  * Windows/PuTTy is more work. A .ppk file must be created
    * The process given in the ref above seems way too complex and does not use `ssh-keygen`, yet I know that comes with Git  --Yes!
    * So can I use PuTTyGen to create a .ppk file from the output of `ssh-keygen`?  --Yes!
    * This process requires both Git (with UNIX tools in the path) and PuTTy be installed
    * Generate keys exactly as it is done in Linux (If they do not already exist)
    * run `puttygen.exe`, load the private key
    * Save the Private key as id_rsa.ppk

## Access to blob storage
* Chocolatey:  azcopy, azurestorageexplorer

## Creating a VM with Automation
AzureCli
* `az login`
* `az group create -n coatedsgroup -l westus` creates an empty resource group
  * (`az group -h`)
  * (Use this command to export templates)
* `az vm create --resource-group coatedsgroup --name coatedsubuntu --image Canonical:UbuntuServer:16.04-LTS:latest --admin-password P2ssw0rdD3lay! --admin-username coateds --authentication-type password`


## Storage
* install storage explorer, it integrates with the Portal  (??)  Will need the storage account name and key. Both available from the portal.
* Map a drive (SMB) from VM to Storage Account
  * Create a VM and Storage Account within the same Resource Group (This *should* put them both on the same internal network)
  * Within the StorAcct in the Portal, create a share in Files.
  * Use the connect button to retrieve a command that will map a drive on a windows VM in the same RG

Azure PowerShell
* `Find-Module AzureRM`
* `Install-Module AzureRM`

## When the Azure portal is inaccessible
* `az vm list -d --query "[?powerState=='VM running']" --output table` to see VMs that are running.

## Scripting an Azure build with module AzureRM
Function for building Ubuntu
```powershell
Function New-MyAzureVM ($loc, $name, $resGroup, $clientcred)
  {
  # Create the resource group (appears in the portal after this command)
  New-AzureRmResourceGroup -Name $resGroup -Location $loc

  # Create a subnet configuration
  $subnetConfig = New-AzureRmVirtualNetworkSubnetConfig -Name psLabSubnet -AddressPrefix 10.0.0.0/24

  # Create a virtual network (appears in the portal after this command)
  $vnet = New-AzureRmVirtualNetwork -ResourceGroupName $resGroup -Location $loc -Name psLabVNet -AddressPrefix 10.0.0.0/16 -Subnet $subnetConfig

  # Create a public IP address and specify a DNS name (appears in the portal after this command)
  $pip = New-AzureRmPublicIpAddress -ResourceGroupName $resGroup -Location $loc -Name "coatelab$(Get-Random)" -AllocationMethod Dynamic -IdleTimeoutInMinutes 4

  # Create an inbound network security group rule for port 22, 80 and 3389 so we can ssh, Web Browse and RDP to this machine
  $nsgRuleSSH = New-AzureRmNetworkSecurityRuleConfig -Name myNetworkSecurityGroupRuleSSH -Protocol Tcp -Direction Inbound -Priority 1000 -SourceAddressPrefix * -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 22 -Access Allow
  $nsgRuleWeb = New-AzureRmNetworkSecurityRuleConfig -Name myNetworkSecurityGroupRuleWeb -Protocol Tcp -Direction Inbound -Priority 100 -SourceAddressPrefix * -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 80 -Access Allow
  $nsgRuleRdp = New-AzureRmNetworkSecurityRuleConfig -Name myNetworkSecurityGroupRuleRdp -Protocol Tcp -Direction Inbound -Priority 101 -SourceAddressPrefix * -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 3389 -Access Allow

  # Create a network security group (appears in the portal after this command)
  $nsg = New-AzureRmNetworkSecurityGroup -ResourceGroupName $resGroup -Location $loc -Name psLabNSG -SecurityRules $nsgRuleSSH,$nsgRuleWeb,$nsgRuleRdp

  # Create a virtual network card and associate it with the public IP address and NSG (appears in the portal after this command)
  $nic = New-AzureRmNetworkInterface -Name psLabNIC -ResourceGroupName $resGroup -Location $loc -SubnetId $vnet.Subnets[0].Id -PublicIpAddressId $pip.Id -NetworkSecurityGroupId $nsg.Id

  # Create a virtual machine configuration
  $vmConfig = New-AzureRmVMConfig -VMName $name -VMSize Standard_A1 |
    Set-AzureRmVMOperatingSystem -Linux -ComputerName $name -Credential $clientcred |
    Set-AzureRmVMSourceImage -PublisherName Canonical -Offer UbuntuServer -Skus 16.04-LTS -Version latest |
    Set-AzureRmVMOSDisk -Name psLabOSDisk -DiskSizeInGB 128 -CreateOption FromImage -Caching ReadWrite -StorageAccountType StandardLRS |
    Add-AzureRmVMNetworkInterface -Id $nic.Id

  # Create the virtual machine
  # and the OSDisk
  # and the Storage Account
  New-AzureRmVM -ResourceGroupName $resGroup -Location $loc -VM $vmConfig

  # Get the PublicIP
  # install-module -name wftools  (one time install of module)
  (Get-AzureRmVmPublicIP -ResourceGroupName $resGroup | where {$_.VMName -eq $name}).PublicIP
  }
```

Must logon to Azure first
```powershell
# Log in to azure
# This command does not seem to work inside a script... Maybe it needs a sleep command??
# Add-AzureRmAccount
```

Example call of above function
```powershell
$resourceGroup = "psResourceGroup"

# Create login credentials for your VM
$securePassword = ConvertTo-SecureString 'H0rnyBunny' -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential ("coateds", $securePassword)

New-MyAzureVM "westus" "psLabVM" $resourceGroup $cred
```

Delete/remove ResourceGroup:  `Remove-AzureRmResourceGroup -Name $resourceGroup`

BootStrap:  `knife bootstrap '[IP Addr]' --ssh-user '[user]' --ssh-password '[pw]' --sudo --node-name node1-ubuntu --run-list 'role[ubuntuweb]' --json-attributes '{"cloud": {"Public_ip": "[name]"}}'` Command must be run from ChefDK window

Update to Function above to add firewall rules:
```powershell
  # Create an inbound network security group rule for port 22, 80 and 3389 so we can ssh, Web Browse and RDP to this machine
  $nsgRuleSSH = New-AzureRmNetworkSecurityRuleConfig -Name myNetworkSecurityGroupRuleSSH -Protocol Tcp -Direction Inbound -Priority 1000 -SourceAddressPrefix * -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 22 -Access Allow
  $nsgRuleWeb = New-AzureRmNetworkSecurityRuleConfig -Name myNetworkSecurityGroupRuleWeb -Protocol Tcp -Direction Inbound -Priority 100 -SourceAddressPrefix * -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 80 -Access Allow
  $nsgRuleRdp = New-AzureRmNetworkSecurityRuleConfig -Name myNetworkSecurityGroupRuleRdp -Protocol Tcp -Direction Inbound -Priority 101 -SourceAddressPrefix * -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 3389 -Access Allow

  # Create a network security group (appears in the portal after this command)
  $nsg = New-AzureRmNetworkSecurityGroup -ResourceGroupName $resGroup -Location $loc -Name psLabNSG -SecurityRules $nsgRuleSSH,$nsgRuleWeb,$nsgRuleRdp
  ```