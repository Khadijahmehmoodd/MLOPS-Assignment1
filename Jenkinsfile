pipeline {
    agent any
    
    stages {
        stage('Code Quality Check') {
            steps {
                // Check code quality using flake8
                bat 'flake8 .'
            }
        }
        stage('Merge to Dev Branch') {
            when {
                branch 'main'
            }
            steps {
                // Merge changes to dev branch
                bat 'git checkout dev && git merge main && git push origin dev'
            }
        }
        stage('Unit Testing') {
            when {
                branch 'dev'
            }
            steps {
                // Run unit tests
                bat 'python -m pytest _test.py'
            }
        }
        stage('Merge to Test Branch') {
            when {
                branch 'dev'
            }
            steps {
                // Merge changes to test branch
                bat 'git checkout test && git merge dev && git push origin test'
            }
        }
        stage('Merge to Master Branch and Build Docker Image') {
            when {
                branch 'test'
            }
            steps {
                // Merge changes to master branch
                bat 'git checkout master && git merge test && git push origin master'
                
                // Build Docker image
                script {
                    docker.build("your-image-name:latest")
                }
            }
        }
        stage('Push Docker Image to Registry') {
            when {
                branch 'master'
            }
            steps {
                // Push Docker image to Docker Hub or any other registry
                script {
                    docker.withRegistry('https://registry.example.com', 'registry-credentials') {
                        docker.image("your-image-name:latest").push()
                    }
                }
            }
        }
        stage('Email Notification') {
            when {
                branch 'master'
            }
            steps {
                // Send email notification to administrator
                emailext (
                    to: 'i200970@nu.edu.com',
                    subject: 'Jenkins Job Completed Successfully',
                    body: 'The Jenkins job for building and pushing Docker image has completed successfully.'
                )
            }
        }
    }
}
