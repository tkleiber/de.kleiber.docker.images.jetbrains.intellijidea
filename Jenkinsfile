pipeline {
  agent {
    node {
      label 'docker_in_docker'
    }
  }
  options {
    buildDiscarder logRotator(numToKeepStr: '1')
  }
  stages {
    stage('Build JetBrains IntelliJ IDEA Development Image') {
      steps {
        sh 'if [ ! -f $SW_FILE1 ]; then cp "$SW_DIR/$SW_FILE1" $SW_FILE1; fi'
        sh 'if [ ! -f $SW_FILE2 ]; then cp "$SW_DIR/$SW_FILE2" $SW_FILE2; fi'
        withCredentials([usernamePassword(credentialsId: 'docker_hub_id', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
          sh '''docker login --username $USERNAME --password $PASSWORD
docker build --tag tkleiber/intellijidea:$SW_VERSION --build-arg SW_FILE1=$SW_FILE1 --build-arg SW_FILE2=$SW_FILE2 .'''
        }
      }
    }
    stage('Push Docker Image to Local Registry') {
      steps {
        sh 'docker tag tkleiber/intellijidea:$SW_VERSION localhost:5000/tkleiber/intellijidea:$SW_VERSION'
        sh 'docker push localhost:5000/tkleiber/intellijidea:$SW_VERSION'
      }
    }
    stage('Cleanup') {
      steps {
        sh 'docker rmi --force localhost:5000/tkleiber/intellijidea:$SW_VERSION'
        sh 'docker rmi --force tkleiber/intellijidea:$SW_VERSION'
      }
    }
  }
  environment {
    SW_VERSION = '2018.1.2'
    SW_FILE1 = 'ideaIC-2021.3.1.tar.gz'
    SW_FILE2 = 'ideaIU-2021.3.1.tar.gz'
    SW_DIR = '/software/saved/IntelliJ'
  }
}
