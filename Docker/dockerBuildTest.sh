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
docker build -t api-gateway:1.0 .

# Build the OCR Model Docker image
echo "Building ocr-model Docker image..."
cd "$SCRIPT_DIR/ocr-model" || exit 1
current_dir=$(pwd)
echo "Current directory: $current_dir"
docker build -t ocr-model:1.0 .

# Check if the Docker network 'ocr-network' exists; if not, create it
echo "Checking for existing Docker network 'ocr-network'..."
if ! docker network ls | grep -q "ocr-network"; then
  echo "Creating Docker network 'ocr-network'..."
  docker network create ocr-network
else
  echo "Docker network 'ocr-network' already exists."
fi

# Go back to the base directory and use docker-compose to bring services up
cd "$SCRIPT_DIR" || exit 1

if [ ! -f "docker-compose.yml" ]; then
  echo "Error: docker-compose.yml not found in $SCRIPT_DIR"
  exit 1
fi

echo "Starting services with docker-compose..."
docker compose up -d

