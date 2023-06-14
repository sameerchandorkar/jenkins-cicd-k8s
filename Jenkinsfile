pipeline {
  agent any
  options {
    buildDiscarder(logRotator(numToKeepStr: '5'))
  }
  environment {
    DOCKERHUB_CREDENTIALS = credentials('sameerchandorkar-dockerhub')
    KUBECONFIG_CREDENTIALS = credentials('kubernetes')
  }
  stages {
    stage('Build') {
      steps {
        sh 'docker build -t sameerchandorkar/jenkins:alpine .'
      }
    }
    stage('Login') {
      steps {
        sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
      }
    }
    stage('Push') {
      steps {
        sh 'docker push sameerchandorkar/jenkins:alpine'
        sh 'docker logout'
      }
    }
    stage('Deploy to Kubernetes') {
      steps {
        withCredentials([file(credentialsId: 'kubernetes', variable: 'KUBECONFIG_FILE')]) {
          sh 'kubectl --kubeconfig=$KUBECONFIG_FILE apply -f deployment.yaml' // Replace with your deployment configuration file
        }
      }
    }
  }
}
