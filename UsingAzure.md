# Using Azure

## Set up the credential file:
* https://github.com/pendrica/azure-credentials (Author says this is old)
* Newer:  https://gist.github.com/binamov/57b187c77833d70e7928ecf56235d8df
* @stuartpreston on the #azure channel

## Azure Testing
Test Web Apps
* dcoatetest.azurewebsites.net
* dcoatetest1.azurewebsites.net

## Working processes for a simple static web site
Try this: https://docs.microsoft.com/en-us/azure/app-service-web/app-service-deploy-local-git
* This works!
* git remote add azure https://<username>@localgitdeployment.scm.azurewebsites.net:443/localgitdeployment.git
* git push azure master

Is it possible to do a git clone this way. The first time I tried this, it did not work, but the contents were empty
* https://coateds@dcoatetest.scm.azurewebsites.net:443/dcoatetest.git
* yes, it is possible to git clone, apparently there just needs to be some content.

So the Azure Website creation and connect to git process is just a bit different.
* Create the web site
  * portal.azure.com
  * New, Web + Mobile, Web App
  * Name it, subscription, Resource Group (been using Default-Networking), OS, App Svc Plan
    * Svc plan is where you select pricing plan
    * dcoate test is free West US, use that for now
  * Select Pin to Dashboard
  * Create
* Set up Deployment via Git
  * Click the web site on the dashboard
  * Deployment options
  * Configure required settings
  * Local Git Repository
  * OK
* Now when open the Web App from the Dashboard, there is a Git clone url
* Also note the Deployment credentials option
  * There is one deployment PW for Git/FTP deployments for the subscription
* It does not seem to be possible to `git clone` a new, empty Azure Web App
  * Create a new Git repository with the same name as the web app
  * use `git init`
  * Create some content. (Index.html, for instance)
  * `git add` and `git commit`
  * in the properties of the Web App on the portal, locate the CloneURL
  * `git remote add origin [CloneURL]`
* This puts content into the web app and a normal git clone will work with the CloneURL




To reset the Deployment PW
* Install the Azure CLI (az cli)
  * install from https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest
  * azure-cli-2.0.17.msi
  * run from cmd (from PS too?)
  * `az login`
  * follow the prompts
* `az webapp deployment user set --user-name [your deployment user] --password [your new password]`