# Quick script to commit Docs to master in one command

$Branch = "edit-git-docs"
$CommitMessage = "Documentation"

git add .
git commit -m $CommitMessage
git push -u origin $Branch