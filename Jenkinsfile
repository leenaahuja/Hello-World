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
   // stage('Deploy Docker Image') {
     // steps {
	//container('docker') {
		// sh script: 'docker push leenaahuja/hello-world:latest'
		// withDockerRegistry([ credentialsId: 'DOCKER_HUB_CRED', url: 'https://registry.hub.docker.com']){
		//	sh script: 'docker push leenaahuja/hello-world:latest'
		// }
		
	//	docker.withRegistry( '', DOCKER_HUB_CRED ) {
	//		sh script: 'docker push leenaahuja/pipeline-test:latest'
	//	}
     //   }
    //  }
    //}
  }
}
