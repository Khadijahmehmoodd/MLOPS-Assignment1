pipeline {
    environment {
        registryCredential = 'Docker-hubb'
        IMAGE_NAME = 'Khadijahmehmood/mlops-assignment1'
        TAG = 'latest' 
    }
    agent any
    stages {
        stage('Cloning Git Repository') {
            steps {
                git branch: 'master', url: 'https://github.com/Khadijahmehmoodd/mlops-assignment1.git'
            }
        }
        stage('Building our image') {
            steps {
                script {
                    docker.build("${IMAGE_NAME}:${TAG}")
                }
            }
        }
        stage('Deploy our image') {
            steps {
                script {
                    docker.withRegistry('', registryCredential) {
                        docker.image("${IMAGE_NAME}:${TAG}").push()
                    }
                }
            }
        }
    }
    post {
        success {
            emailext(
                to: 'khadijamehmood77@gmail.com',
                subject: 'Build Successful ',
                body: 'The docker image successfully pushed to Dockerhub! Well Done!'
            )
        }
    }
}
