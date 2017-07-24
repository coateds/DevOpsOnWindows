# BoxStarter
This software is designed to assist with the installation of new computers including multiple reboots.

http://boxstarter.org/

## Installation/Setup
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