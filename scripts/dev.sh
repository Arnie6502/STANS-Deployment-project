#!/bin/bash

# STANS Navigation System - Development Script
# This script helps with local development and testing

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

# Function to show usage
show_usage() {
    echo "STANS Navigation System - Development Script"
    echo ""
    echo "Usage: ./scripts/dev.sh [command]"
    echo ""
    echo "Commands:"
    echo "  install     Install dependencies"
    echo "  dev         Start development server"
    echo "  build       Build for production"
    echo "  lint        Run linter"
    echo "  docker:build    Build Docker image"
    echo "  docker:run      Run Docker container"
    echo "  docker:stop     Stop Docker container"
    echo "  docker:clean    Remove Docker containers and images"
    echo "  test        Run tests"
    echo "  clean       Clean build artifacts"
    echo "  help        Show this help message"
    echo ""
}

# Check if Node.js is installed
check_node() {
    if ! command -v node &> /dev/null; then
        print_error "Node.js is not installed. Please install Node.js first."
        exit 1
    fi
    print_success "Node.js $(node -v) is installed"
}

# Install dependencies
install_deps() {
    print_info "Installing dependencies..."
    npm install
    print_success "Dependencies installed"
}

# Start development server
start_dev() {
    print_info "Starting development server..."
    npm run dev
}

# Build for production
build_prod() {
    print_info "Building for production..."
    npm run build
    print_success "Build completed"
}

# Run linter
run_lint() {
    print_info "Running linter..."
    npm run lint
    print_success "Linting completed"
}

# Build Docker image
docker_build() {
    if ! command -v docker &> /dev/null; then
        print_error "Docker is not installed. Please install Docker first."
        exit 1
    fi
    
    print_info "Building Docker image..."
    docker build -t stans-app .
    print_success "Docker image built successfully"
}

# Run Docker container
docker_run() {
    if ! command -v docker &> /dev/null; then
        print_error "Docker is not installed. Please install Docker first."
        exit 1
    fi
    
    print_info "Running Docker container..."
    docker run -d -p 8080:80 --name stans-app stans-app
    print_success "Container started. Access at http://localhost:8080"
}

# Stop Docker container
docker_stop() {
    if ! command -v docker &> /dev/null; then
        print_error "Docker is not installed. Please install Docker first."
        exit 1
    fi
    
    print_info "Stopping Docker container..."
    docker stop stans-app 2>/dev/null || print_warning "Container not running"
    docker rm stans-app 2>/dev/null || print_warning "Container not found"
    print_success "Container stopped and removed"
}

# Clean Docker resources
docker_clean() {
    if ! command -v docker &> /dev/null; then
        print_error "Docker is not installed. Please install Docker first."
        exit 1
    fi
    
    print_warning "This will remove all STANS Docker containers and images."
    read -p "Are you sure? (y/N) " -n 1 -r
    echo
    
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        print_info "Cleaning Docker resources..."
        docker stop stans-app 2>/dev/null || true
        docker rm stans-app 2>/dev/null || true
        docker rmi stans-app 2>/dev/null || true
        print_success "Docker resources cleaned"
    else
        print_info "Cleanup cancelled"
    fi
}

# Run tests
run_tests() {
    print_info "Running tests..."
    # Add test command when tests are available
    print_warning "No tests configured yet"
}

# Clean build artifacts
clean_artifacts() {
    print_info "Cleaning build artifacts..."
    rm -rf dist node_modules/.vite
    print_success "Build artifacts cleaned"
}

# Main script logic
case "${1:-help}" in
    install)
        check_node
        install_deps
        ;;
    dev)
        check_node
        start_dev
        ;;
    build)
        check_node
        build_prod
        ;;
    lint)
        check_node
        run_lint
        ;;
    docker:build)
        docker_build
        ;;
    docker:run)
        docker_run
        ;;
    docker:stop)
        docker_stop
        ;;
    docker:clean)
        docker_clean
        ;;
    test)
        check_node
        run_tests
        ;;
    clean)
        clean_artifacts
        ;;
    help|--help|-h)
        show_usage
        ;;
    *)
        print_error "Unknown command: $1"
        echo ""
        show_usage
        exit 1
        ;;
esac
