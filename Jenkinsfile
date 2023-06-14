pipeline {
  agent any

  stages {
    stage('Checkout SCM') {
      steps {
        // Checkout your source code from Git
        checkout scm
      }
    }

    stage('Build') {
      steps {
        // Build your Docker image
        sh 'docker build -t sameerchandorkar/jenkins:alpine .'
      }
    }

    stage('Login to Docker Registry') {
      steps {
        // Login to Docker registry using credentials
        withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'DOCKERHUB_PASSWORD', usernameVariable: 'DOCKERHUB_USERNAME')]) {
          sh 'docker login -u $DOCKERHUB_USERNAME -p $DOCKERHUB_PASSWORD'
        }
      }
    }

    stage('Push to Docker Registry') {
      steps {
        // Push Docker image to Docker registry
        sh 'docker push sameerchandorkar/jenkins:alpine'
      }
    }

    stage('Deploy to Kubernetes') {
      steps {
        // Set KUBECONFIG environment variable to the path of the Kubernetes configuration file
        withCredentials([file(credentialsId: 'kubernetes', variable: 'KUBECONFIG_FILE')]) {
          sh 'export KUBECONFIG=$KUBECONFIG_FILE && kubectl apply -f deployment.yaml'
        }
      }
    }
  }
}
