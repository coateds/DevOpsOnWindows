# Quick script to commit Docs to master in one command

$Branch = "edit-git-docs"
$CommitMessage = "Documnentation"

git add .
git commit -m $CommitMessage
git push -u origin $Branch