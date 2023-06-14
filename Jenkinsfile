pipeline {
  agent any
  options {
    buildDiscarder(logRotator(numToKeepStr: '5'))
  }
  description "Pipeline for building and deploying Docker image to Kubernetes"

  environment {
    DOCKERHUB_CREDENTIALS = credentials('sameerchandorkar-dockerhub')
    KUBECONFIG_CREDENTIALS = credentials('kubernetes')
  }
  
  stages {
    stage('Build') {
      description "Build Docker image"
      steps {
        sh 'docker build -t sameerchandorkar/jenkins:alpine .'
      }
    }
    
    stage('Login') {
      description "Login to Docker Hub"
      steps {
        sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
      }
    }
    
    stage('Push') {
      description "Push Docker image to Docker Hub"
      steps {
        sh 'docker push sameerchandorkar/jenkins:alpine'
        sh 'docker logout'
      }
    }
    
    stage('Deploy to Kubernetes') {
      description "Deploy to Kubernetes cluster"
      steps {
        withCredentials([file(credentialsId: 'kubernetes', variable: 'KUBECONFIG_FILE')]) {
          sh 'kubectl --kubeconfig=$KUBECONFIG_FILE apply -f deployment.yaml' // Replace with your deployment configuration file
        }
      }
    }
  }
}
