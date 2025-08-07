pipeline {
    agent any
    environment {
        DOCKER_SERVER = credentials('DOCKER_SERVER_IP') // Use Jenkins credentials for sensitive data
        DOCKER_USER = 'ubuntu'
        DOCKER_HUB_REPO = 'akinaregbesola/class_images'
        DOCKER_HUB_CREDENTIALS = 'dockerhub_credentials_id'
        IMAGE_TAG = "${env.BUILD_ID ?: 'latest'}" // Use BUILD_ID for unique tagging or fallback to 'latest'
        SSH_CREDENTIALS_ID = 'SSH_CREDENTIALS_ID'
        REPO_URL = 'https://github.com/theitern/DevopsBasics.git'
    }
    tools {
        jdk 'myjava'
        maven 'mymaven'
    }
    stages {
        stage('Clone Repository') {
            steps {
                echo 'Cloning repository..'
                withCredentials([usernamePassword(credentialsId: 'theitern', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    script {
                        sh "rm -rf \"${env.WORKSPACE}/devops-basics\"" // Remove existing directory if it exists
                        git credentialsId: 'theitern', url: env.REPO_URL, branch: 'master', dir: "${env.WORKSPACE}/devops-basics"
                    }
                }
            }
        }

        stage('Compile') {
            steps {
                echo 'Compiling..'
                dir("${env.WORKSPACE}/devops-basics") {
                    sh 'mvn compile'
                }
            }
        }

        stage('Package') {
            steps {
                echo 'Packaging..'
                dir("${env.WORKSPACE}/devops-basics") {
                    sh 'mvn package'
                }
            }
        }

        stage('Clear Docker Server') {
            steps {
                echo 'Clearing Docker Server..'
                sshagent(credentials: [env.SSH_CREDENTIALS_ID]) {
                    script {
                        def containerIds = sh(
                            script: "ssh -o StrictHostKeyChecking=no ${env.DOCKER_USER}@${env.DOCKER_SERVER} 'docker ps -aq --filter name=our_app_container'",
                            returnStdout: true
                        ).trim()

                        if (containerIds) {
                            sh "ssh -o StrictHostKeyChecking=no ${env.DOCKER_USER}@${env.DOCKER_SERVER} 'docker rm -f ${containerIds}'"
                        } else {
                            echo "No containers to remove."
                        }

                        sh "ssh -o StrictHostKeyChecking=no ${env.DOCKER_USER}@${env.DOCKER_SERVER} 'yes | docker system prune --all'"
                    }
                }
            }
        }

        stage('Copy WAR to Docker Server') {
            steps {
                echo 'Copying WAR to Docker Server..'
                sshagent(credentials: [env.SSH_CREDENTIALS_ID]) {
                    sh """
                        ssh -o StrictHostKeyChecking=no ${env.DOCKER_USER}@${env.DOCKER_SERVER} 'rm -f /home/ubuntu/webapp.war || true'
                        scp -o StrictHostKeyChecking=no "${env.WORKSPACE}/devops-basics/target/webapp.war" ${env.DOCKER_USER}@${env.DOCKER_SERVER}:/home/ubuntu/
                    """
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker Image..'
                sshagent(credentials: [env.SSH_CREDENTIALS_ID]) {
                    sh """
                        scp -o StrictHostKeyChecking=no "${env.WORKSPACE}/devops-basics/Dockerfile" ${env.DOCKER_USER}@${env.DOCKER_SERVER}:/home/ubuntu/
                        scp -o StrictHostKeyChecking=no "${env.WORKSPACE}/devops-basics/target/webapp.war" ${env.DOCKER_USER}@${env.DOCKER_SERVER}:/home/ubuntu/
                        ssh -o StrictHostKeyChecking=no ${env.DOCKER_USER}@${env.DOCKER_SERVER} 'cd /home/ubuntu && docker build -t ${env.DOCKER_HUB_REPO}:${env.IMAGE_TAG} .'
                    """
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                echo 'Pushing Docker Image..'
                sshagent(credentials: [env.SSH_CREDENTIALS_ID]) {
                    withCredentials([usernamePassword(credentialsId: env.DOCKER_HUB_CREDENTIALS, usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh """
                            ssh -o StrictHostKeyChecking=no ${env.DOCKER_USER}@${env.DOCKER_SERVER} 'docker login -u $DOCKER_USERNAME --password-stdin <<< "$DOCKER_PASSWORD"'
                            ssh -o StrictHostKeyChecking=no ${env.DOCKER_USER}@${env.DOCKER_SERVER} 'docker push ${env.DOCKER_HUB_REPO}:${env.IMAGE_TAG}'
                        """
                    }
                }
            }
        }

        stage('Run Docker Image') {
            steps {
                echo 'Running Docker Image..'
                sshagent(credentials: [env.SSH_CREDENTIALS_ID]) {
                    sh """
                        ssh -o StrictHostKeyChecking=no ${env.DOCKER_USER}@${env.DOCKER_SERVER} 'docker run -d --name our_app_container -p 8080:8080 ${env.DOCKER_HUB_REPO}:${env.IMAGE_TAG}'
                    """
                }
            }
        }
    }
    post {
        success {
            echo 'Pipeline succeeded!'
            // Add notifications here (e.g., Slack, email)
        }
        failure {
            echo 'Pipeline failed!'
            // Add failure notifications here
        }
        always {
            echo 'Cleaning up workspace...'
            cleanWs() // Ensure workspace is cleaned up after execution
        }
    }
}
