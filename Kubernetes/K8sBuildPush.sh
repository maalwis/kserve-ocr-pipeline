#!/bin/bash

# Get the directory where this script resides
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "Running from: $SCRIPT_DIR"

# Check if api-gateway and ocr-model folders exist
if [ ! -d "$SCRIPT_DIR/api-gateway" ] || [ ! -d "$SCRIPT_DIR/ocr-model" ]; then
  echo "Error: Either 'api-gateway' or 'ocr-model' folder is missing in $SCRIPT_DIR"
  exit 1
fi

# Build the API Gateway Docker image
echo "Building api-gateway Docker image..."
cd "$SCRIPT_DIR/api-gateway" || exit 1
current_dir=$(pwd)
echo "Current directory: $current_dir"
docker build -t api-gateway:2.0 .

# Build the OCR Model Docker image
echo "Building ocr-model Docker image..."
cd "$SCRIPT_DIR/ocr-model" || exit 1
current_dir=$(pwd)
echo "Current directory: $current_dir"
docker build -t ocr-model:2.0 .

# Source the .env file to load environment variables
source .env


# Perform login
echo "$DOCKER_PAT" | docker login -u $username --password-stdin



# Tag images with Docker Hub username
docker tag api-gateway:2.0 maalwis/k8s-api-gateway:2.0
docker tag ocr-model:2.0 maalwis/k8s-ocr-model:2.0

# Push the image k8s-api-gateway:2.0
echo "Pushing k8s-api-gateway:2.0 to Docker Hub..."
docker push maalwis/k8s-api-gateway:2.0
echo "images maalwis/k8s-api-gateway:2.0 pushed" 

# Push the image k8s-aocr-model:2.0
echo "Pushing ocr-model:2.0 to Docker Hub..."
docker push maalwis/k8s-ocr-model:2.0
echo "images maalwis/k8s-ocr-model:2.0 pushed"
