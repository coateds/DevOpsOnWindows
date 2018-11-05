# Intro
A good all purpose text editor is essential to DevOps. Some of the advanatages I see to VSCode include
* Cross Platform: I have used Windows, CentOS and Ubuntu
* Integration with Git: I largely run commands from the terminal, but there are a number of GUI indicators and features
* Multi pane, configurable
* Terminal pane
* Explorer pane: Almost no need to escape to windows explorer
* Extensions: PowerShell, Python  (Now includes Linting (pylint, PSSCriptAnalyzer)
  * Customize PSScriptAnalyzer:  press CTRL+SHIFT+P and start typing "scriptan…"
  * Then select PSScriptAnalyzer Rules and press Enter.
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

# Other

# Headers

# ...

# Running Selected Code
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

# Code Snippets
* Source: https://code.visualstudio.com/docs/editor/userdefinedsnippets
* File > Preferences > UserSnippets
* JSON files get created as needed
    * PowerShell: C:\Users\dcoate\AppData\Roaming\Code\User\snippets\powershell.json
    * Existing files are at the top of the list
    * Snippets get added to Intellisense-like functionality