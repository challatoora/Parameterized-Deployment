pipeline {
    agent any

    parameters {
        choice(
            name: 'ENVIRONMENT',
            choices: ['DEV', 'TEST', 'PROD'],
            description: 'Select environment'
        )
    }

    environment {
        GIT_URL = 'https://github.com/challatoora/Parameterized-Deployment.git'
    }

    stages {

        stage('Select Branch') {
            steps {
                script {
                    if (params.ENVIRONMENT == 'DEV') {
                        env.BRANCH = 'develop'
                    } else {
                        env.BRANCH = 'main'
                    }

                    echo "Environment: ${params.ENVIRONMENT}"
                    echo "Git Branch: ${env.BRANCH}"
                }
            }
        }

        stage('Git Checkout') {
            steps {
                echo "Checking out ${env.BRANCH} branch"

                git(
                    branch: "${env.BRANCH}",
                    url: "${env.GIT_URL}"
                )

                sh '''
                    echo "================================"
                    echo "GIT INFORMATION"
                    echo "================================"

                    git branch --show-current
                    git log -1 --oneline
                    git status
                '''
            }
        }

        stage('Docker Deploy') {
            steps {
                script {

                    def envName = params.ENVIRONMENT.toLowerCase()

                    def containerName = "${envName}-container"

                    def imageName = "parameterized-${envName}"

                    def port

                    if (params.ENVIRONMENT == 'DEV') {
                        port = '8081'
                    } else if (params.ENVIRONMENT == 'TEST') {
                        port = '8082'
                    } else {
                        port = '8083'
                    }

                    echo "================================"
                    echo "${params.ENVIRONMENT} DEPLOYMENT"
                    echo "================================"

                    sh """
                        echo "Removing old container..."

                        docker rm -f ${containerName} 2>/dev/null || true

                        echo "Removing old image..."

                        docker rmi -f ${imageName} 2>/dev/null || true

                        echo "Building Docker image..."

                        docker build --no-cache \
                            --build-arg ENVIRONMENT=${params.ENVIRONMENT} \
                            -t ${imageName} .

                        echo "Starting container..."

                        docker run -d \
                            --name ${containerName} \
                            -p ${port}:80 \
                            ${imageName}

                        echo "================================"
                        echo "DEPLOYMENT COMPLETED"
                        echo "================================"

                        echo "Container:"
                        docker ps --filter name=${containerName}

                        echo "Application content:"
                        docker exec ${containerName} \
                            cat /usr/share/nginx/html/index.html
                    """
                }
            }
        }
    }

    post {
        success {
            echo "${params.ENVIRONMENT} deployment successful"
        }

        failure {
            echo "${params.ENVIRONMENT} deployment failed"
        }
    }
}