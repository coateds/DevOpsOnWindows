# Installing the DevOps Software
PowerShell can be customized and configured to the be the main shell for DevOps on Windows.

## Git
Downloads: Git-2.11.1-64-bit.exe

Installation Dialog boxes
* Adjusting your PATH environment:  
  If this is to be a ChefDK box, choose to Use Git and optional Unix tools.  
  Otherwise, Use Git from the Windows Command Prompt.
* Line ending conversions: Checkout Windows, commit Unix
* Term emulator: Windows default console
* Extra options: File System Caching and Git Cred Mngr - Y, Symbolic links - N

Plain Git repos can be recovered directly and will work once git has been installed.  
```diff
- Still have to recover and configure SSH for connecting to EWE
```

## ChefDK
Downloads:  chefdk-1.2.22-1-x86.msi

Chef home directory. I have been using ~/documents/chef because this puts it in backup.  
```diff
- If corporate backup can be adjusted to include ~/chef, that would be more convenient
```

In enterprise Chef installations, knife.rb and username.pem need to be placed in the Chef home directory.  
It seems to be possible to copy these files from a backup location and knife commands will work.



## Posh-Git
The source for Posh-Git is https://github.com/dahlbyk/posh-git

There are a number of possible prerequisites for installations

* WMF 5
  Downloads:  Win8.1AndW2K12R2-KB3134758-x64.msu
  Not required on laptop after Win10 update??
* NuGet provider
  Enter 'find-module' in PowerShell console
    If installed,  a list of available modules will be returned
	If not installed, an error will be returned and an opportunity to install and import the NuGet provider will be presented
	Or install the NuGet provider by running 'Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force'

Finally enter command 

	Install-Module posh-git

Return may be a warning about installing the modules from an untrusted repository
  
Posh-Git is installed to:   C:\Program Files\WindowsPowerShell\Modules\posh-git\0.7.0

Create profiles to run the Posh-Git
	Copy file profile.example.ps1 to C:\Program Files\WindowsPowerShell\Modules\posh-git\0.7.0
	Also copy MikeRobbins.ps1
	
Create/Copy files in C:\Users\dcoate\Documents\WindowsPowerShell
	Microsoft.PowerShell_profile.ps1
	Microsoft.PowerShellISE_profile.ps1

	Contents:
		New-PSDrive –Name “U” –PSProvider FileSystem –Root “\\exp-ufs-01\USERS\dcoate” #–Persist
		
		# Load posh-git example profile
		. 'C:\Program Files\WindowsPowerShell\Modules\posh-git\0.7.0\profile.example.ps1'
		
		# Or load Mike Robbins Example
		# http://mikefrobbins.com/2016/02/09/configuring-the-powershell-ise-for-use-with-git-and-github/
		# . 'C:\Program Files\WindowsPowerShell\Modules\posh-git\0.7.0\MikeRobbins.ps1'



## Visual Studio Code
	Downloads:  VSCodeSetup-1.9.1.exe

## Test-Kitchen
http://misheska.com/blog/2014/09/21/survey-of-test-kitchen-providers/