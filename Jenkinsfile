#!groovy

pipeline {
  agent {
    docker {
      // Node label
      label 'docker'

      dockerfile true
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
            sh "mkdir -p ~/.ssh && cp ${keyfile} ~/.ssh/id_rsa" other_stuff
          }
          sh 'bumpversion ${BUMP}'
          sh 'git push origin master'
        }
      }
    }
  }
