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

# Cross Platform
* Installation Windows (Chocolatey): `choco install vscode -y` 

# Integration with Git

# Multi Pane

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
* Alternately, install code runner extension
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