# Using Git and Git Repositories

Git has been integrated into many of the tools and processes of DevOps. Of course it can be used to store and version control source code on the Dev side of the house, but it is also used in the same way with Ops Scripts. Local Git Repositories are even included with Chef generated cookbooks. From a Windows perspective, this can mean storing and using PowerShell scripts integrated with local git repos.

As I continue to work on this document I am trying to decide what I can do here that does not already exist on the Internet. If you just want to learn to use Git on Windows and sync your local repositories with GitHub, Bitbucket or other Git based Internet accessible repositories, there are lots of good YouTube videos. Instead, I want to explore a more Windows centric approach. I will try to cover all of the command line interfaces, but also introduce a GUI alternative that I really like.

At this time I will be introducing and working with the following:
* Git  --  version 2.13.1.windows.1
* GitHub  --  https://www.github.com
* Markdown files
* Visual Studio Code  --  Version 1.13.1
* PowerShell  --  WMF Version 5.1
* Posh-Git  --  Version 7.1


I am going to offload a lot of the installation and configuration instructions to another file: <a href='InstallationNotes.md'>Install the Windows DevOps environment</a>. In this document, I have shifted to a Chocolatey based installation, but have left a lot of manual instructions behind. The environment I describe there is intended to add at least one more technology: ChefDK. If you are not going down that path, or have very little interest in co-existing with Linux and some of these tool sets, you may wish to leave off the /GitAndUnixToolsOnPath parameter of the Git installation. I am not going to make specific recommendations on this here and this documentation is based on using this option/parameter.

Some topics that might be reasonably discussed here (The beginnings of a table of Contents):
* Git Configuration
* Local use: New repos, Local Commands
* Tagging
* Logs and Reverting
* Branching and Merging
* Remote commands
* Pull Requests
* Interoperability and Integration with Editors
* Using PowerShell with Git

## Introduction to an integrated Windows Git environment using Visual Studio Code
Because this is a Windows centric environment, there are two additional technologies that will be discussed: PowerShell and my chosen GUI front end, Visual Studio Code. In other words, command line and GUI. Microsoft has been working very hard to promote PowerShell over the Cmd shell. Git works just fine in PowerShell. At this time, I know of nothing in Git that requires the Cmd shell. Therefore, I will continue to completely ignore it. In fact, there is at least one PS module, Posh-Git, that makes working in PowerShell easier than the Cmd shell. While I do believe that you can do ALL things Git in PowerShell. There are a couple of things that are just easier in a GUI.

Visual Studio Code may not have set out to be a front end GUI for git. It's primary purpose is as a text file editor. It may be there are products worth looking at that are primarily a Git GUI, but I believe the advantage of VSCode is its ability to handle multiple tasks all in the same window. Perhaps the feature that sold me was the ability to open a PowerShell terminal at the bottom of the screen. With this, you can choose to perform many actions from the GUI or from PowerShell all within the same application. Even the Posh-Git enhancements are available in this way. Again, the configuration needed to make all of this work are in the <a href='InstallationNotes.md'>Install the Windows DevOps environment</a> document.

Another big advantage of VSCode is its cross platform flexibility. I have installed it on an Ubuntu workstation and it works nearly identically. In fact the main difference with regards to the methodologies I describe here is that the terminal opens in Bash instead of the Windows Cmd shell or PowerShell. However, even that can be customized to match. I have also installed PowerShell for Linux on this Ubuntu workstations and this can easily be invoked from the Bash shell. From here functionality starts to diverge with various extensions that can be added to the Windows and Linux versions of VSCode.

Depending on your environment, interoperability with Linux may be a big deal. A lot of editors handle the difference in end of line formatting of text files with ease, including VSCode. This is an important, but largely transparent feature of this environment. In fact, so transparent, it can be jarring when the issue comes up in other tools.

GitHub (and perhaps other remote repository providers) use Markdown files for documentation. VSCode has a great deal of support for working this format. Follow the link below for more information.

<a href='UsingMarkdown.md'>Using Markdown</a>

My main point here is that you can do a great deal of work from inside the VSCode single window. You can work on your scripts, test them, check them into local repos and even sync the changes to remote repos all from VSCode.

