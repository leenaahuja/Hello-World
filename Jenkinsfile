import groovy.transform.Field
import groovy.json.JsonOutput
def podLabel = "${UUID.randomUUID().toString()}"

pipeline {
  agent {
    kubernetes {
      		label podLabel
		yaml """
apiVersion: v1
kind: Pod
metadata:
spec:
  volumes:
  - name: dockermount
    hostPath:
     path: /var/run/docker.sock
  containers:
  - name: sapmachine
    image: gradle:4.7.0-jdk8-alpine
    command:
    - cat
    tty: true
  - name: node
    image: 'node:latest'
    command:
    - cat
    tty: true
  - name: docker
    image: docker:18.09
    
    volumeMounts:
    - name: dockermount
      mountPath: /var/run/docker.sock
    command:
    - cat
    tty: true
"""
    }
  }
  stages {
    stage('Build') {
      steps {
	container('node') {
		sh 'npm install'
        }
      }
    }
    stage('Build Docker Image') {
      steps {
	container('docker') {
		sh script: 'docker build -t hello-world/v1 .'
        }
      }
    }	  
  }
}
