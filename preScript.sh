#!/bin/bash

# Configuration
APP_NAME="calculadora"
DOCKERFILE_PATH="/home/ubuntu/deploy/Dockerfile"
IMAGE_TAG="latest"
CONTAINER_NAME="${APP_NAME}"

# Build the Docker image
echo "Building Docker image..."
docker build --build-arg data1=2 --build-arg data2=2 -t ${APP_NAME}:${IMAGE_TAG} -f ${DOCKERFILE_PATH} /home/ubuntu/deploy --no-cache

if [ $? -ne 0 ]; then
  echo "Docker build failed!"
  exit 1
fi