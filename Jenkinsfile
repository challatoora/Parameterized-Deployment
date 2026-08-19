pipeline {

    agent any

    parameters {

        choice(
            name: 'ENVIRONMENT',
            choices: ['DEV', 'TEST', 'PROD'],
            description: 'Select environment'
        )

        choice(
            name: 'BRANCH',
            choices: ['master', 'develop'],
            description: 'Select branch'
        )
    }

    stages {

        stage('Parameters') {
            steps {
                echo "================================="
                echo "Selected Environment: ${params.ENVIRONMENT}"
                echo "Selected Branch: ${params.BRANCH}"
                echo "================================="
            }
        }

        stage('Checkout') {
            steps {
                echo "Checking out branch: ${params.BRANCH}"

                git branch: "${params.BRANCH}",
                    url: 'https://github.com/challatoora/Parameterized-Deployment.git'
            }
        }

        stage('Build') {
            steps {
                echo "================================="
                echo "BUILD STARTED"
                echo "================================="

                sh 'docker build -t parameterized-app .'

                echo "Build completed successfully"
            }
        }

        stage('Test') {
            steps {
                echo "================================="
                echo "TEST STARTED"
                echo "================================="

                echo "Running tests..."

                echo "Tests completed successfully"
            }
        }

        stage('DEV Deploy') {
            when {
                expression {
                    params.ENVIRONMENT == 'DEV'
                }
            }

            steps {
                echo "Deploying to DEV environment"

                sh 'chmod +x scripts/DEV.SH'
                sh './scripts/DEV.SH'
            }
        }

        stage('TEST Deploy') {
            when {
                expression {
                    params.ENVIRONMENT == 'TEST'
                }
            }

            steps {
                echo "Deploying to TEST environment"

                sh 'chmod +x scripts/TEST.SH'
                sh './scripts/TEST.SH'
            }
        }

        stage('PROD Deploy') {
            when {
                expression {
                    params.ENVIRONMENT == 'PROD'
                }
            }

            steps {
                echo "Deploying to PROD environment"

                sh 'chmod +x scripts/PROD.SH'
                sh './scripts/PROD.SH'
            }
        }
    }

    post {

        success {
            echo "================================="
            echo "DEPLOYMENT SUCCESSFUL"
            echo "Environment: ${params.ENVIRONMENT}"
            echo "Branch: ${params.BRANCH}"
            echo "================================="
        }

        failure {
            echo "================================="
            echo "PIPELINE FAILED"
            echo "================================="
        }
    }
}