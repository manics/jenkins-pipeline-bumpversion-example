#!groovy

pipeline {
  agent {
    dockerfile {
      // Node label
      label 'docker'
    }
  }

  stages {
    stage('Build') {
      steps {
        sh 'git config user.name "Jenkins Pipeline"'
        sh 'git config user.email jenkins@localhost'
        echo 'Current version:'
        sh 'grep "Version: " README.md'
        //stash 'workspace'
      }
    }

    stage('Tag') {
      options {
        timeout(time: 30, unit: 'MINUTES')
      }
      when {
        expression { env.BRANCH_NAME == 'master' }
      }
      input {
        message "Would you like to tag this repository?"
        ok "Tag and push"
        parameters {
          choice(
            name: 'BUMP',
            choices: "major\nminor\npatch\nrelease",
            description: 'Component to bump'
            )
          }
        }
        steps {
          //unstash 'workspace'
          withCredentials([sshUserPrivateKey(credentialsId: 'github-push', keyFileVariable: 'keyfile')]) {
            sh 'mkdir -p ~/.ssh && cp ${keyfile} ~/.ssh/id_rsa'
          }
          // Change https:// to SSH URL so we can push with a deploy key
          sh 'git remote set-url origin `git remote get-url origin | sed -re "s%.+/([^/]+)/([^/]+)$%git@github.com:\1/\2%"`'
          sh 'bumpversion ${BUMP}'
          sh 'git push origin master'
        }
      }
    }
  }
