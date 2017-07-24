# BoxStarter
This software is designed to assist with the installation of new computers including multiple reboots.

http://boxstarter.org/

## Installation/Setup
* Note: This installs to the user, not the system
* `choco install boxstarter`
* Simple test install and first run on a HyperV Guest
* Gist File: BoxStarter1.txt
* Raw:  https://gist.githubusercontent.com/coateds/19ab02b4bec5c287a136bc236186a9d0/raw/968d72032a72c478fd09041a86177979023542bc/BoxStarter1.txt
* `Install-BoxstarterPackage -PackageName https://gist.githubusercontent.com/coateds/19ab02b4bec5c287a136bc236186a9d0/raw/968d72032a72c478fd09041a86177979023542bc/BoxStarter1.txt -DisableReboots`

```
Set-ExplorerOptions -showHiddenFilesFoldersDrives -showProtectedOSFiles -showFileExtensions
Enable-RemoteDesktop

choco install visualstudiocode
choco install poshgit
```

This mostly worked as expected. Chocolatey on the test box is not registering that any choco poackages have been installed. No explanation at this time.

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