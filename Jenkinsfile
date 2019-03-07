#!groovy

pipeline {
  agent {
    // dockerfile isn't working, you must build and push docker image before
    // running this pipeline
    docker {
      // Node label
      label 'docker'

      image 'docker.io/manics/jenkins-pipeline-bumpversion-example'
    }
  }

  stages {
    stage('Build') {
      steps {
        sh 'git config user.name "Jenkins Pipeline"'
        sh 'git config user.email jenkins@localhost'
        echo 'Current version:'
        sh 'grep "Version: " README.md'
        sh 'env'
        //stash 'workspace'
      }
    }

    stage('Tag') {
      options {
        timeout(time: 30, unit: 'MINUTES')
      }
      when {
        expression { env.GIT_BRANCH == 'origin/master' }
      }
      // input {
      //   message "Would you like to tag this repository?"
      //   ok "Tag and push"
      //   parameters {
      //     choice(
      //       name: 'BUMP',
      //       choices: "major\nminor\npatch\nrelease",
      //       description: 'Component to bump'
      //     )
      //   }
      // }
      steps {
        //unstash 'workspace'
        withCredentials([sshUserPrivateKey(credentialsId: 'github-push', keyFileVariable: 'keyfile')]) {
          sh 'mkdir -p ~/.ssh && cp ${keyfile} ~/.ssh/id_rsa'
        }
        sh 'git remote -v'
        sh 'git show-ref'
        // Change https:// to SSH URL so we can push with a deploy key
        sh 'git remote set-url origin `git remote get-url origin | sed -re "s%.+/([^/]+)/([^/]+)$%git@github.com:\\1/\\2%"`'
        //sh 'bumpversion ${BUMP}'
        sh 'bumpversion minor'
        sh 'git log -p -2'
        //sh 'git push origin master'
        sh 'git push origin refs/remotes/origin/master'
        sh 'git push origin --tags'
      }
    }
  }
  post {
    always {
        echo 'Cleaning workspace'
        deleteDir()
    }
  }
}
