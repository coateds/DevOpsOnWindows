# Using Git and GitHub - Command line and GitHub Website
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
http://robertovormittag.net/ebooks/git-and-github/  
https://github.com/robertovormittag/phonetic-website  
https://github.com/robertovormittag/open-website  

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
  (fast-forwardable)  
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

## Posh-Git
https://github.com/dahlbyk/posh-git 

A better test of Posh-git's installation is whether Get-GitStatus Cmdlet is available

Posh-git provides a customized prompt, tab completion and the following CmdLets etc

### Cmdlets                                                                                                            
Enable-GitColors  
Get-GitDirectory  
Get-GitStatus  
tgit  
Write-GitStatus  
about_posh-git  


## Logs, Diffs and Reversion

### Git Log - See Versions of the project (commits)  
* Git log  
* Git log --oneline –decorate  
* Git log --oneline --decorate --max-count=2  
* Git log --oneline --decorate --author=coateds  

### Git Diff
* Git diff [filename]  
	Unstaged Changes (between the un added file and other versions)  
  Likely the most common usage. This compares a recently saved file (unstaged) to the most recent commit.  
* Git diff --cached pilots.html  
	Uncommitted Changes (between added/staged/index file and locally committed file)  
  Perhaps easier to remember how to unstage a file (Git Reset HEAD) than to use this?  
* Git diff HEAD pilots.html  
	Changes since last commit (between committed file and both staged and unstaged files)  
* Git diff HEAD~1 HEAD pilots.html  
	Changes between any two committed changes  
	In this case the current committed and the one before that  
	~2 would be two version ago  

### Undo/Revert
* Git checkout pilots.html 
  To go back to the last committed Version:  
* Git reset HEAD pilots.html  
  To undo staged (Added) changes  
	(then git checkout pilots.html)  
* Git revert d332879 --no-edit  
  To undo a committed change  
  Where d332879 comes from viewing the log: git log --oneline –decorate

## Tag a Version

To tag the project at letter 'F'  
git tag –a v0.1 60a586d  -m "v0.1"

## More Raw

Branches
In the case where there are uncommitted changes when switching to another branch, Git will try to merge them  into the target branch. If the changes are incompatible, use –f to force the change.

Best Practice: Switch branches only when working directory is clean

Merging
When a merge is initiated, but there are conflicts, Git is in 'MERGING'  mode
Open the file at that moment in an editor and there will be Git entries to show where the conflicts exist
Resolve these, stage, and commit 

# Visual Studio Code
* This free Windows application can handle Windows/UNIX line feed differences in files like Ruby. (.rb) 
* Provides a decent side-by-side markdown editor/visualizer
* Can be a GUI front-end to Git
* Does side-by-side 'diff' comparisons, both with selected files as well as with Git

## Windows/UNIX line feed differences
No coments at this time. It just seems to work. 

## Markdown editing (.md files)
1. When editing a Markdown file, choose the split screen icon in the upper right of primary editor pane.
2. Then select the Open Preview icon in the same area.
3. Make changes in the left pane and view them in the right.

## A GUI front end to Git
This is a large subject, most of which need not be written out because it is a GUI. A couple of concepts will help get things started.  

* Open a Folder from the File menu to work with a particular repository.  
* Look lower left for sync status and the branch currently open. Sync from here as needed.  
* Switch between Explorer View and Git View with the icons down the left edge.  
* Ctrl+S to saved
* From Git view, rollover the filename on the left of the edited file. Click the + that appears to stage the file or click the 'clean' arrow to revert to the current commited version of the file.  
* Still from the Git view, type a commit message in the message box and Ctrl+Enter or check mark to commit the staged files.
* Finally, in the Git view, click the elipsis and choose Push to sync the commit to the remote repository. Alternately, choose to sync in the lower left to do a Pull and then Push.
* There are a couple of ways to enter CLI commands from VSC
  * Use Ctrl+P to type in commands one at a time
  * From the Git Elipsis, Select Show Git Output then click on the terminal tab. This produces what appears to be a cmd window.
* From the Welcome/Get Started page, clone a repository.

## Viewing differences
* At any time there is a saved file, that is different than the commited file, it is possible to view the differences by selecting the Changes View icon in the upper right.