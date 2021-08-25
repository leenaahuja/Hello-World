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
    
  containers:
  - name: node
    image: 'node:latest'
    
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
  }
}