From here we launch into working with a local repository. I tend to prefer working in PowerShell using the Git commands, but much or all of this work can be done in the GUI of VSCode. This next section will cover command line for the configuration of Git at the Local, Global and System levels. The commands really just interact with a number of config files. If you prefer, these can be opened in VSCode editor windows and customized directly.

## Git Configuration
Local configurations can get to be fancy if you want, but it is not necessary to get started. However, you should always use the first two configurations (name and email) on any computer that you use Git.

Commands
* `git config --global user.name "[name]"`
* `git config --global user.email "[email address]"*`
* `git config [--system/global/local] --list`
  * Use this to list the current configuration
  * There are three levels of configuration. Specify the desired level or none at all to see all configurations
* `git config --global color.ui auto`
* `git config --global core.editor vim`
* `git config --global core.editor notepad`
* `git config --global core.pager 'more'`
* `git config --global core.excludesfile ~/gitignore_global`
* `git --version`

Whenever you install git on a machine, the name and email should be customized into the global configuration. This level of configuration is per user/per machine. All repositories created on a machine logged on as a particular user will be subject to global configurations. System level configurations are applied to all repos on a computer regardless of user. Local are for a single repository.

The git config command can be use to set these configurations, but each level has its own file which can be edited directly if desired. The files can be found in:
* system windows: C:\Program Files\Git\mingw64\etc\gitconfig
* system linux: /etc/.gitconfig
* global windows: c:\users\[user]\.gitconfig
* global linux: /home/[user home]/.gitconfig
* local:  .git/config

Notice the .git folder in the local config. It is this folder that makes its parent folder a repository. In fact, deleting this folder will remove the repository.

A bit more advanced is the custom configuration of an editor. Do not worry about why this might be desirable right now. In particular, VSCode needs a bit of fancy to work. Edit the appropriate level file. (probably global)

```
[core]
  editor = code --wait
```
To ignore files at the global level
```
Sample contents gitignore_global
*.goober
```

## Local Use
Git is designed to be used locally and then shared and/or stored in remote repositories.

### Create a new local repo
* Create a folder to house your repo
* cd to that folder
* git init
* Notice that the .git folder described earlier is created. This IS the repository.

While it is possible to set the local configuration to connect this new repo to a remote repo, it is usually easier to clone an existing repo. This will create the local repo, copy the contents down from the remote and configure the connection all in one go. One only needs the HTTPS or SSH URL. From the folder you wish to contain the repository:  `Git Clone [URL]`

Where [URL] is retrieved from the repository or sent to you. From GitHub, Copy it from the "Clone or Download" button of a repository on GitHub. The format will be  https://github.com/[username]/[repositoryname].git. If you have a GitHub account (free) you can create a repository with a README.md file and then clone it.

Note that setting up an SSH connection is a bit more involved and will be discussed later.

### Tutorial: Set up and Clone a New Repository
Go to Git-Hub of your choice for the desired account
* https://github.com, Your Enterprise or GitLab
* Navigate to that Repository in browser

