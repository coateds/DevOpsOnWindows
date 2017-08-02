# BoxStarter
This software is designed to assist with the installation of new computers including multiple reboots.

http://boxstarter.org/
https://github.com/mwrock/boxstarter

## Installation/Setup
* Note: This installs to the user, not the system
* `choco install boxstarter`

## Simple test install and first run on a HyperV Guest using Gist File
* Gist File: BoxStarter1.txt
* Raw:  https://gist.githubusercontent.com/coateds/19ab02b4bec5c287a136bc236186a9d0/raw/968d72032a72c478fd09041a86177979023542bc/BoxStarter1.txt
* `Install-BoxstarterPackage -PackageName https://gist.githubusercontent.com/coateds/19ab02b4bec5c287a136bc236186a9d0/raw/968d72032a72c478fd09041a86177979023542bc/BoxStarter1.txt -DisableReboots`
* Everytime the .txt file changes so does the URL... So the command must change

Install-BoxstarterPackage -PackageName https://gist.githubusercontent.com/coateds/19ab02b4bec5c287a136bc236186a9d0/raw/ea9a6db209616aa5c43295f026e0f077f6b817ce/BoxStarter1.txt -DisableReboots

```
Set-ExplorerOptions -showHiddenFilesFoldersDrives -showProtectedOSFiles -showFileExtensions
Enable-RemoteDesktop

choco install visualstudiocode
choco install poshgit
```

## Create a (.nupkg) file from script
* New-PackageFromScript -Source c:\scripts\BoxStarter1.txt -PackageName coateds.boxstarter1
* Source file should be .ps1 file??
* Dest:  [profile]\AppData\Roaming\Boxstarter\BuildPackages

## Edit package
* C:\Users\dcoate\AppData\Roaming\Boxstarter\BuildPackages\coateds.boxstarter1\tools\ChocolateyInstall.ps1
* Invoke-BoxstarterBuild coateds.boxstarter1

## Chocolatey Account
* choco apikey --key ca8460ce-75ed-4f79-9779-fc1c4f3cd841 --source https://push.chocolatey.org/
* CPUSH (Join-Path $Boxstarter.LocalRepo coateds.boxstarter1.1.0.0.nupkg)
* Goes into a to be moderated queue

## Install from a package
* $cred=Get-Credential domain\username
* Install-BoxstarterPackage -PackageName "MyPackage1","MyPackage2" -Credential $cred

## See packages
Get-ChildItem $Boxstarter.LocalRepo

## Patching
* This command *will* install the July '17 rollup patch
* `Install-WindowsUpdate -Criteria "UpdateID='cea5ebc9-b64f-4dc8-9694-4cb6e24b43ee' AND IsInstalled=0"`
* To get an update id, <a href="http://www.catalog.update.microsoft.com/Home.aspx">Microsoft Update Catalog</a>
* Search for the KB#
* Click the appropriate link
* The support link will include the UpdateID in the URL
* ---
* Try calling Enable-MicrosoftUpdate before

## Commands
PowerShell Modules (`Get-Module`)
* Boxstarter.Bootstrapper
* Boxstarter.Chocolatey
* BoxStarter.WinConfig

get-command -module Boxstarter.bootstrapper | select Name
* Enter-BoxstarterLogable
* Get-BoxstarterTempDir
* Invoke-BoxStarter
* Invoke-Reboot
* Start-TimedSection
* Stop-TimedSection
* Test-PendingReboot
* Write-BoxstarterMessage

get-command -module Boxstarter.chocolatey | select Name
* Enable-BoxstarterVM
* Install-ChocolateyInstallPackage
* Write-Host
* Enable-BoxstarterClientRemoting
* Enable-BoxstarterCredSSP
* Export-BoxstarterVars
* Get-BoxStarterConfig
* Get-PackageRoot
* Install-BoxstarterPackage
* Install-ChocolateyInstallPackageOverride
* Invoke-BoxStarterBuild
* Invoke-BoxstarterFromTask
* Invoke-Chocolatey
* Invoke-ChocolateyBoxstarter
* New-BoxstarterPackage
* New-PackageFromScript
* Resolve-VMPlugin
* Set-BoxStarterConfig
* Set-BoxstarterShare
* Write-HostOverride

get-command -module Boxstarter.winconfig | select Name
* Disable-BingSearch
* Disable-GameBarTips
* Disable-InternetExplorerESC
* Disable-MicrosoftUpdate
* Disable-UAC
* Enable-MicrosoftUpdate
* Enable-RemoteDesktop
* Enable-UAC
* Get-LibraryNames
* Get-UAC
* Install-WindowsUpdate
* Move-LibraryDirectory
* Set-CornerNavigationOptions
* Set-ExplorerOptions
* Set-StartScreenOptions
* Set-TaskbarOptions
* Set-TaskbarSmall
* Set-WindowsExplorerOptions
* Update-ExecutionPolicy

$Boxstarter.LocalRepo
* C:\Users\Administrator\AppData\Roaming\Boxstarter\BuildPackages

## New VM - Generation 2
* `Enable-PSRemoting -Force` Required on BaseBox vhdx
* Need to copy the .vhdx file first!!
* New-Item -Type Directory "D:\HyperVResources\VMs\NewPSBox"
* Set-Location "D:\HyperVResources\VMs\NewPSBox"
* Copy-Item -Path "D:\HyperVResources\VMs\BaseBox2\Virtual Hard Disks\BaseBox2.vhdx" -Destination "D:\HyperVResources\VMs\NewPSBox\NewPSBox.vhdx"
* `New-VM -Name "myVM" -MemoryStartupBytes 1GB -SwitchName ExternalSwitch -VHDPath "D:\HyperVResources\VMs\NewPSBox\NewPSBox.vhdx" -Generation 2`
* Start-VM "myVM"

```
# Scripted V1
$c = Get-Credential

$VMLocation = 'D:\HyperVResources\VMs'
$NewVMName = 'NewStBoxVM'

New-Item -Type Directory (Join-Path -Path $VMLocation -ChildPath $NewVMName)
Copy-Item -Path "D:\HyperVResources\VMs\BaseBox2\Virtual Hard Disks\BaseBox2.vhdx" -Destination "$VMLocation\$NewVMName\$NewVMName.vhdx"
New-VM -Name $NewVMName -MemoryStartupBytes 2GB -SwitchName ExternalSwitch -VHDPath "$VMLocation\$NewVMName\$NewVMName.vhdx" -Generation 2
Start-VM $NewVMName


Enable-BoxstarterVM -VMName $NewVMName -Credential $c | Install-BoxstarterPackage -PackageName coateds.boxstarter1
```
## Install remote package
* coateds.boxstarter1

## Current story/process
* Edit File - C:\Users\dcoate\AppData\Roaming\Boxstarter\BuildPackages\coateds.boxstarter1\tools\ChocolateyInstall.ps1
* Invoke-BoxstarterBuild coateds.boxstarter1
* Open BoxStarter Shell
* Run Script  c:\scripts\BuildVM.ps1

# Detritus

