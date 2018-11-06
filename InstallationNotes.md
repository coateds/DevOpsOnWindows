# Installing the DevOps Software
This document attempts to describe the installation and customization procedure for a Windows DevOps workstation. In short, this amounts to using PowerShell to interact with repositories. This can be as a consumer using NuGet to install modules from the PS Gallery and others, or in contributing to Git repositories both public and private.

In the lab in which I have been working, I have an easily spun up image of Server 2012R2 using Chef on HyperV. This document goes through the process of upgrading PowerShell and installing Git and Visual Studio Code. Other installations will/could include ChefDK and Pester.

In particular there are a lot of customizations to VSCode and some to PowerShell that are worth considering depending on your needs.

I am also interested in automation, first with Chef and ChefDK, but also with Jenkins

## Using Package Managers
I have been approaching this incorrectly to try and use Chocolatey as the primary package manager. In fact, I need to be thinking in terms of OneGet  --  The package manager manager. Or, "OneGet is a Manager of Package Managers". This means that Chocolatey can be a provider for OneGet

A Third try
* The first goal has to be PowerShell/WMF 5.1
* In the future, I may build this into the BaseBox
* For now, I will install Chocolatey and then PowerShell

Install Chocolatey
* `iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))`
* When this does not work (Exception calling "DownloadString" with "1" argument(s): "The underlying connection was closed: An unexpected error
occurred on a receive.")
  * curl chocolatey.org/install.ps1 -OutFile C:\Users\dcoate\Documents\install.ps1
  * (Alias to Invoke-WebRequest)
  * This will download the file to the location specified by outfile
* choco /?
  * list - lists remote or local packages
    * `choco list --local-only`
    * `choco list --source windowsfeatures`
  * search - searches remote or local packages (alias for list)
  * info - retrieves package information. Shorthand for choco search pkgname  --exact --verbose
  * install - installs packages from various sources
    * `choco install [pkgname] -y`
    * `choco install [gem] -source ruby`
    * `choco install [feature] -source windowsfeatures`
    * `choco install iis-webserverrole --source windowsfeatures`
    * other sources webpi, cygwin, python
  * pin - suppress upgrades for a package
  * outdated - retrieves packages that are outdated. Similar to upgrade all --noop
    * `choco outdated` to show which apps have updates available. It will also show the version of choco at the top of the list if it is the latest
  * upgrade - upgrades packages from various sources
    * `choco upgrade [pkgname] -y`
	* `choco upgrade all -y`
  * uninstall - uninstalls a package
    * `choco uninstall [pkgname] -y`
  * pack - packages up a nuspec to a compiled nupkg
  * push - pushes a compiled nupkg
  * new - generates files necessary for a chocolatey package from a template
  * sources - view and configure default sources (alias for source)
  * source - view and configure default sources
    * `choco source`
  * config - Retrieve and configure config file settings
  * feature - view and configure choco features
  * features - view and configure choco features (alias for feature)
  * apikey - retrieves or saves an apikey for a particular source
  * setapikey - retrieves or saves an apikey for a particular source (alias for  apikey)
  * unpackself - have chocolatey set it self up
  * version - [DEPRECATED] will be removed in v1 - use `choco outdated` or `cup  <pkg|all> -whatif` instead
  * update - [DEPRECATED] RESERVED for future use (you are looking for upgrade, these are not the droids you are looking for)

Chocolatey is effectively a front-end for NuGet (I am not sure of this anymore)and analogous to yum and apt-get in Linux. As long as there is an Internet connection, packages can be downloaded and installed with a single, script-able, command. It is possible for there to be multiple sources from which to install, but at this time the only source I am using is Chocolatey (https://chocolatey.org/api/v2/).

Install latest Powershell WMF (5.1)
* `choco install powershell -y`
* on Server 2012 R2, upgrade 4.0 to 5.1
* reboot required
* Get Current Version `$PSVersionTable.PSVersion`
* choco list gives version as 5.1.14409.20170510

***Reboot***

## Configure the Package Providers into OneGet

Get-PackageProvider (Base provider list on server 2012R2/WMF 5.1)
* msi
* msu
* PowerShellGet
* Programs

Chocolatey
* <a href="https://www.hanselman.com/blog/AptGetForWindowsOneGetAndChocolateyOnWindows10.aspx">Start with this doc</a>
* `Get-PackageProvider -name chocolatey -force`
* Get-PackageProvider now includes Chocolatey v2.8.5.130
* Set-PackageSource -Name Chocolatey -Trusted

NuGet
* `Install-PackageProvider -Name "NuGet" -Force`
* Get-PackageProvider now includes NuGet 2.8.5.208

Trust PSGallery
* `Set-PSRepository -Name PSGallery -InstallationPolicy Trusted`

Windows Update
* Install PSWindowsUpdate
* `Install-Module -name PSWindowsUpdate`
* <a href="https://www.petri.com/manage-windows-updates-with-powershell-module">PS Windows Update Instructions</a>
* `Add-WUServiceManager -ServiceID 7971f918-a847-4430-9279-4a52d1efe18d`
* ***Automation Alert: User action required on previous line***
* Install updates
* `Get-WUInstall –MicrosoftUpdate –AcceptAll –AutoReboot`

Query packages
* `Get-PackageSource` to query Sources/Providers
* `Get-Package | where {$_.ProviderName -ne "msu"}`

Git
* `choco install git -y -params '/GitAndUnixToolsOnPath'`
* `Install-Package -Name Git -Source Chocolatey`
* `Uninstall-Package -Name Git`

VSCode
* See UsingVSCode.md

Installation OneGet v Chocolatey  ---  I made one attempt to install Git with Parameters via OneGet (Install-Package) and could not get the syntax right. *(Will try this again later)* I then installed via OneGet without parameter and with source Chocolatey to observe the result. In Get-Package, the source was Chocolatey. From there I ran Uninstall-Package and installed again using Choco. This time Get-Package showed the ProviderName to be 'Programs'.

This appears to be unnecessary, but does give an example for registering a source in OneGet
* <a href="https://serverfault.com/questions/633576/how-do-you-manually-set-powershells-oneget-repository-source-to-chocolatey">Manually set Powershell OneGet repository source to Chocolatey?</a>


PowerShell Modules
* Typically get installed: C:\Program Files\WindowsPowerShell\Modules
* Modules already installed (at this location)at this point??
  * PackageManagement
  * PowerShellGet
  * PSWindowsUpdate

PSModule: Posh-Git
* `choco install poshgit -y`
* <a href="https://chocolatey.org/packages/poshgit">Posh-Git on Chocolatey"</a>
* <a href="https://github.com/dahlbyk/posh-git">Posh-Git on GitHub"</a>
* It failed to install it in the modules directory as indicated above
* Installs to c:\tools\poshgit\dahlbyk-posh-git-a4faccd\src
* No configuration is needed to use in console, but ISE profile needs to be set up
  * ISE profile not working??

First Integration test/configuration
* Set up a local repo Docs\GitRepositories\Test  -- git init
* Rt click Folder and open in VSCode
* ``Ctrl+` `` to open terminal
* Accept opportunity to customize
* Select PowerShell
* Change terminal from cmd.exe to powershell.exe (dropdown upper right of bottom pane)
* Prompt should change to (appended) '[master]'
* Type `git br[tab]` and it should complete to 'git branch'

More modules
* `find-module pester | install-module`
 (I do not know what this gains me)



PSModule: ChocolateyGet
* `find-module ChocolateyGet | install-module`
* ChocolateyGet provider allows to download packages from Chocolatey.org repository via OneGet
* unnecessary at this time?, but may be of interest later

Alternative
* PSModule: Pester
  * `choco install pester -y`
  * Installs to Module dir as desired

## Git Notes and possible customizations
Git has become the heart of DevOps in so many ways. The fact that a default generated cookbook in Chef includes a local Git repository gives a great clue as to where things are going in DevOps. This Git installation also includes a number of great tools, starting with SSH.

There are some options that can be invoked at the Choco command line. I am choosing to add the UNIX tool sets to the path statement. I have read this to be a strong recommendation if using ChefDK. Of course, this path statement can be adjusted later as required

By default, the install on Windows will configure "core.autocrlf = true". Without this, there might be linefeed mismatches between files created in Windows or Linux but opened on the other. One of the only examples of this I have been able to replicate is to:
1. Create a remote repo and connect to it via Windows and Linux.
2. In the Windows local config set AutoCrLf to false.  git config --local core.autocrlf "false"
3. Create a text file on Linux with multiple lines, commit and push to remote repo
4. On Windows, pull from the repo and open the file from Notepad. The contents will all appear on one line.

A good editor will not have this problem. If you have a favorite editor and you expect to be sharing text files between Windows and Linux, now would be a good time to decide if the AutoCrLf needs to be set in any particular way. I will be demonstrating the use of Visual Studio Code in this document and there seems to be no issues with it so I will be leaving this setting at the default.

## Visual Studio Code notes and possible configurations
There are (at least) 3 criteria to use when deciding on an editor. Of course, if you have a favorite, by all means use it if it will work in your situation, but it is worth evaluating your editor on these points:
1. Linux/Windows file compatibility as discussed in the Git section above
2. Colorization of scripts, will it handle all the file types such as Bash, PowerShell and Ruby
3. Markdown files, this is the documentation format in remote repositories and if you are new to this format, an editor that interprets them well is indispensible.

VSCode is highly customizable and plays well with Linux files as well as git. Start by adding extensions for your script types like the one for PowerShell. Extensions for Bash, Ruby and Rubocop are also available.

Edit Shortcuts to "Run as Administrator"

ChefDK  ---  not installed yet
* choco install chefdk -y



## Old Script:
```
# Install Chocolatey and latest Powershell WMF (5.1)
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco install powershell -y

# Install Software
choco install git -y -params '"/GitAndUnixToolsOnPath"'
choco install visualstudiocode -y
Restart-Computer

choco install chefdk -y
# Install PS Modules from PSGallery using NuGet
Install-PackageProvider -Name "Nuget" -Force
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
find-module posh-git | install-module
find-module pester | install-module
find-module ChocolateyGet | install-module

```





Most of this looks to be unnecessary when using Chocolatey. I will leave this here in case I have to install a module from the Gallery
* Install PS Modules from PSGallery using NuGet
* `Install-PackageProvider -Name "NuGet" -Force`
  * `Get-PackageProvider` for information
* `Set-PSRepository -Name PSGallery -InstallationPolicy Trusted`
  * `Get-PSRepository` for information
* `find-module posh-git | install-module`

Try another sequence
* install Git first
* `refreshenv`  --  this may have been the problem in the first place

Still no joy - for now copy c:\tools\poshgit\dahlbyk-posh-git-a4faccd\src to C:\Program Files\WindowsPowerShell\Modules\posh-git\0.7.1

Actually nothing needs to be done to get Posh-Git to work... however it is not installing in the Modules dir. In the short run this is not necessarily an issue, but it might be later. This issue raised on the Chocolatey page reference above.



```diff
-Checkout windows update powershell 'choco install pswindowsupdate'
-Or Chocolatey Windows Update 'choco install chocolatey-windowsupdate.extension'
-  Not a complete solution?
```



## Customize and Configure
Git
* ssh-keygen

Configure Posh-Git profiles

VSCode
* Extensions
  * PowerShell
  * Git History
* Customize Short-cut keys VSCode
* Customize terminal to PowerShell

# Explanations and Process Details


## PowerShell
PowerShell can be customized and configured to the be the main shell for DevOps on Windows, but first it must be upgraded to version (WMF) 5 or higher. Among other things, this is required to interact with and help install the NuGet package manager. So the first step is upgrade PowerShell from version 4 to 5 or higher. Then use find-module/install-module to install a PowerShell/Git customization module. During this installation, NuGet will get fully installed.

Current Version
* $PSVersionTable.PSVersion
* Major Version 4 comes with default installation of Server 2012R2 --> 5 after WMF5

WMF 5
* Downloads:  Win8.1AndW2K12R2-KB3134758-x64.msu
* Not required on laptop after Win10 update
* Is still required for W2K12R2

WMF 5.1
* Downloads:  Win8.1AndW2K12R2-KB3191564-x64.msu





## PowerShell Modules from PSGallery
* Set-PSRepository is somewhat untested

For now, Pester is beyond the scope of this document. I am working on integrating this with my Chef/HyperV installation, but it is slow going.

The posh-git module will need some configuring. This module can be found in the GitHub site for its author, Keith Dahlby. Check out the README.md file for instructions. https://github.com/dahlbyk/posh-git. Upon installation, calls to it from the profile can be used to modify the PS prompt whenever the current directory is inside a local Git repository. These customizations are listed later after more software has been installed.

## SSH (Setup encrypted access to a Repository)
At a minimum, SSH can and should be used for secure/password-less access to remote Git repositories. Since the software for setting it up is installed with Git, now would be a good time to generate some keys.
* cd ~ (if necessary)
* ssh-keygen (accept defaults, blank passphrase as appropriate)
* Copy contents of ~/.ssh/id_rsa.pub
* to be used in Git Profiles and other services using ssh key exchange for authentication

## Configure Posh-Git
```diff
- posh-git at v7.1 there may be differences worth investigation
```
Create/Copy files in C:\Users\dcoate\Documents\WindowsPowerShell
* Microsoft.PowerShell_profile.ps1
* Microsoft.PowerShellISE_profile.ps1
* Contents for both: . 'C:\Program Files\WindowsPowerShell\Modules\posh-git\0.7.1\profile.example.ps1'

#Detritus
This is older information and processes
## Git Detritus
Downloads:
* Git-2.12.0-64-bit.exe
* Git-2.13.0-64-bit.exe

Installation Dialog boxes
* Adjusting your PATH environment:
  If this is to be a ChefDK box, choose to Use Git and optional Unix tools.
  Otherwise, Use Git from the Windows Command Prompt.
* (SSL) Use native Win Secure, not OpenSSL
* Line ending conversions: Checkout Windows, commit Unix
* Term emulator: Windows default console
* Extra options: File System Caching and Git Cred Manager - Y, Symbolic links - N

Utilities included with Git
* ssh, curl, bash

## Visual Studio Code
Downloads:  VSCodeSetup-1.10.2.exe

## Old info for ssh keys
Look in ~\.ssh for existing keys

Generating a new SSH key and adding it to the ssh-agent.
https://help.github.com/enterprise/2.6/user/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/
An SSH key will be required for each computer that is connecting to the secure repository.
It is not necessary to start the ssh-agent??

Move on to Adding a new SSH key to your GitHub account
https://help.github.com/enterprise/2.6/user/articles/adding-a-new-ssh-key-to-your-github-account/

Testing your SSH connection
ssh -T git@hostname
(ssh -T git@ewegithub.sb.karmalab.net)
	Answer yes to questions
	This step adds the known_hosts file

To clone an encrypted Repo:
	git clone git@ewegithub.sb.karmalab.net:dcoate/DCoateRepository.git
	In GitHub for the repo to clone, choose the clone URL (Https/SSL or SSH)

mkdir ~\documents\GitRepositories

## ChefDK
Downloads:  chefdk-1.2.22-1-x86.msi


Chef home directory. I have been using ~/documents/chef because this puts it in backup.
```diff
- If corporate backup can be adjusted to include ~/chef, that would be more convenient
```

URL to Chef Server
Lab:  server6.coatelab.com

mkdir ~\documents\chef

In enterprise Chef installations, knife.rb and username.pem need to be placed in the Chef home directory. It seems to be possible to copy these files from a backup location and knife commands will work.

knife ssl fetch
Adding certificate for server6_coatelab_com in c:\users\administrator.coatelab\documents\chef\trusted_certs/server6_coatelab_com.crt

mkdir ~\documents\cookbooks  (path in knife.rb)

knife cookbook download [cookbook name on server] -d C:\Users\Administrator.COATELAB\Documents\Cookbooks

## Posh-Git
The source for Posh-Git is https://github.com/dahlbyk/posh-git

There are a number of possible prerequisites for installations

* WMF 5
  Downloads:  Win8.1AndW2K12R2-KB3134758-x64.msu
  Not required on laptop after Win10 update
  Is still required for W2K12R2

* NuGet provider
  Enter 'find-module' in PowerShell console
    If installed,  a list of available modules will be returned
	If not installed, an error will be returned and an opportunity to install and import the NuGet provider will be presented
	Or install the NuGet provider by running 'Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force'

Finally enter command

	Install-Module posh-git

Return may be a warning about installing the modules from an untrusted repository.
Posh-Git is installed to:   C:\Program Files\WindowsPowerShell\Modules\posh-git\0.7.0
PS Modules at this point should include:
  * PackageManagement
  * posh-git
  * PowerShellGet

Create profiles to run the Posh-Git
	Copy file profile.example.ps1 to C:\Program Files\WindowsPowerShell\Modules\posh-git\0.7.0
	Also copy MikeRobbins.ps1



Contents:

	New-PSDrive –Name “U” –PSProvider FileSystem –Root “\\exp-ufs-01\USERS\dcoate” –Persist
	# Load posh-git example profile
	. 'C:\Program Files\WindowsPowerShell\Modules\posh-git\0.7.0\profile.example.ps1'
	# Or load Mike Robbins Example
	# http://mikefrobbins.com/2016/02/09/configuring-the-powershell-ise-for-use-with-git-and-github/
	# . 'C:\Program Files\WindowsPowerShell\Modules\posh-git\0.7.0\MikeRobbins.ps1'

## Older information for installing NuGet

Install PowerShellGet  (PackageManagement_x64.msi)
	C:\Users\Administrator\Documents\PowerShellDownloads
	PowerShell Gallery

NuGet provider -  Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
-OR-
Go to the PowerShellGet Module in the right pane of the ISE, Select Find-Module, Show Details and click run in lower right. (Need Internet connection)

Find-Module mva* | Install-Module

Repository Name = PSGallery
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted


## Visual Studio Code
Downloads:  VSCodeSetup-1.10.2.exe

Select All Additional Tasks
Edit Shortcuts to "Run as Administrator"

Resources
* https://blogs.technet.microsoft.com/heyscriptingguy/2016/12/05/get-started-with-powershell-development-in-visual-studio-code/
* https://blogs.technet.microsoft.com/heyscriptingguy/2017/01/11/visual-studio-code-editing-features-for-powershell-development-part-1/
* https://blogs.technet.microsoft.com/heyscriptingguy/2017/01/12/visual-studio-code-editing-features-for-powershell-development-part-2/

```diff
-Start looking at PowerShell debugging features in VS Code
```
https://blogs.technet.microsoft.com/heyscriptingguy/2017/02/06/debugging-powershell-script-in-visual-studio-code-part-1/

Notes
* vscode-powershell, VSC extension
* Install the PowerShell extension
	1. View Extensions
	2. Put 'PowerShell' in the search box
	3. Look for entry that reads "Develop PowerShell scripts..." (Should be top entry)
	4. Install
	5. Reload
* Customize VSCode
	1. From the Command Pallette (View menu)
	2. Type user
	3. Select Preferences: Open User Settings
	4. Ref: https://blogs.technet.microsoft.com/heyscriptingguy/2016/12/05/get-started-with-powershell-development-in-visual-studio-code/

Setting.json
	{

		"editor.wordWrap": true

		"editor.rulers": [ 120 ],

		"files.trimTrailingWhitespace": true,

		"terminal.integrated.shell.windows":
		"C:\\WINDOWS\\sysnative\\WindowsPowerShell\\v1.0\\powershell.exe"

	}



Customize terminal to PowerShell
https://code.visualstudio.com/docs/editor/integrated-terminal

VSCode Customize terminal to PowerShell. Now do through "wizard"
	1. From the Command Pallette (View menu)
	2. Preferences: Open User Settings
	3. Change/add to settings.json

	{
		"terminal.integrated.shell.windows":
		"C:\\WINDOWS\\sysnative\\WindowsPowerShell\\v1.0\\powershell.exe"
	}

Use 'ContextEdit' on Server9 to experiment with file and context menu associations.

## Test-Kitchen
http://misheska.com/blog/2014/09/21/survey-of-test-kitchen-providers/

Install Diff

## Python
* iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
* curl chocolatey.org/install.ps1 -OutFile C:\Users\dcoate\Documents\install.ps1
* PS C:\Users\dcoate\Documents> ./install.ps1
* choco install git -y
* choco install vscode -y
* choco install python
* pip install virtualenv
* virtualenv [appname]  from venvs dir
* .\venvs\alieninvasion\Scripts\activate  (powershell)