Create New ('+' icon upper right) Repository
1. Name it
2. Optional Description
3. Public/Private
4. Init with Readme.md
5. Create button
6. Copy/Note URL (example:  https://github.com/coateds/DevOpsOnWindows.git)

Clone the new repository locally
1. From the machine on which the cloned repository is desired
2. Git Clone [URL] [PathToNewLocalRepository]

This will:
* Create the Directory
* Init the Directory for Git
* Do the first Git Pull

Clone via VSCode
* There is a link on the Welcome page under the Start heading
* Or F1 will bring up a single command 'pallette' near the top of the window
* Type 'clone' in the pallette and Enter.

### Local Commands:
These are the most used commands when editing the files within a repo. At its core, Git is an SCM, so every commit is saved to disk as a delta from the previous commit. So at any time it is possible to revert to a previous commit.
* `Git status`  --  To see if there are files to be staged or committed to the Repo.
  * Posh-Git and Visual Studio Code both provide other means for observing the status of a Repo.
* `Git add  [filename or '.']`  --  To stage modified files (usually Git Add .)
* `Git commit -m "message"`  --  To add new versions of a file to the Repo
  * Git commit with no options will invoke the editor for a commit message
* `Git rm [file]`  --  Removes (deletes) a file. Commit to get rid of a file from the repo.

### Walk Through: Adding content to a Repo with VSCode and CLI
To follow this tutorial, Git, VSCode, PowerShell and Posh-Git must all be installed and configured using the install document. You will also need a local repository. This can be a brand new repo, or a cloned repo as described in the previous sections.

The first thing to do is open the folder that is the repo in VSCode. You can either open VSCode and select File, Open Folder or you can navigate to the folder in Explorer and open it from the context menu. The important thing is that for a cloned or initialized Git folder if you open the folder and not individual files in VSCode, it will recognize the folder as a Git Repo.

Once opened in this fashion, take note of the 5 icons in the upper left. Explore them, but the first, Explorer, and the third, Source Control are the two we are most interested in at this time. Now press ``Ctrl+` `` (backtick) to open a terminal in the bottom pane. If all has been properly configured, it should say powershell.exe near the upper right of that pane. In addition, the PS prompt should have "[master]" appended to the end. This is the Posh-Git module in action. This indicator shows that we are currently in the master branch of the repository. VSCode also shows the the branch in the lower left corner of the whole window. Branches are for a later discussion.

At this time, create the a text file of your choice. It can be a .md file, .ps1 file or any other type of file you might want to put under source control. The file can be created in Explorer, VSCode or even in the PowerShell terminal. It does not matter. In fact it might be instructional to try several methods to see what happens.

Once you have one or more files created in your repo, they should appear in the Explorer view in the left pane. At this point you should also see a number superimposed on the Source Control icon. This is because there are files or content or files not in source control. in the terminal, type `git status` and you will likely see one or more untracked files. You will also see that the PS prompt has changed. Open the Source Control view in the left pane by clicking its icon (the one with the number on it) You should see that one or more files have changes and are marked with a 'u'. All of these indicators are showing you have one or more files that are untracked or not staged.

In the terminal pane, the git status command output tells you what to do next. The files need to be added (staged). Type `git add .` . The dot indicates all untracked files should be added. A couple of indicators should have changed. In the Source Control panel, the 'u' indicator should have changed to 'A' and in the terminal window, the prompt color of the files changed from red to green.  Type `git status' again and read the output. It tells you how to upstage the file(s) and it lists the files to be committed.

The next step is to commit the files/changes. Type `git commit -m "first commit` in the terminal. Once again, a number of indicators have changed. The prompt in PowerShell has returned to "[master]" and the number superimposed on the Source Control icon has disappeared. From a local perspective, this is all that is required to add content to a local repo. Although it has not been covered yet, type `git log` in the terminal and look at the results.

At this point, go ahead and add some content to the files from inside VSCode. Get used to the interaction of opening and closing files in the main editor pane by clicking on them in in the Explorer pane to open or clicking the 'x' in the editor tabs across the top to close. Add some content to one or more files and note the indicators to show unsaved files. The number superimposed on the Explorer icon and the 'x' turns to a ball in the tabs. Now save the files.

At this point you can go through the add/commit process again. The only difference is that `git status` and the Source Control pane now show the files as modified instead of untracked. Enter the commands:
```
git add .
git commit -m "second commit"
```
One last thing to do in this walk through, type `git log --oneline` in the terminal. The 7 digit hex identifier for each commit are just the first characters of the much longer string viewed earlier in the `git log` output. These are used to uniquely identify each commit if there is ever a need to go back to one of these commits.


```diff
+ Note that all of these processes can be accomplished in a GUI way within VSCode.
+ Here are descriptions of some of these.
```
#### A GUI front end to Git
* Open a Folder from the File menu to work with a particular repository.
* Look lower left for sync status and the branch currently open. Sync from here as needed.
* Switch between Explorer View and Git View with the icons down the left edge.
* Ctrl+S to saved
* From Git view, rollover the filename on the left of the edited file. Click the + that appears to stage the file or click the 'clean' arrow to revert to the current committed version of the file.
* Still from the Git view, type a commit message in the message box and Ctrl+Enter or check mark to commit the staged files.
* Finally, in the Git view, click the ellipsis and choose Push to sync the commit to the remote repository. Alternately, choose to sync in the lower left to do a Pull and then Push.

## Tagging
Use this to mark a project at a significant point
* To tag the project at commit number 60a586d (for instance)
* `git tag –a v0.1 60a586d  -m "v0.1"`
* It is possible to reset/revert back to a tagged version of the files

## Logs and Reverting
There are a lot of moving parts to viewing the logs, which are a record of commits to a repo. This is one place where a GUI can be far easier than command line. There is a VSCode extension, 'Git History' that seems to make identifying and viewing changes in various commits quite a bit easier. In fact, it seems to me, that copying code out of an old commit, may be far easier than rolling back a file or a set of files to an earlier version.

### Log
git log is the primary command line tool to see the history. There are some *NIX like aspects to using it and some of the options only work in *NIX
* `git log`
  * If there is a ':' at the bottom of the shell, git has placed the shell into a pager. Type q to quit.
* `git log --oneline`
  * (--decorate does not do anything in Windows/PS)
  * *....There are other options to add here*
* `Git log --oneline --max-count=2`
* `Git log --oneline --author=[Name]`

### Use Git History (git log) VSCode Extension
1. With file to compare open --- F1
2. Start Type View His... and select 'Git History (git log)'
3. The screen that opens will list commit messages and SHA, click a desired commit msg
4. Click on the message, then the desired file below
5. Select compare against workspace file to see the diff between current and committed version of file
6. This will show a side-by-side comparison.

### Revert
Local commands
* `git checkout`
* `git revert`
* `git reset`

Oops!
* `git checkout [file/.]` --- Go back to the last committed version, quick fix to an accidentally changed or deleted local file. Running this command right after a commit will do nothing because the workspace version of the files are the same as the committed. However, delete the contents or even the files themselves and everything can be recovered if it has not been committed. Git checkout is also used in branching as well see in a later section. Think of this as 'go get the last committed version' of something, whether it be a file or a branch

The difference between revert and reset is history: Revert keeps the history as file versions revert back to an older version whereas Reset will delete one or more commits when rolling back. The following walk through will illustrate the point. However, given that Reset is destructive of data, it seems reasonable to use the Revert command far more than the Reset.

The revert/reset walk through
* The following has been run with two commits to a new repo. The first with no contents in the file(s) and the second with some contents added. Run `git log --oneline`:
```
1e633e5 second commit
179c33f first commit
```
* Enter `git revert 1e633e5 --no-edit` to make the changes commit in that commit go away. This will make the contents of the files go away. That is, the repo will be in the state it was BEFORE the reverted commit.
* However, this does not make the second commit go away. Rather it makes a copy of the first commit and creates a whole new commit. Therefore the output of `git log --oneline` will include three commits:
```
7b252fb Revert "second commit"
1e633e5 second commit
179c33f first commit
```
* To actually make one or more commits go away, use the reset command. `git reset --hard HEAD~1` will make the last commit go away:
```
1e633e5 second commit
179c33f first commit
```
* When using a revert, the --no-edit option uses a template for the revert comment. To change the comment, drop the option and a file will come up in the editor configured.
* `git config --local core.editor notepad` or whatever editor is desired. If nothing is specified it might try to eit in vim
* Run a git revert will create a new commit that is a copy of the state of the

If you are a relative beginner to all of this like me, stick to using and learning Revert. Reset is more advanced? For special cases only?

An exception?
* `Git reset HEAD [file]`
  * To undo staged (Added) changes
  * (then git checkout [file])

### Git Diff
git diff is pretty difficult to use (at least for me). I am not sure how much I am going to be able to work on this section. For now, I find using Git History as described above to be FAR easier.

Commands
* `Git diff [filename]`
	Unstaged Changes (between the un added file and other versions)
  Likely the most common usage. This compares a recently saved file (unstaged) to the most recent commit.
* `Git diff --cached [filename]`
	Uncommitted Changes (between added/staged/index file and locally committed file)
  Perhaps easier to remember how to unstage a file (Git Reset HEAD) than to use this?
* `Git diff HEAD [filename]`
	Changes since last commit (between committed file and both staged and unstaged files) Be aware that it may place the shell into a pager, type 'q' to quit.
* `Git diff HEAD~1 HEAD [filename]`
	Changes between any two committed changes
	In this case the current committed and the one before that
	~2 would be two version ago

Run it from a standalone shell. The output of this can be hard to read. Red for removed lines, Green for added.
* `git diff HEAD` --- differences since last commit, use this more routinely?
* `git diff 68ab6e3 c6b5dcf [file]`

## Branching and Merging
If you are experienced with other SCMs, a simple list of commands may be enough information

### Branch Commands:
* `Git branch [BranchName]`
  Create new branch
  Use all lowercase!! Capital letters create odd issues.
* `Git Branch`
  List local branches
  After one file has been edited and saved in a new branch an asterisk will show up next to that branch in the list when it is active.
* `Git Branch –r`
  List remote branches
* `Git Checkout [BranchName]`
  Switch branches
* `Git Merge [BranchName]`
  Checkout (switch to) Branch merging into (typically Master)
* `Git Branch -d  [BranchName]`
  (Local)

There are two scenarios worth talking about at this time
1. A simple branch and merge without conflicts
2. A complex merge with a conflict to be resolved

Starting scenario
* A master branch with 2 files
* File one: README.md with one line of text
* File two: Tutorial.ps1 with one line of text
* Work in VSCode with a PS terminal and Tutorial.ps1 open

Now from the Terminal Window
* `git branch branch1` to create a branch (I try not to use capital letters)
* `git branch` to list the branches. The current branch will be marked with '*'
* `git checkout branch1` Note that the PS prompt and the indicate in the lower left corner of the VSCode window changes
* Add some content Tutorial.ps1
* Save the file
* In the Terminal:
  * `git add .`
  * `git commit -m "branch1 first commit"`
  * `git log --oneline` inspect the output
  * `git checkout master` notice how the new content in Tutorial.ps1 disappears. It only exists in branch1.   There is a bit of magic going on here. As branches are checked out, the files in repository change. Open them in notepad outside of VSCode as you cycle through different branches. The content will change with the branch checked out
  * `git merge branch1` The new content reappears. It has been merged into the master branch.

In the next scenario, we will create yet another branch and edit the README file from both (non-master) branches.
* Start by creating a branch2 and switching to it: `git branch branch2` and `git checkout branch2`
* Go to the README.md file and add content on lines 4 and 6. My example looks like this:
```
1. # README Contents
2.
3. Added from branch2
```
* Save the file, Stage the changes and commit: `git add .` and `git commit -m "branch2 first commit"`
* Now check out branch1. In addition to the `git branch` command, VSCode provides a GUI method. Click on the branch indicator in the lower left corner. (It should say 'master', 'branch1' or 'branch2') Then select the desired branch from the list that appears at the top of the VSCode window. Note the PS prompt does not automatically change. `git status` will refresh that.
* Go to the README.md file and add content on lines 3 and 6. My example looks like this:
```
1. # README Contents
2.
3. Added from branch1
```
* Save the file, Stage the changes and commit: `git add .` and `git commit -m "branch1 second commit"`
* At this point, the contents of README.md should be different in all three branches.
* Take a look at the log for each branch. You will notice that commits that were merged into master exist in that log (branch1 first commit) and commits that existed in master when a branch was cut exist in the new branch's log. (branch1 first commit in the list for branch2)
```
[master]> git log --oneline
  460f3a5 branch1 first commit
  a5a6716 second commit
  179c33f first commit

[branch1]> git log --oneline
  efd8c59 branch1 second commit
  460f3a5 branch1 first commit
  a5a6716 second commit
  179c33f first commit

[branch2]> git log --oneline
  fab81ca branch2 first commit
  460f3a5 branch1 first commit
  a5a6716 second commit
  179c33f first commit
```
* There may be a good argument to be made that all commits should have the origin branch of their creation embedded in their comment.
* With the master branch checked out, merge branch1. `git merge branch1`. This should happen with no conflicts.
* Now merge branch2. `git merge branch2`
* The lines added to README.md from each branch are now in conflict. VSCode presents 4 options: Accept Current Change, Accept Incoming Change, Accept Both Changes, Compare Changes as live links.
* Select one of these options (Accept Both)
* README.md is now in an unsaved state
* Save, `git add .` and `git commit -m "master merge branch2 (resolve conflict)"`
* Note that another option is to `git merge --abort` to cancel the whole merge operation.

Here is the current git log for master
```
5af7262 master merge branch2 (resolve conflict)
efd8c59 branch1 second commit
fab81ca branch2 first commit
460f3a5 branch1 first commit
a5a6716 second commit
179c33f first commit
```

Branches Notes:
* In the case where there are uncommitted changes when switching to another branch, Git will try to merge them into the target branch. If the changes are incompatible, use –f to force the change.
* Best Practice: Switch branches only when working directory is clean

Merging Notes:
* When a merge is initiated, but there are conflicts, Git is in 'MERGING'  mode
* Open the file at that moment in an editor and there will be Git entries to show where the conflicts exist
* Resolve these, stage, and commit

## Remote Commands:
Everything to this point has been about working locally except for a quick discussion about cloning a remote repository as a method of creating one. If you are following along the tutorials and walk throughs you may or may not have connected your local repository to a remote repo. Enter `git remote` to find out. If your local repo is connected to a remote, the return value will be 'origin', otherwise there will be no return.

To date, all of my work with remote repos has been with some variant of GitHub. (GitHub.com, Enterprise and GitLab) There are other remote services. BitBucket for instance. From a Git perspective, there should be little or no difference.

As indicated above, cloning an existing (even an empty) remote repo is the easiest way to configure a local repository to sync with a remote. The cloning process will do a 'pull' from the remote, which is to say it will copy all of the files and data from the remote repo to the local. This allows you to make changes to the most recent copy before you 'push' the data back to the remote.

In the simplest case, there will be only the master branch to work with:
* `Git push origin master`
* `Git pull origin master`

As you start to work with more complex scenarios, you may need to substitute other branches for master.

What is origin? Enter the command `git config --local --list` (remember this from the configuration discussion?) Look at the lines that contain the word origin. Most importantly for now, `remote.origin.url=`. This will be the URL to the remote repository. There are several formats of URL depending on the protocol. GitHub provides URLs for the two most common: HTTPS and SSH. Of these SSL is the easiest, but in some cases, a repo may be configured to only accept SSH when attempting to write data.

To get information about the remote repo and sync status `Git remote show origin`
* This will indicate whether the local Repo is sync'd with remote
* (local out of date)
* (up to date)
* (fast-forward-able)

Configuring URLs
* `Git remote add origin https://github.com/[user]/MyGitRepository.git`  (SSL)
* `Git remote add origin git@github.com:[user]/MyGitRepository.git`  (SSH)
* `Git remote set-url origin https://github.com/[user]/[DiffRepoName].git`
* `git remote get-url origin`

Use the `add` option to create a connection from a local repo that was not cloned. When using the SSL option, you will be asked to provide a password in order to write to the remote repo. This is simpler to understand, but can be a hassle if your method does not have a way to save the password, or you do not want the password saved.

How passwords are saved Windows
* After using Git on Windows to sync local updates to a remote repository over SSL, you might notice that you are not always asked to provide credentials every time you try to write to the remote. On my systems, by default, there is an entry in the system config file:
  * credential.helper=manager
* There are a lot of schemes out there for minimizing the number of times you need to provide your credentials when writing to a remote repository. This particular scheme seems to be a product made by Microsoft for Windows.
  * git credential-manager version to confirm installation
  * See GitHub source:
<a href="https://github.com/Microsoft/Git-Credential-Manager-for-Windows">Git Credential Manager</a>

To cache passwords on Linux (untested by me):
* `git config credential.helper 'cache --timeout=300'`
* This example will cache for 5 min
* <a href="https://git-scm.com/docs/git-credential-cache">Docs</a>


Using SSH, may, in some circumstances, be more secure. It might even be required for some repos. The process for connecting to an SSH repo will be something like:
* Use ssh-keygen to create a public-private key pair
* Copy the contents of the pub key file
* Paste these contents into your profile settings in your remote repository's configuration interface
* Add or Set the URL in your repo's local configuration

```diff
- Include more precise SSH instructions for GitHub
```

Sync Commands  ---  I have already mentioned the most basic forms for syncing your local repo master branch with the remote repo. Typically, all work will be done on a branch designated for that purpose. This might be a new feature set or a series of fixes. Changes (merges) to the master branch are made by a limited number of people.
* `git pull origin [branch]`
* `git push origin [-u] [branch]`
  * The -u sets the upstream target. Not needed in simple configurations as the default behavior is likely desirable. This option will write to the local configuration file
* `Git push origin --delete [branch]`  (Remote Delete)

The administrators of a remote repo will use these commands to retrieve the latest version of a branch (Pull), incorporate these changes into master (Merge) and then post the updated master back to the remote repo (Push).

## Pull Requests
So how does one submit changes to a repo if one is not an administrator??

The answer seems to be: create a pull request. How this is done may depend on your level of access?

Whenever a branch has committed changes and has been pushed to GitHub, that unmerged branch will appear as a Pull Request on the home page of the repository. Once that has been merged on a local copy of the repo and that merge pushed up to master, the Pull Request disappears.

There is also a button labeled "Compare & pull request". Click this button and the changes will be displayed, an indicator that it is (not) able to merge and a Create pull request button. There is also an opportunity to make/leave a comment.

## Using PowerShell with Git
As I mentioned, one of the features that sold me on the use of VSCode, is the ability to run PowerShell in the Integrated Terminal. From here, I can not only execute ad-hoc PS commands, but I can run whole scripts and snippets of scripts. As an example, consider the following script:

PS Script to Stage/Commit/Push  (CommitPushDocs.ps1)
```
$Branch = "edit-git-docs"
$CommitMessage = "Documentation"

git add .
git commit -m $CommitMessage
git push -u origin $Branch
```

I have been using VSCode to write this document and others using Markdown. While the side-by-side markdown preview in VSCode does help a lot in managing simple errors in the Markdown formatting, there is no substitute for seeing the document inside GitHub to give it some final polish. This means adding and committing the file to the local repo as well as pushing it to GitHub over and over. In this script I do this all in one go. While it might be good practice to assign a different commit message to every commit, I see little advantage to this while working alone and simply committing documentation changes. I leave it to you to decide how you want to work. For now, I offer this simple demo:

PowerShell script walk through.
* Create a ps1 document in your local repo (CommitPushDocs.ps1 if you like)
* Enter the PowerShell script above (or modify to suit your needs)
* Note that VSCode recognizes ps1 files and modifies its behavior when such a file is open and and has the focus in the edit pane.
* Run the script from VSCode by highlighting it in the ps1 file and hitting F8
* it is also possible to simply run the script from terminal by entering `.\CommitPushDocs.ps1` and Enter. Remember to save the files you are working on before doing this!
* There are a number of customizations to VSCode to consider when working with PowerShell. Implementation details should be included in the installation doc.
  * Change default terminal from cmd to powershell
  * PowerShell Extension
  * Posh-Git
* At this time, I want to point out a dropdown box at the top of the terminal pane toward the right. It may have a couple of selections such as "powershell.exe" and "PowerShell Integrated Console". I am still working out the differences between these two. In my current configuration I notice the following:
  * powershell.exe is the default when I open the terminal
  * Shell prompt customizations from Posh-Git only appear in the powershell.exe
  * The PS Integrated terminal seems to appear when I open a .ps1 file in the editor. I am not sure if this is included behavior or a consequence of the extension...?
  * The PS Integrated terminal is required to be running for the F8 key to work as described. It need not be selected in the dropdown.

### Posh-Git
https://github.com/dahlbyk/posh-git

* A better test of Posh-git's installation is whether Get-GitStatus Cmdlet is available
* Posh-git provides a customized prompt, tab completion and the following CmdLets etc
* See https://github.com/coateds/DevOpsOnWindows/blob/master/InstallationNotes.md for more information.

#### Cmdlets
* Enable-GitColors
* Get-GitDirectory
* Get-GitStatus
* tgit
* Write-GitStatus
* about_posh-git

# Resources
* https://www.youtube.com/watch?v=-U-eUHI6euM - Tutorial 1
	* (#2 is for Mac)
* https://www.youtube.com/watch?v=sBTAkHOxvOk - Tutorial 3
	* (#4 is for Mac)
* https://www.youtube.com/watch?v=GZILYABgAoo - Tutorial 5
* Free Book:  https://git-scm.com/book/en/v2
* http://robertovormittag.net/ebooks/git-and-github/
* https://github.com/robertovormittag/phonetic-website
* https://github.com/robertovormittag/open-website

# Detritus

### Visual Studio Code
* Does side-by-side 'diff' comparisons, both with selected files as well as with Git

Merge this list
* Ctrl+J to toggle panel (bottom pane)
* May need to specify PS for Terminal as it might default to cmd (Process??)
* Customize keyboard Shift+Alt+Up/Down (Process??)
* Extensions
    * PowerShell
    * Git History (See Review History Section)
    * Chef (Not tried yet)


Viewing differences
* At any time there is a saved file, that is different than the committed file, it is possible to view the differences by selecting the Changes View icon in the upper right.