pipeline {
    agent any

    parameters {
        choice(
            name: 'ENVIRONMENT',
            choices: ['dev', 'test', 'prod'],
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

                    def selectedEnv = params.ENVIRONMENT.toUpperCase()

                    if (selectedEnv == 'DEV') {
                        env.BRANCH = 'develop'
                    } else {
                        env.BRANCH = 'main'
                    }

                    env.DEPLOY_ENV = selectedEnv

                    echo "================================"
                    echo "Environment : ${env.DEPLOY_ENV}"
                    echo "Git Branch  : ${env.BRANCH}"
                    echo "================================"
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
        stage('Docker Build') {
            steps {
                script {
                    def envName = env.DEPLOY_ENV.toLowerCase()
                    def imageName = "parameterized-${envName}"

                    sh """
                        echo "================================"
                        echo "DOCKER BUILD"
                        echo "================================"

                        docker build --no-cache \
                            --build-arg ENVIRONMENT=${env.DEPLOY_ENV} \
                            -t ${imageName} .

                        echo "Docker image created:"
                        docker images ${imageName}
                    """
                }
            }
        }

        stage('Docker Deploy') {
            steps {
                script {

                    def envName = env.DEPLOY_ENV.toLowerCase()

                    def containerName = "${envName}-container"

                    def imageName = "parameterized-${envName}"

                    def port

                    if (env.DEPLOY_ENV == 'DEV') {
                        port = '8090'
                    } else if (env.DEPLOY_ENV == 'TEST') {
                        port = '8091'
                    } else {
                        port = '8092'
                    }

                    echo "================================"
                    echo "${env.DEPLOY_ENV} DEPLOYMENT"
                    echo "================================"

                    sh """
                        echo "Removing old container..."

                        docker rm -f ${containerName} 2>/dev/null || true

                        echo "Removing old image..."

                        docker rmi -f ${imageName} 2>/dev/null || true

                        echo "Building Docker image..."

                        docker build --no-cache \
                            --build-arg ENVIRONMENT=${env.DEPLOY_ENV} \
                            -t ${imageName} .

                        echo "Starting container..."

                        docker run -d \
                            --name ${containerName} \
                            -p ${port}:80 \
                            ${imageName}

                        echo "================================"
                        echo "DEPLOYMENT COMPLETED"
                        echo "================================"

                        echo "Container status:"

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
            echo "================================"
            echo "${params.ENVIRONMENT} DEPLOYMENT SUCCESSFUL"
            echo "================================"
        }

        failure {
            echo "================================"
            echo "${params.ENVIRONMENT} DEPLOYMENT FAILED"
            echo "================================"
        }
    }
}