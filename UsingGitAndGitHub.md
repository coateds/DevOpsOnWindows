# Using Git and Git Repositories

Git has been integrated into many of the tools and processes of DevOps. Of course it can be used to store and version control source code on the Dev side of the house, but it is also used in the same way with Ops Scripts. Local Git Repositories are even included with Chef generated cookbooks. From a Windows perspective, this can mean storing and using PowerShell scripts integrated with local git Repos.

The Git Website is here: https://www.git-scm.com/. It can be installed via
* Downloads available on the website
* Chocolatey: Choco Install Git  (-y -params '"/GitAndUnixToolsOnPath"')

For my installation notes, see https://github.com/coateds/DevOpsOnWindows/blob/master/InstallationNotes.md

Some topics that might be reasonably discussed here:
* Configuration
* Everyday use: New Repos, Local Commands, Sync with Remote
* Tagging
* Logs and Reverting
* Remote commands
* Branching and Merging
* Pull Requests
* Interoperability and Integration with Editors
* Using PowerShell with Git

```diff
- There are three skills that should be utilized more often to be sure they are available when needed:  Reverting/Recovering files, Branching and Pull Requests
```

## Configuration
3 levels of configuration
* system /etc/.gitconfig
* global /home/[user home]/.gitconfig
* local  .git/config

Commands
* git config --list
* git config --system/global/local --list
* git config --global user.name "[name]"
* git config --global user.email "[email address]"
* git config --global color.ui auto
* git config --global core.editor vim
* git config --global core.editor notepad
* git config --global core.pager 'more'
* git config --global core.excludesfile ~/gitignore_global

To use VSCode as editor: Edit ~\.gitconfig

    [core]
        editor = code --wait

Sample contents gitignore_global

    *.goober

## Everyday Use
### Creating and syncing with a (new) repository.
The easiest way to create a link from from a local Git repository to a remote (GitHub) repository is to clone it. Even when that repository is newly created with just a readme.md file. Start in the folder that will contain the new repository.

	Git Clone <URL>

Where <URL> is retrieved from the repository on the web. Copy it from the "Clone or Download" button of a repository on GitHub. For example:  https://github.com/coateds/DevOpsOnWindows.git

If a local only repo is desired, Git Init from within the root folder. It is possible to set the remote "origin" with some of the remote commands below, but that is the hard way.

### Set up and Clone a New Repository
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

### Local Commands:
* Git init  --  To create a local Repo
* Git status  --  To see if there are files to be staged or commited to the Repo. Posh-Git and Visual Studio Code both provide other means for observing the status of a Repo.
* Git diff  --  Shows file differenences not yet staged
* Git add  [filename or '.']  --  To stage modified files (usually Git Add .)
* Git reset [file] --- Unstages the file preserving contents
* Git rm [file]  --  Removes (deletes) a file. Commit to get rid of a file from the repo.
* Git commit  --  will invoke the editor for a commit message
* Git commit -m "message"  --  To add new versions of a file to the Repo
* Git Log  --oneline (one line per commit)  **....There are other options to add here**

## Logs and Reverting
### Log
* git log
* If there is a ':' at the bottom of the shell, git has placed the shell into a pager. Type q to quit.
* git log --oneline (--decorate  Does not do anything in Windows/PS)

Diff  --  Using git diff inside of VSCode Terminal will attempt to invoke a GUI. The Git History extension seems to be a better solution for this. Run it from a standalone shell. The output of this can be hard to read. Red for removed lines, Green for added.
* git diff HEAD --- differences since last commit, use this more routinely? Be aware that it may place the shell into a pager, type 'q' to quit.
* git diff 68ab6e3 c6b5dcf [file]

Use Git History (git log) VSCode Extension
1. With file to compare open --- F1
2. Start Type View His... and select 'Git History (git log)'
3. The screen that opens will list commit messages and SHA, click a desired commit msg
4. Click on the message, then the desired file below
5. Select compare against workspace file to see the diff between current and commited version of file

