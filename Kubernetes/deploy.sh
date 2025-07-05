#!/bin/bash

# Get the directory where this script resides
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "Running from: $SCRIPT_DIR"

# Check if K8s folder exist
if [ ! -d "$SCRIPT_DIR/K8s" ]; then
  echo "Error: Either K8s folder is missing in $SCRIPT_DIR"
  exit 1
fi

# deploy ocr-model
echo "deploying ocr-model service and deployment..."
cd "$SCRIPT_DIR/K8s" || exit 1
current_dir=$(pwd)
echo "Current directory: $current_dir"
kubectl apply -f ocr-model.yaml

# deploy api-gateway
echo "deploying api-gateway service and deployment..."
cd "$SCRIPT_DIR/K8s" || exit 1
current_dir=$(pwd)
echo "Current directory: $current_dir"
kubectl apply -f api-gateway.yaml

