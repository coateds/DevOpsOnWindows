# Installing the DevOps Software
PowerShell can be customized and configured to the be the main shell for DevOps on Windows.


## Git
Downloads: Git-2.12.0-64-bit.exe

Installation Dialog boxes
* Adjusting your PATH environment:
  If this is to be a ChefDK box, choose to Use Git and optional Unix tools.
  Otherwise, Use Git from the Windows Command Prompt.
* Line ending conversions: Checkout Windows, commit Unix
* Term emulator: Windows default console
* Extra options: File System Caching and Git Cred Mngr - Y, Symbolic links - N


Plain Git repos can be recovered directly and will work once git has been installed.
```diff
- Still have to recover and configure SSH for connecting to EWE - Done??
```

## Setup encrypted access to a Repository
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

Create/Copy files in C:\Users\dcoate\Documents\WindowsPowerShell  
  * Microsoft.PowerShell_profile.ps1  
  * Microsoft.PowerShellISE_profile.ps1  

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

* Customize Short-cut keys
	1. From the Command Pallette (View menu)
	2. Preferences: Open Keyboard Shortcuts
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
https://code.visualstudio.com/docs/editor/integrated-terminal

Use 'ContextEdit' on Server9 to experiment with file and context menu associations.

## Test-Kitchen
http://misheska.com/blog/2014/09/21/survey-of-test-kitchen-providers/
