## Set up the credential file:
* https://github.com/pendrica/azure-credentials (Author says this is old)
* Newer:  https://gist.github.com/binamov/57b187c77833d70e7928ecf56235d8df
* @stuartpreston on the #azure channel

## Publishing web projects from Visual Studio Code to Azure with Git
* https://www.eliostruyf.com/publishing-web-projects-from-visual-studio-code-to-azure-with-git/
* The way to achieve it is via the continuous deployment functionality of a Web App. With this option you can connect a source control system to your site in order to push updates.
  * From portal.azure.com
  * Select the web app
  * Select Deployment Options
  * Source
  * Local Git Repository
  * Screech!!! - Start Again

Create a Test WebApp
* dcoatetest.azurewebsites.net
* Click it
* deployment options
* Config req settings
* Local Git Repo
* Basic Auth: coateds  ->  P@ssw0rd
* Succeeded?   --  NO!!!

Try this: https://docs.microsoft.com/en-us/azure/app-service-web/app-service-deploy-local-git