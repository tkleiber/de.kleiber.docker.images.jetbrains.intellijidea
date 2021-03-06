pipeline {
  agent {
    node {
      label 'localhost_vagrant'
    }

  }
  options {
    buildDiscarder(logRotator(numToKeepStr:'10'))
  }
  stages {
    stage('Build JetBrains IntelliJ IDEA Development Image') {
      steps {
        sh 'if [ ! -f $SW_FILE1 ]; then cp "$SW_DIR/$SW_FILE1" $SW_FILE1; fi'
        sh 'if [ ! -f $SW_FILE2 ]; then cp "$SW_DIR/$SW_FILE2" $SW_FILE2; fi'
        withCredentials([usernamePassword(credentialsId: 'store.docker', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
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
    SW_FILE1 = 'ideaIC-2018.1.2.tar.gz'
    SW_FILE2 = 'ideaIU-2018.1.2.tar.gz'
    SW_DIR = '/software/intellijidea'
  }
}
