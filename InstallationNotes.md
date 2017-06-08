# Installing the DevOps Software
This document attempts to describe the installation and customization procedure for a Windows DevOps workstation. In short, this amounts to using PowerShell to interact with repositories. This can be as a consumer using NuGet to install modules from the PS Gallary and others, or in contributing to Git repositories both public and private.

In the lab in which I have been working, I have an easily spun up image of Server 2012R2 using Chef on HyperV. This document goes through the process of upgrading PowerShell and installing Git and Visual Studio Code. Other installations will/could include ChefDK and Pester.

## Yet another better install sequence

Install Chocolately and latest Powershell WMF (5.1)
* iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
* choco install powershell -y
* No user interaction involved in this potential block of code

Install Software
* choco install git -y -params '"/GitAndUnixToolsOnPath"'
* choco install visualstudiocode -y
* Restart-Computer
* choco install chefdk -y

Install PS Modules from PSGallery using NuGet
* Install-PackageProvider -Name "Nuget" -Force
* Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
* find-module posh-git | install-module
* find-module pester | install-module
* find-module ChocolateyGet | install-module (I do not know what this gains me)

Script:
```
# Install Chocolately and latest Powershell WMF (5.1)
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
## Chocolatey
It is now possible to use Chocolatey to install the latest version of PowerShell, so we will start there. At this time, the latest version seems to be 5.1

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

## Git
Git has become the heart of DevOps in so many ways. The fact that a default generated cookbook in Chef includes a local Git repository gives a great clue as to where things are going in DevOps. This Git installation also includes a number of great tools, starting with SSH.

There are some options that can be invoked at the Choco command line. I am choosing to add the UNIX toolsets to the path statement. I have read this to be a strong recommendation if using ChefDK. Of course, this path statement can be adjusted later as required

By default, the install on Windows will configure "core.autocrlf = true". Without this, there might be linefeed mismatches between files created in Windows or Linux but opened on the other. One of the only examples of this I have been able to replicate is to:
1. Create a remote repo and connect to it via Windows and Linux.
2. In the Windows local config set AutoCrLf to false.  git config --local core.autocrlf "false"
3. Create a text file on Linux with multiple lines, commit and push to remote repo
4. On Windows, pull from the repo and open the file from Notepad. The contents will all appear on one line.

A good editor will not have this problem. If you have a favorite editor and you expect to be sharing text files between Windows and Linux, now would be a good time to decide if the AutoCrLf needs to be set in any particular way. I will be demonstrating the use of Visual Studio Code in this document and there seems to be no issues with it so I will be leaving this setting at the default.

## Visual Studio Code
There are (at least) 3 criteria to use when deciding on an editor. Of course, if you have a favorite, by all means use it if it will work in your situation, but it is worth evaulating your editor on these points:
1. Linux/Windows file compatibility as discussed in the Git section above
2. Colorization of scripts, will it handle all the file types such as Bash, PowerShell and Ruby
3. Markdown files, this is the documentation format in remote repositories and if you are new to this format, an editor that interprest them well is indespensible.

VSCode is highly customizable asnd plays well with Linux files as well as git. Start by adding extensions for your script types like the one for PowerShell. Extensions for Bash, Ruby and Rubocop are also available.

For markdown files use the "Open Preview to the Side" feature to open a split screen of source text and interpreted display.

* Customize Short-cut keys
	1. From the Command Pallette (View menu)  F1
	2. Preferences: Open Keyboard Shortcuts File
	3. Change/add to keybindings.json

	[
		{"key": "shift+alt+down",
		"command": "editor.action.insertCursorBelow"},

		{"key": "shift+alt+up",
		"command": "editor.action.insertCursorAbove"}
	]

Now Shift+Alt+Up/Down works like PS ISE to allow multiline editing.
Most useful to comment/un-comment consecutive lines of code.

Customize terminal to PowerShell
	1. From the Command Pallette (View menu)
	2. Preferences: Open User Settings
	3. Change/add to settings.json

	{
		"terminal.integrated.shell.windows":
		"C:\\WINDOWS\\sysnative\\WindowsPowerShell\\v1.0\\powershell.exe"
	}

Edit Shortcuts to "Run as Administrator"

## PowerShell Modules from PSGallery
* Set-PSRepository is somewhat untested

For now, Pester is beyond the scope of this document. I am working on integrating this with my Chef/HyperV installation, but it is slow going.

The posh-git module will need some configuring. This module can be found in the GitHub site for its author, Keith Dahlby. Check out the README.md file for instructions. https://github.com/dahlbyk/posh-git. Upon installation, calls to it from the profile can be used to modify the PS prompt whenever the current directory is inside a local Git repository. These customizations are listed later after more software has been installed.

## SSH (Setup encrypted access to a Repository)
At a minimum, SSH can and should be used for secure/passwordless access to remote Git repositories. Since the software for setting it up is installed with Git, now would be a good time to generate some keys.
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
* Extra options: File System Caching and Git Cred Mngr - Y, Symbolic links - N

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
	# ttp://mikefrobbins.com/2016/02/09/configuring-the-powershell-ise-for-use-with-git-and-ithub/
	# . 'C:\Program Files\WindowsPowerShell\Modules\posh-git\0.7.0\MikeRobbins.ps1'

## Older information for installing NuGet

Install PowerShellGet  (PackageManagement_x64.msi)
	C:\Users\Administrator\Documents\PowerShellDownloads
	PowerShell Gallary

NuGet provider -  Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
-OR-
Go to the PowerShellGet Module in the right pane of the ISE, Select Find-Module, Show Details and click run in lower right. (Need Internet connection)

Find-Module mva* | Install-Module

Repository Name = PSGallary
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
	1. View Extenstions
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

Use 'ContextEdit' on Server9 to experiment with file and context menu associations.

## Test-Kitchen
http://misheska.com/blog/2014/09/21/survey-of-test-kitchen-providers/

Install Diff