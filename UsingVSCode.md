# Intro
A good all purpose text editor is essential to DevOps. Some of the advanatages I see to VSCode include
* Cross Platform: I have used Windows, CentOS and Ubuntu
* Integration with Git: I largely run commands from the terminal, but there are a number of GUI indicators and features
* Multi pane, configurable
* Terminal pane
* Explorer pane: Almost no need to escape to windows explorer
* Extensions: PowerShell, Python  (Now includes Linting (pylint, PSSCriptAnalyzer)
* md split screen
* Run code in terminal
* Run selected code
    * press Ctrl+Shift+P and type "run sel." Then chose Terminal: Run Selected Text In Active Terminal
    * Code Runner extension
* Configurable keyboard shortcuts
    * Shift + Alt multi line selection (copied from PowerShell ISE)
* Code snippets
* Integrates with poshgit
* Multiple terminals
    * Combined with Git/Poshgit easy to push/pull 

# Setup a new workstation for VSCode, PowerShell and Python
* Install Git
* Install VSCode
* Install PowerShell
  * Windows: installation not necessary, but upgrade might be
  * Linux: I have a process somewhere, but I do not presently use this
* Install Python (plus virtualenv and pip if needed)
* Install Modules
  * PSTools from GitHub. For now, clone to ~\Documents\WindowsPowerShell\Modules\pstools
  * I have no Python Modules at this time
* Configure my key combinations (Shift + Alt multi line selection)
* Install extensions (PS and Pythin will suggest install on first edit of .ps1 and .py file)
  * Code Runner
* Sync Snippets (currently in `GitHub:Comaparitive-Scripting/snippet-[lang].json`)

# Cross Platform
* Installation Windows (Chocolatey): `choco install vscode -y` 

# Integration with Git

# Multi Pane
* Explorer Pane on the left
  * Files
  * Search
  * Source Control
  * Debug
  * Extensions
  * Other (Docker)
* Code Panes
  * Split with open to side or drag/drop
  * Split for Markdown preview
  * Split for Comparison
    * Right click file one in Exp Pane > Select for Compare
    * Right click another file in Exp Pane > Compare with Selected
    * Any file in "Open Editors (Exp Pane)" can be used in a comparison, including Snippets
* Terminal Pane
  * Problems
  * Output
  * Debug Console
  * Terminal

# Extensions
* Customize PSScriptAnalyzer:  press CTRL+SHIFT+P and start typing "scriptan…"
* Then select PSScriptAnalyzer Rules and press Enter.
* Powershell
  * <a href="https://marketplace.visualstudio.com/items? itemName=ms-vscode.PowerShell">PS Extension Docs</a>
  * `choco install vscode-powershell`  --- Did not use
  * `Install-Package vscode-powershell`  --- This (apparently) worked
  * Sets up the PowerShell Integrated Console in the lower pane
* Git History (git log)
  * <a href="https://github.com/DonJayamanne/gitHistoryVSCode">Docs onGitHub</a>
  * Must be installed manually
* Code Spellchecker
  * <a href="https://marketplace.visualstudio.com/items? itemName=streetsidesoftware.code-spell-checker">Docs on VS Marketplace</a>
  * Must be installed manually

# Markdown Editor
* For markdown files use the "Open Preview to the Side" feature to open a split screen of source text and interpreted display.

# Run (selected) code in the terminal
* Method 1 (built in):
  * Select Text, press Ctrl+Shift+P and type "run sel."
  * Chose Terminal: Run Selected Text In Active Terminal.
  * Assign a keyboard shortcut if using this method
    * Press F1, Prefs: open keyboard shortcuts
    * Search for 'workbench.action.terminal.runSelectedText'
    * Click on it and add key combo "Ctrl+Alt+R"
    * JSON:
    ```json
    {
    "key": "ctrl+alt+r",
    "command": "workbench.action.terminal.runSelectedText"
    }```    
* Not Using this method, install code runner extension
  * Source: https://4sysops.com/archives/how-to-run-powershell-code-in-vscode/
  * Simplest use: Highlight, and right click
  * By default will send to output tab… change this to terminal
  * Customize output to terminal
    * Ctrl+shift+p - prefs: open setting json
    * In right pane, add: "code-runner.runInTerminal": true,


# Configurable keyboard shortcuts
There is a shortcut key combination in the PowerShell ISE that I like. It makes it possible to select a series of lines in the file for the insertion of one or more characters. This is a really fast way to comment out (or uncomment) a bunch of lines of script.
* Customize Short-cut keys
	1. From the Command Pallette (View menu)  F1
	2. Preferences: Open Keyboard Shortcuts File
	3. Change/add to keybindings.json

  ```
	[
		{"key": "shift+alt+down",
		"command": "editor.action.insertCursorBelow"},

		{"key": "shift+alt+up",
		"command": "editor.action.insertCursorAbove"}
	]
  ```

Now Shift+Alt+Up/Down works like PS ISE to allow multi-line editing.
Most useful to comment/un-comment consecutive lines of code.

# Code Snippets
* Source: https://code.visualstudio.com/docs/editor/userdefinedsnippets
* File > Preferences > UserSnippets
* JSON files get created as needed
    * PowerShell: C:\Users\dcoate\AppData\Roaming\Code\User\snippets\powershell.json
    * Existing files are at the top of the list
    * Snippets get added to Intellisense-like functionality

# Debugger
Sources
* https://blogs.technet.microsoft.com/heyscriptingguy/2017/02/06/debugging-powershell-script-in-visual-studio-code-part-1/
* https://blogs.technet.microsoft.com/heyscriptingguy/2017/02/13/debugging-powershell-script-in-visual-studio-code-part-2/

Very Simple use:
* Click the debugger icon on the far left
* Open a file
* F5 to start debugging
* In the dropdown box at the top of the debug pane `PowerShell Launch Current File`