# Using Jenkins

## Integration with Git
This is an integral part of the CICD pipeline. By storing a Jenkinsfile in a git repository, a multibranch Jenkins project can execute multiple "stages". the first step is granting Jenkins access to your GitHub repo. To do this in (literally GitHub) start with a personal access token.
* In GitHub set up a token
  * settings (drop next to avatar)
  * dev settings
  * personal access tokens
  * Generate new
  * enter pw if required
  * give it a description
  * check box:  admin:repo_hook  (grants read and write)
  * Generate token
  * Be prepared to copy the token string. There will only be one chance to do so
* In Jenkins - There may be a more direct way to do this, I have only seen this one
  * Start a multibranch project
  * Branch Sources, Add source, GitHub
  * Credentials, Add, Jenkins
    * username = GitHub username
    * Password = token string copied from GitHub when that token was set up
    * ID is arbitrary, but remember it, this is how it is accessed `github_key`
    * Description also arbitrary, human readable
    * Add
  * Select the new credential from the credentials dropdown
  * enter the Github account name into Owner
  * If everything worked, the Repository dropdown populates with repos from the GitHub account
  * Save, Jenkins will Scan and 'Build' the project
    * The build will fail if there is not a 'Build' stage in the Jenkinsfile in the repo??
  * Even though this credential was built inside the new multibranch project, it is available on a Global scope
    * It can be reused!

## Integration with docker
Given the methods I use to install docker (not with root/sudo), the Jenkins user needs to be added to the docker group
Two methods for doing this
1. `sudo usermod -a -G docker jenkins`
2. put it in chef solo provisioner called from the Vagrant build

Docker interaction commands can then be put into the Jenkinsfile stored in the GitHub repo used as a Branch Source in a Multibranch project. This is the same file referenced above. Docker will then build an image based on a Dockerfile also in the repo. Information on Dockerfiles are in the UsingDocker.md file. 

## The Jenkinsfile
An example is included below... I am still picking it apart

This stage will build a docker container locally (Jenkins and Docker installed on the same machine)
```
stage('Build Docker Image') {
    when {
        branch 'master'
    }
    steps {
        script {
            app = docker.build("coateds/python-microservice")
            app.inside {
                sh 'echo $(curl localhost:8080)'
            }
        }
    }
}
```

docker.build is supposed to be able to run commands that imply an ability to start and remove containers, etc.  I cannot find a page on the Internet that gives syntax for this.

In the meantime, here is a way to run shell commands to run a container:
```
// stop and remove existing container in try/catch for when there is no container to remove
stage('Run Docker Container') {
    when {
        branch 'master'
    }
    steps {
        script {
            try {
                sh '''
                docker stop python-microservice
                docker rm python-microservice
                '''
            } catch (err) {}
            sh '''
            docker run --name python-microservice -p 80:80 -coateds/python-microservice
            '''
        }
    }
}
```

The following, more complete example can be used to deploy to a docker host other than the one running Jenkins. Useful for when deploying to production

```
pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                echo 'Running build automation'
            }
        }
        stage('Build Docker Image') {
            when {
                branch 'master'
            }
            steps {
                script {
                    app = docker.build("coateds/container-pipeline")
                    app.inside {
                        sh 'echo $(curl localhost:8080)'
                    }
                }
            }
        }
        stage('Push Docker Image') {
            when {
                branch 'master'
            }
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'docker_hub_login') {
                        app.push("${env.BUILD_NUMBER}")
                        app.push("latest")
                    }
                }
            }
        }
        stage('DeployToProduction') {
            when {
                branch 'master'
            }
            steps {
                input 'Deploy to Production?'
                milestone(1)
                withCredentials([usernamePassword(credentialsId: 'webserver_login', usernameVariable: 'USERNAME', passwordVariable: 'USERPASS')]) {
                    script {
                        sh "sshpass -p '$USERPASS' -v ssh -o StrictHostKeyChecking=no $USERNAME@$prod_ip \"docker pull coateds/container-pipeline:${env.BUILD_NUMBER}\""
                        try {
                            sh "sshpass -p '$USERPASS' -v ssh -o StrictHostKeyChecking=no $USERNAME@$prod_ip \"docker stop container-pipeline\""
                            sh "sshpass -p '$USERPASS' -v ssh -o StrictHostKeyChecking=no $USERNAME@$prod_ip \"docker rm container-pipeline\""
                        } catch (err) {
                            echo: 'caught error: $err'
                        }
                        sh "sshpass -p '$USERPASS' -v ssh -o StrictHostKeyChecking=no $USERNAME@$prod_ip \"docker run --restart always --name container-pipeline -p 80:80 -d coateds/container-pipeline:${env.BUILD_NUMBER}\""
                    }
                }
            }
        }        
    }
}  
```