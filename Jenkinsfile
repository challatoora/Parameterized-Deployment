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
                    url: 'YOUR_GITHUB_REPOSITORY_URL'
            }
        }

        stage('Build') {
            steps {
                echo "================================="
                echo "Build started"
                echo "Build completed successfully"
                echo "================================="
            }
        }

        stage('Test') {
            steps {
                sh 'chmod +x scripts/test.sh'
                sh './scripts/test.sh'
            }
        }

        stage('DEV Deploy') {
            when {
                expression {
                    params.ENVIRONMENT == 'DEV'
                }
            }

            steps {
                sh 'chmod +x scripts/dev.sh'
                sh './scripts/dev.sh'
            }
        }

        stage('TEST Deploy') {
            when {
                expression {
                    params.ENVIRONMENT == 'TEST'
                }
            }

            steps {
                sh 'chmod +x scripts/test.sh'
                sh './scripts/test.sh'
            }
        }

        stage('PROD Deploy') {
            when {
                expression {
                    params.ENVIRONMENT == 'PROD'
                }
            }

            steps {
                sh 'chmod +x scripts/prod.sh'
                sh './scripts/prod.sh'
            }
        }
    }

    post {
        success {
            echo "Deployment completed successfully"
            echo "Environment: ${params.ENVIRONMENT}"
            echo "Branch: ${params.BRANCH}"
        }

        failure {
            echo "Pipeline failed"
        }
    }
}