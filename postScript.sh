#!/bin/bash

# Configuration
APP_NAME="calculadora"
DOCKERFILE_PATH="/home/ubuntu/deploy/Dockerfile"
IMAGE_TAG="latest"
CONTAINER_NAME="${APP_NAME}"

# Stop and remove existing container (if any)
echo "Stopping and removing existing container..."
docker stop ${CONTAINER_NAME} > /dev/null 2>&1
docker rm ${CONTAINER_NAME} > /dev/null 2>&1

# Run the Docker container
echo "Running Docker container..."
docker run -d --name ${CONTAINER_NAME} ${APP_NAME}:${IMAGE_TAG}

if [ $? -ne 0 ]; then
  echo "Docker run failed!"
  exit 1
fi

echo "Deployment successful!"