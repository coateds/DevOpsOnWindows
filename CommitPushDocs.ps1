# Quick script to commit Docs to master in one command

Param ($Branch)

git add .
git commit -m "Documentation"
git push -u origin $Branch