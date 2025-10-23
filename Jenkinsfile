pipeline {
    // 1. Where to run the pipeline
    agent any 

    // 2. Define variables for the whole pipeline
    environment {
        IMAGE_NAME     = "my-nodejs-api"
        CONTAINER_NAME = "my-nodejs-api-container"
    }

    // 3. Define the steps
    stages {

        // STAGE 1: Get the code from GitHub
        stage('Checkout') {
            steps {
                echo 'Checking out code from Git...'
                // This command is built-in to the Jenkins Git plugin
                checkout scm
            }
        }

        // STAGE 2: Build the Docker image
        stage('Build Docker Image') {
            steps {
                script {
                    echo "Building Docker image: ${IMAGE_NAME}:${env.BUILD_NUMBER}"

                    // Build the image and tag it with the build number (e.g., "my-nodejs-api:1")
                    sh "docker build -t ${IMAGE_NAME}:${env.BUILD_NUMBER} ."

                    // Also tag this new build as 'latest' for easy deployment
                    sh "docker tag ${IMAGE_NAME}:${env.BUILD_NUMBER} ${IMAGE_NAME}:latest"
                }
            }
        }

        // STAGE 3: Deploy by running the new container
        stage('Deploy Container') {
            steps {
                script {
                    echo "Deploying new container..."

                    // Stop and remove any OLD container with the same name.
                    // '|| true' ensures the command doesn't fail if the container doesn't exist.
                    sh "docker stop ${CONTAINER_NAME} || true"
                    sh "docker rm ${CONTAINER_NAME} || true"

                    // Run the NEW container from the 'latest' image we just built
                    // -d: runs in detached (background) mode
                    // -p 3000:3000: maps port 3000 on your computer to port 3000 in the container
                    sh "docker run -d -p 3000:3000 --name ${CONTAINER_NAME} ${IMAGE_NAME}:latest"
                }
            }
        }
    }

    // 4. Run this after the pipeline finishes
    post {
        success {
            echo 'Pipeline completed successfully.'
            // This is good practice to clean up old, untagged images
            sh 'docker image prune -f'
        }
        failure {
            echo 'Pipeline failed. Check the logs.'
        }
    }
}