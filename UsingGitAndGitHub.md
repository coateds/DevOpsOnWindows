# Using Git and GitHub
For installation notes, see 
https://github.com/coateds/DevOpsOnWindows/blob/master/InstallationNotes.md

Git Website
https://www.git-scm.com/

## Resources
https://www.youtube.com/watch?v=-U-eUHI6euM
Free Book:  https://git-scm.com/book/en/v2


## Very Raw - from Personal OneNote


### Local Commands: 
Git init 
Git status 
Git add 
Git commit -m "message" 

### Remote Commands: 
Git remote show origin 
Git remote add origin https://github.com/coateds/MyGitRepository.git 
  (SSL) 
Git remote add origin git@ewegithub.sb.karmalab.net:dcoate/DCoateRepository.git 
  (SSH) 
Git push -u origin master 
  (master branch) 
Git pull origin master 
Git push origin - -delete "MynewBranch" 
  (Remote Delete) 
Git remote set-url origin https://github.com/coateds/[DifferentRepositoryName].git 
  Changes the Remote Repository 

### Branch Commands: 
Git branch "branch name" 
  Create new branch 
  Use all lowercase!! Capital letters create odd issues. 
Git Branch 
  List local branches 
  After one file has been edited and saved in a new branch an asterisk will show up next to that branch in the list when it is active. 
Git Branch –r 
  List remote branches 
Git Checkout master/MynewBranch 
  Switch branches 
Git Merge "Branch to be Merged" 
  Checkout (switch to) Branch merging into (typically Master) 
Git Branch -d "Branch to be deleted" 
  (Local) 

### Identity 
git config --system/--global/--local user.name 'Test User 1' 
git config --system/--global/--local user.email 'TestUser1@TestGit.com' 
  Where system is for all users on a computer system 
    Global is for all Git repositories per created by a particular Windows profile 
    Local is for a particular repository 

Use git config –list to see all identity settings. The identity at the bottom of the list takes precedence.  

### Set up and Clone a New Repository 
Go to Git-Hub for the desired account 
1.https://github.com/coateds 
2.<ewe> 
3.Expedia Personal 
Create New ('+' icon upper right) Repository 
1.Name it 
2.Optional Description 
3.Public/Private 
4.Init with Readme.md 
5.Create button 
6.Copy/Note URL (example:  https://github.com/coateds/HtmlMonitor) 
Clone the new repository locally 
1.From the machine on which the cloned repository is desired 
2.Git Clone <URL> <PathToNewLocalRepository> 
  git clone https://github.com/coateds/HtmlMonitor 
  C:\users\dcoate\Documents\GitRepositorys\HtmlMonitor 
3.This will: 
  a.Create the Directory 
  b.Init the Directory for Git 
  c.Do the first Git Pull 
4.Customize Pinned Repositories as desired 

Edit the .md file (markdown tagged file) 




## Very Raw - from Expedia OneNote

GIT Commands
	Git init
	Git status
	Git add
	Git commit -m "message"
	Git remote add origin https://github.com/coateds/MyGitRepository.git
		SSL
	Git remote add origin git@ewegithub.sb.karmalab.net:dcoate/DCoateRepository.git
		SSH
	Git push -u origin master
		(master branch)
	Git pull origin master
	Git branch "branch name"
		Create new branch
	Git Checkout master/MynewBranch
		Switch branches
	Git Merge "Branch to be Merged"
		Checkout (switch to) Branch merging into (typically Master
	Git Branch -d "Branch to be deleted"
		(Local)
	Git push origin --delete "MynewBranch"
		(Remote)
	Git remote set-url origin https://github.com/coateds/[DifferentRepositoryName].git
		Changes the Remote Repository
		

