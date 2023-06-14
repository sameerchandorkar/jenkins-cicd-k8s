pipeline {
  agent any
  options {
    buildDiscarder(logRotator(numToKeepStr: '5'))
  }
  environment {
    DOCKERHUB_CREDENTIALS = credentials('sameerchandorkar-dockerhub')
    KUBECONFIG = credentials('kubenetes')
  }
  stages {
    stage('Build') {
      steps {
        sh 'docker build -t sameerchandorkar/jenkins:alpine .'
      }
    }
    stage('Login to Docker Registry') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'sameerchandorkar-dockerhub', usernameVariable: 'DOCKERHUB_USERNAME', passwordVariable: 'DOCKERHUB_PASSWORD')]) {
          sh 'echo $DOCKERHUB_PASSWORD | docker login -u $DOCKERHUB_USERNAME --password-stdin'
        }
      }
    }
    stage('Push to Docker Registry') {
      steps {
        sh 'docker push sameerchandorkar/jenkins:alpine'
        sh 'docker logout'
      }
    }
    stage('Deploy to Kubernetes') {
      steps {
        withCredentials([file(credentialsId: 'kubenetes', variable: 'KUBECONFIG_FILE')]) {
          sh '''
            cp $KUBECONFIG_FILE kubeconfig.yaml
            kubectl --kubeconfig=kubeconfig.yaml apply -f deployment.yaml
          '''
        }
      }
    }
  }
}
