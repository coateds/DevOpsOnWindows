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
<font color=red>Still have to recover and configure SSH for connecting to EWE</font>

## ChefDK
Downloads:  chefdk-1.2.22-1-x86.msi

Copied \documents\chef from recovered files and connection to Expedia Chef via Knife seems to work

Use Chef from:  C:\Users\dcoate\documents\chef>



## Unformatted stuff
Posh-Git
Enter 'find-module' in PowerShell and get:
NuGet provider is required to continue
PowerShellGet requires NuGet provider version '2.8.5.201' or newer to interact with NuGet-based repositories. The NuGet
 provider must be available in 'C:\Program Files\PackageManagement\ProviderAssemblies' or
'C:\Users\dcoate\AppData\Local\PackageManagement\ProviderAssemblies'. You can also install the NuGet provider by
running 'Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force'. Do you want PowerShellGet to install
and import the NuGet provider now?
[Y] Yes  [N] No  [S] Suspend  [?] Help (default is "Y"):

***  Not needed for new laptop ***
Install WMF 5
Downloads:  Win8.1AndW2K12R2-KB3134758-x64.msu
Not required on laptop after Win10 update??
******************************

install-module posh-git  (This is coming from: https://github.com/dahlbyk/posh-git??)
Untrusted repository
You are installing the modules from an untrusted repository. If you trust this repository, change its
InstallationPolicy value by running the Set-PSRepository cmdlet. Are you sure you want to install the modules from
'PSGallery'?
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "N"):

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



Visual Studio Code
	Downloads:  VSCodeSetup-1.9.1.exe

Test-Kitchen
http://misheska.com/blog/2014/09/21/survey-of-test-kitchen-providers/