### Revert
Oops!
* git checkout [file] --- Go back to the last committed version, quick fix to an accidentally deleted local file

Revert to a version
* git revert xxxxxxx --no-edit, git add [file], git commit etc...

Delete whole commits
* git reset --hard HEAD~[x] --- go back (delete) x commits
* git reset --hard origin/master --- bring remote back to same as local

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

### Branches
In the case where there are uncommitted changes when switching to another branch, Git will try to merge them  into the target branch. If the changes are incompatible, use –f to force the change.

Best Practice: Switch branches only when working directory is clean

### Merging
When a merge is initiated, but there are conflicts, Git is in 'MERGING'  mode
Open the file at that moment in an editor and there will be Git entries to show where the conflicts exist
Resolve these, stage, and commit

## Markdown files
Edit the .md file (markdown tagged file)
  Visual Studio Code

## Posh-Git
https://github.com/dahlbyk/posh-git

* A better test of Posh-git's installation is whether Get-GitStatus Cmdlet is available
* Posh-git provides a customized prompt, tab completion and the following CmdLets etc
* See https://github.com/coateds/DevOpsOnWindows/blob/master/InstallationNotes.md for more information.

### Cmdlets
* Enable-GitColors
* Get-GitDirectory
* Get-GitStatus
* tgit
* Write-GitStatus
* about_posh-git


## Tag a Version

To tag the project at letter 'F'
git tag –a v0.1 60a586d  -m "v0.1"

# Visual Studio Code
* This free Windows application can handle Windows/UNIX line feed differences in files like Ruby. (.rb)
* Provides a decent side-by-side markdown editor/visualizer
* Can be a GUI front-end to Git
* Does side-by-side 'diff' comparisons, both with selected files as well as with Git

Merge this list
* For documenting in .md files
* Open Preview to Side (Icon to right in tab bar)
* Ctrl+J to toggle panel (bottom pane)
* Terminal tab of panel to open PowerShell
* May need to specify PS for Terminal as it might default to cmd (Process??)
* Customize keyboard Shift+Alt+Up/Down (Process??)
* Extensions
    * PowerShell
    * Git History (See Review History Section)
    * Chef (Not tried yet)

## Windows/UNIX line feed differences
No coments at this time. It just seems to work.

## Markdown editing (.md files)
1. When editing a Markdown file, choose the split screen icon in the upper right of primary editor pane.
2. Then select the Open Preview icon in the same area.
3. Make changes in the left pane and view them in the right.

Tags
* '#', '##', '###'  --  Headers
* '* [Text]'  --  bulleted list
* '1 [Text]'  --  numbered list
* Effectively, a bullet or number list must have a heading
* '*' on both ends of a word/phrase  --  *Italics*
* '**' on both ends of a word/phrase  --  **Bold**
* '***' on both ends of a word/phrase  --  ***Bold Italics***
* `Single Backtick on both ends of a phrase`  --  Code Block 1

Code Blocks
```
Triple Backtick
  on the line before and on the line after a series of lines of text
  will create a multi line 'Code Block'
This is the best way to display code in a markdown file.

Tabs are preserved
```

```
A single paragraph of text, too long for the rendered page, will create a horizontal scroll bar. This is problematic because it is hard to copy code from such a block.
```

```diff
Triple Backtick with a 'diff' after the ticks can be used to create a colorized font.
+ lines that start with '+' will be green
- lines that start with '-' will be red
```

Block quotes  ---  The implementation here is a little rocky

>'>' Single greater than sign

>> '>>' Double greater than sign

Use double space after line to preserve line feeds
> Line 1
>
> Line 2

> * Line 1
> * Line 2
> * Line 3

HTML Tags
* <a href="http://www.yahoo.com">Yahoo</a>

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

## Integration with PowerShell
PS Script to Stage/Commit/Push  (CommitPushDocs.ps1)

```
git add .
git commit -m "Documentation"
git push -u origin master
```

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

Git Diff