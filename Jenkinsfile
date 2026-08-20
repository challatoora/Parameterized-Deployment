pipeline {
    agent any

    parameters {
        choice(
            name: 'ENVIRONMENT',
            choices: ['dev', 'test', 'prod'],
            description: 'Select the deployment environment'
        )
    }

    environment {
        GIT_REPO = 'https://github.com/challatoora/Parameterized-Deployment.git'
    }

    stages {

        stage('Set Environment') {
            steps {
                script {

                    if (params.ENVIRONMENT == 'dev') {
                        env.BRANCH = 'develop'
                        env.SERVER = '3.226.236.205'
                        env.CREDENTIAL_ID = 'dev-server-credentials'
                        env.SCRIPT = 'scripts/DEV.SH'

                    } else if (params.ENVIRONMENT == 'test') {
                        env.BRANCH = 'main'
                        env.SERVER = '44.202.196.230'
                        env.CREDENTIAL_ID = 'test-server-credentials'
                        env.SCRIPT = 'scripts/TEST.SH'

                    } else if (params.ENVIRONMENT == 'prod') {
                        env.BRANCH = 'main'
                        env.SERVER = '98.92.87.4'
                        env.CREDENTIAL_ID = 'prod-server-credentials'
                        env.SCRIPT = 'scripts/PROD.SH'
                    }

                    echo "========================================"
                    echo "Environment : ${params.ENVIRONMENT}"
                    echo "Branch      : ${env.BRANCH}"
                    echo "Server      : ${env.SERVER}"
                    echo "Script      : ${env.SCRIPT}"
                    echo "========================================"
                }
            }
        }

        stage('Checkout Code') {
            steps {
                echo "Checking out branch: ${env.BRANCH}"

                git(
                    branch: "${env.BRANCH}",
                    credentialsId: 'github-credentials',
                    url: "${env.GIT_REPO}"
                )
            }
        }

        stage('Check Script') {
            steps {
                sh '''
                    echo "Checking script file..."

                    if [ ! -f "$SCRIPT" ]; then
                        echo "ERROR: Script not found: $SCRIPT"
                        exit 1
                    fi

                    echo "Script found: $SCRIPT"
                    ls -l "$SCRIPT"
                '''
            }
        }

        stage('Copy Script to Server') {
            steps {

                withCredentials([
                    usernamePassword(
                        credentialsId: "${env.CREDENTIAL_ID}",
                        usernameVariable: 'SERVER_USER',
                        passwordVariable: 'SERVER_PASSWORD'
                    )
                ]) {

                    sh '''
                        SCRIPT_NAME=$(basename "$SCRIPT")

                        echo "========================================"
                        echo "Copying script to server"
                        echo "Script : $SCRIPT_NAME"
                        echo "Server : $SERVER"
                        echo "========================================"

                        sshpass -p "$SERVER_PASSWORD" scp \
                            -o StrictHostKeyChecking=no \
                            "$SCRIPT" \
                            "$SERVER_USER@$SERVER:/tmp/$SCRIPT_NAME"

                        echo "Script copied successfully"
                    '''
                }
            }
        }

        stage('Execute Script on Server') {
            steps {

                withCredentials([
                    usernamePassword(
                        credentialsId: "${env.CREDENTIAL_ID}",
                        usernameVariable: 'SERVER_USER',
                        passwordVariable: 'SERVER_PASSWORD'
                    )
                ]) {

                    sh '''
                        SCRIPT_NAME=$(basename "$SCRIPT")

                        echo "========================================"
                        echo "Executing script"
                        echo "Script : $SCRIPT_NAME"
                        echo "Server : $SERVER"
                        echo "========================================"

                        sshpass -p "$SERVER_PASSWORD" ssh \
                            -o StrictHostKeyChecking=no \
                            "$SERVER_USER@$SERVER" \
                            "chmod +x /tmp/$SCRIPT_NAME && /tmp/$SCRIPT_NAME"

                        echo "Script executed successfully"
                    '''
                }
            }
        }
    }

    post {
        success {
            echo "========================================"
            echo "       DEPLOYMENT SUCCESSFUL"
            echo "========================================"
            echo "Environment : ${params.ENVIRONMENT}"
            echo "Branch      : ${env.BRANCH}"
            echo "Server      : ${env.SERVER}"
            echo "Script      : ${env.SCRIPT}"
            echo "========================================"
        }

        failure {
            echo "========================================"
            echo "        DEPLOYMENT FAILED"
            echo "========================================"
            echo "Environment : ${params.ENVIRONMENT}"
            echo "========================================"
        }
    }
}