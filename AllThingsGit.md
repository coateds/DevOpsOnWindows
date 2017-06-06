# Git

## Commands

### Config
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

### Create Repositories

* git init [project-name]
* git clone [url]

### Make Changes

* git status
* git diff --- Shows file differenences not yet staged

Stage/Unstage
* git add [file]
* git reset [file] --- Unstages the file preserving contents

Permanently record to version history
* git commit --- will invoke the editor for a commit message
* git commit -m "[commit message]"

### Review History
* git log
* git log --oneline --decorate
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

## Visual Studio Code

### For documenting in .md files

* Open Preview to Side (Icon to right in tab bar)
* Ctrl+J to toggle panel (bottom pane)
* Terminal tab of panel to open PowerShell
* May need to specify PS for Terminal as it might default to cmd (Process??)
* Customize keyboard Shift+Alt+Up/Down (Process??)
* Extensions
    * PowerShell
    * Git History (See Review History Section)
    * GitDiffer (Not tried yet)

PS Script to Stage/Commit/Push  (CommitPushDocs.ps1)

    git add .
    git commit -m "Documentation"
    git push -u origin master

# GitHub


# GitLab