pipeline {
    agent any

    environment {
        // Docker Hub credentials ID and image name
        DOCKER_CREDENTIALS_ID = 'Docker-hub'
        IMAGE_NAME = 'khadijahmehmood/mlopsassignment'
        IMAGE_TAG = 'latest' 
    }

    stages {
        stage('Checkout') {
            steps {
                // Check out the source code
                checkout scm
            }
        }

        stage('Build and Push Docker Image') {
            steps {
                script {
                    // Log in to Docker Hub
                    docker.withRegistry('https://index.docker.io/v1/', DOCKER_CREDENTIALS_ID) {
                        // Build the Docker image
                        def app = docker.build("${IMAGE_NAME}:${IMAGE_TAG}", "-f Dockerfile .")
                        // Push the image to Docker Hub
                        app.push()
                    }
                }
            }
        }


    }

    post {
        success {
            // Send an email notification on successful build
            mail to: 'i201791@nu.edu.pk',
                 subject: "Successful Deployment: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                 body: "A new Docker image has been pushed to Docker Hub: ${IMAGE_NAME}:${IMAGE_TAG}."
        }
        failure {
            // Send an email notification on failure
            mail to: 'i201791@nu.edu.pk',
                 subject: "Failed Deployment: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                 body: "The build or deployment has failed. Please check Jenkins for more details."
        }
    }


}