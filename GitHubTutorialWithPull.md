# GitHub Tutorial

https://guides.github.com/activities/hello-world/

set up account dscoate on GitHub

Create the Hello-World repo with a README.md that has a description included

On the website, create a branch called readme-edits. Add content to README.md in this branch.

## Pull request
* click pull req tab
* click New pull request
* select base:master ... compare:readme-edits
* review changes to confirm desired
* click Create pull request
* Provide title and description of request
* click Create pull request

Merge the request
* Click Pull requests tab
* Select the desired request(s)
* click Merge pull request
* click confirm merge
* delete branch (if desired)

To learn more about the power of Pull Requests, we recommend reading the
GitHub Flow Guide. --->>  https://guides.github.com/introduction/flow/

## Fork from coateds
logon as coateds
* navigate to github.com/dscoate/hello-world
* Click Fork
  * This creates a copy repo in coateds
  * Apparently, this can be cloned and worked on locally
* navigate to github.com/coateds/hello-world
* edit README.md, add a comment, commit changes
* still in github.com/coateds/hello-world, click new pull request.
  * note redirect to dscoate
  * you can navigate to the target side (dscote) directly and do this
* click compare accross forks
* select: base fork dscoate/hello-world - master and head fork: coateds/hello-world - master
* create pull request, add comments, create pull request

logon as dscoate
* there should be a Pull request number increment at the pull request tab, click it
* select/click the pull request from coateds
* click Merge, confirm

Now changes made by coateds are incorporated in dscoate's repo

## Clone
* I can also clone it directly
* however, no access to write to remote (as expected)

Give access (logged on as dscoate)
* Settings, collaborators
* coateds, select, Add Collaborator
* (coateds receives an email and accepts invitation. Now has push access it says)
* At this point, coateds has access to  push to the master branch
* It is possible for the owner to protect some branches. (Maybe protect master so only owner can merge to it?)