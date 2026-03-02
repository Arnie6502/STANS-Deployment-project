#!/bin/bash

# STANS Navigation System - Deployment Script
# This script automates the deployment process

set -e  # Exit on error

# Configuration
IMAGE_NAME="stans-app"
CONTAINER_NAME="stans-app"
PORT="80"
REGISTRY="ghcr.io"
REPO_NAME="${1:-YOUR_USERNAME/STANS}"

echo "🚀 Starting STANS deployment..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    print_error "Docker is not installed. Please install Docker first."
    exit 1
fi

print_success "Docker is installed"

# Pull latest image
echo "📥 Pulling latest image from ${REGISTRY}/${REPO_NAME}..."
docker pull ${REGISTRY}/${REPO_NAME}:latest
print_success "Image pulled successfully"

# Stop and remove existing container
if docker ps -a --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
    echo "🛑 Stopping existing container..."
    docker stop ${CONTAINER_NAME} || true
    docker rm ${CONTAINER_NAME} || true
    print_success "Existing container removed"
fi

# Run new container
echo "🏃 Starting new container..."
docker run -d \
    --name ${CONTAINER_NAME} \
    --restart=always \
    -p ${PORT}:80 \
    ${REGISTRY}/${REPO_NAME}:latest

print_success "Container started successfully"

# Wait for container to be healthy
echo "⏳ Waiting for container to be healthy..."
sleep 5

# Check container status
if docker ps --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
    print_success "Container is running"
    
    # Test health endpoint
    if curl -f http://localhost/health &> /dev/null; then
        print_success "Health check passed"
    else
        print_warning "Health check endpoint not responding, but container is running"
    fi
else
    print_error "Container failed to start"
    docker logs ${CONTAINER_NAME}
    exit 1
fi

# Clean up old images
echo "🧹 Cleaning up old images..."
docker image prune -af --filter "until=72h"
print_success "Cleanup completed"

echo ""
echo "🎉 Deployment completed successfully!"
echo "📱 Application is available at: http://localhost:${PORT}"
echo "📊 View logs with: docker logs -f ${CONTAINER_NAME}"
