# Using Git and GitHub
For installation notes, see 
https://github.com/coateds/DevOpsOnWindows/blob/master/InstallationNotes.md

Git Website
https://www.git-scm.com/

## Resources
https://www.youtube.com/watch?v=-U-eUHI6euM - Tutorial 1  
	(#2 is for Mac)  
https://www.youtube.com/watch?v=sBTAkHOxvOk - Tutorial 3   
	(#4 is for Mac)  
https://www.youtube.com/watch?v=GZILYABgAoo - Tutorial 5  
Free Book:  https://git-scm.com/book/en/v2

## Creating and syncing with a (new) repository.
The easiest way to create a link from from a local Git repository to a remote (GitHub) repository is to clone it. Even when that repository is newly created with just a readme.md file. Start in the folder that will contain the new repository.

	Git Clone <URL>

Where <URL> is retrieved from the repository on the web. Copy it from the "Clone or Download" button of a repository on GitHub. For example:  https://github.com/coateds/DevOpsOnWindows.git

If a local only repo is desired, Git Init from within the root folder. It is possible to set the remote "origin" with some of the remote commands below, but that is the hard way.

## Set up and Clone a New Repository 
Go to Git-Hub for the desired account  
1. https://github.com/coateds  
2. [ewe]  
3. Expedia Personal  

Create New ('+' icon upper right) Repository  
1. Name it  
2. Optional Description  
3. Public/Private  
4. Init with Readme.md  

5. Create button  
6. Copy/Note URL (example:  https://github.com/coateds/HtmlMonitor)  

Clone the new repository locally  
1. From the machine on which the cloned repository is desired  
2. Git Clone <URL> <PathToNewLocalRepository>  
  git clone https://github.com/coateds/HtmlMonitor  
  C:\users\dcoate\Documents\GitRepositorys\HtmlMonitor  
3. This will:  

a. Create the Directory  
  b. Init the Directory for Git  
  c. Do the first Git Pull  
4. Customize Pinned Repositories as desired  

## Local Commands: 
* Git init  
  To create a local Repo  
* Git status  
	To see if there are files to be staged or commited to the Repo  
	Posh-Git and Visual Studio Code both provide other means for observing the status of a Repo
* Git add  [filename or '.']  
  To stage modified files (usually Git Add .)  
* Git commit -m "message"  
  To add new versions of a file to the Repo
* Git Log  
  --oneline (one line per commit)  
	  **....There are other options to add here**


Visual Studio Code can be used to add and commit files as well.

## Remote Commands: 
* Git push -u origin master  
  (master branch)  
* Git pull origin master  
* Git remote show origin  
  This will indicate whether the local Repo is sync'd with remote  
  (local out of date)
  (up to date)
* Git remote add origin https://github.com/coateds/MyGitRepository.git  
  (SSL)  
* Git remote add origin git@ewegithub.sb.karmalab.net:dcoate/DCoateRepository.git  
  (SSH)  
* Git push origin --delete MynewBranch  
  (Remote Delete)  
* Git remote set-url origin https://github.com/coateds/[DifferentRepositoryName].git  
  Changes the Remote Repository  

## Branch Commands:  
* Git branch "branch name"  
  Create new branch  
  Use all lowercase!! Capital letters create odd issues.  
* Git Branch  
  List local branches  
  After one file has been edited and saved in a new branch an asterisk will show up next to that branch in the list when it is active.  
* Git Branch –r  
  List remote branches  
* Git Checkout master/MynewBranch  
  Switch branches  
* Git Merge "Branch to be Merged"  
  Checkout (switch to) Branch merging into (typically Master)  
* Git Branch -d "Branch to be deleted"  
  (Local)  

## Identity  
* Git config --system/--global/--local user.name 'Test User 1'  
* Git config --system/--global/--local user.email 'TestUser1@TestGit.com'  
  Where system is for all users on a computer system  
    Global is for all Git repositories per created by a particular Windows profile  
    Local is for a particular repository  

Use Git Config –-list to see all identity settings. The identity at the bottom of the list takes precedence.   

Identity does not need to be added when cloning your own Repo

## Markdown files
Edit the .md file (markdown tagged file)  
  Visual Studio Code and Dillinger.io



## More Raw
Correction: Posh-git is installed, but not fully set up for prompt. A better test of Posh-git's installation is whether Get-GitStatus Cmdlet is available

https://github.com/dahlbyk/posh-git 

Posh-git provides a customized prompt, tab completion and the following CmdLets etc

Name                              Category  Module                    Synopsis                                                                                                                
----                              --------  ------                    --------                                                                                                                
Enable-GitColors                  Function  posh-git                  ...                                                                                                                     
Get-GitDirectory                  Function  posh-git                  ...                                                                                                                     
Get-GitStatus                     Function  posh-git                  ...                                                                                                                     
tgit                              Function  posh-git                  ...                                                                                                                     
Write-GitStatus                   Function  posh-git                  ...                                                                                                                     
about_posh-git                    HelpFile                            A set of PowerShell scripts which provide Git/PowerShell integration.     




http://robertovormittag.net/ebooks/git-and-github/
https://github.com/robertovormittag/phonetic-website 
https://github.com/robertovormittag/open-website 

See Versions of the project (commits)
Git log
git log --oneline –decorate
git log --oneline --decorate --max-count=2
git log --oneline --decorate --author=coateds


Git diff <filename>
	Unstaged Changes (between the un added file and other versions)
git diff --cached pilots.html
	Uncommitted Changes (between added/staged/index file and locally committed file)
git diff HEAD pilots.html
	Changes since last commit (between committed file and both staged and unstaged files)
git diff HEAD~1 HEAD pilots.html
	Changes between any two committed changes
	In this case the current committed and the one before that
	~2 would be two version ago

$ git log --oneline –decorate
	bde23ce (HEAD -> master) Added letter D585f438 (origin/master, origin/HEAD) Source code addedf1e2602 Initial commit
$ git diff bde23ce 585f438 pilots.html

	Diff between the last two committed versions by hash

Undo/Revert

To go back to the last committed Version:
	git checkout pilots.html
To undo staged (Added) changes
	git reset HEAD pilots.html
	(then git checkout pilots.html)
To undo a committed change
	git revert d332879 --no-edit  --- Where d332879 comes from viewing the log: git log --oneline –decorate
	
	$ git log --oneline --decorate --max-count=3
		4352684 (HEAD -> master) Revert "Unwanted Change"d332879 Unwanted Change60a586d Added letter F

Tag a Version

To tag the project at letter 'F'
git tag –a v0.1 60a586d  -m "v0.1"

Branches
In the case where there are uncommitted changes when switching to another branch, Git will try to merge them  into the target branch. If the changes are incompatible, use –f to force the change.

Best Practice: Switch branches only when working directory is clean

Merging
When a merge is initiated, but there are conflicts, Git is in 'MERGING'  mode
Open the file at that moment in an editor and there will be Git entries to show where the conflicts exist
Resolve these, stage, and commit 

Git checkout <Hash of prev ver> to go into a detached HEAD State

