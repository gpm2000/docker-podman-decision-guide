#!/bin/bash

# Docker vs Podman Decision Guide - Build Script
# This script builds and runs the containerized decision guide

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
IMAGE_NAME="docker-podman-decision-guide"
IMAGE_TAG="latest"
CONTAINER_NAME="decision-guide-app"
HOST_PORT="8080"
CONTAINER_PORT="80"

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Detect container runtime
detect_runtime() {
    if command -v podman &> /dev/null; then
        if command -v docker &> /dev/null; then
            print_warning "Both Docker and Podman detected. Choose your runtime:"
            echo "1) Podman (recommended for this presentation!)"
            echo "2) Docker"
            read -p "Enter choice (1-2): " choice
            case $choice in
                1) RUNTIME="podman" ;;
                2) RUNTIME="docker" ;;
                *) print_error "Invalid choice. Defaulting to Podman."; RUNTIME="podman" ;;
            esac
        else
            RUNTIME="podman"
        fi
    elif command -v docker &> /dev/null; then
        RUNTIME="docker"
    else
        print_error "Neither Docker nor Podman found. Please install one of them."
        exit 1
    fi
    print_status "Using $RUNTIME as container runtime"
}

# Check if port is in use
check_port() {
    if lsof -i :$HOST_PORT &> /dev/null; then
        print_warning "Port $HOST_PORT is already in use."
        read -p "Enter a different port number: " HOST_PORT
        print_status "Using port $HOST_PORT"
    fi
}

# Create directory structure
setup_directories() {
    print_status "Setting up directory structure..."
    mkdir -p src
    print_success "Directory structure created"
}

# Build the container image
build_image() {
    print_status "Building container image with $RUNTIME..."
    
    if $RUNTIME build -t $IMAGE_NAME:$IMAGE_TAG .; then
        print_success "Image built successfully: $IMAGE_NAME:$IMAGE_TAG"
    else
        print_error "Failed to build image"
        exit 1
    fi
}

# Stop and remove existing container
cleanup_container() {
    print_status "Checking for existing container..."
    
    if $RUNTIME ps -q --filter "name=$CONTAINER_NAME" | grep -q .; then
        print_warning "Stopping existing container: $CONTAINER_NAME"
        $RUNTIME stop $CONTAINER_NAME
    fi
    
    if $RUNTIME ps -aq --filter "name=$CONTAINER_NAME" | grep -q .; then
        print_warning "Removing existing container: $CONTAINER_NAME"
        $RUNTIME rm $CONTAINER_NAME
    fi
}

# Run the container
run_container() {
    print_status "Starting container..."
    
    if $RUNTIME run -d \
        --name $CONTAINER_NAME \
        -p $HOST_PORT:$CONTAINER_PORT \
        --restart unless-stopped \
        $IMAGE_NAME:$IMAGE_TAG; then
        print_success "Container started successfully!"
        print_success "Access the presentation at: http://localhost:$HOST_PORT"
    else
        print_error "Failed to start container"
        exit 1
    fi
}

# Wait for container to be ready
wait_for_container() {
    print_status "Waiting for container to be ready..."
    
    for i in {1..30}; do
        if curl -s http://localhost:$HOST_PORT/health &> /dev/null; then
            print_success "Container is ready and healthy!"
            return 0
        fi
        sleep 2
        echo -n "."
    done
    
    print_warning "Container might not be fully ready. Check logs with: $RUNTIME logs $CONTAINER_NAME"
}

# Show container information
show_info() {
    echo ""
    echo "==================================="
    echo "🎯 DECISION GUIDE CONTAINER INFO"
    echo "==================================="
    echo "Runtime: $RUNTIME"
    echo "Image: $IMAGE_NAME:$IMAGE_TAG"
    echo "Container: $CONTAINER_NAME"
    echo "URL: http://localhost:$HOST_PORT"
    echo "Health Check: http://localhost:$HOST_PORT/health"
    echo ""
    echo "Useful Commands:"
    echo "  View logs: $RUNTIME logs -f $CONTAINER_NAME"
    echo "  Stop: $RUNTIME stop $CONTAINER_NAME"
    echo "  Restart: $RUNTIME restart $CONTAINER_NAME"
    echo "  Remove: $RUNTIME rm -f $CONTAINER_NAME"
    echo "==================================="
}

# Main execution
main() {
    echo ""
    echo "🚀 Docker vs Podman Decision Guide Builder"
    echo "========================================"
    
    detect_runtime
    check_port
    setup_directories
    cleanup_container
    build_image
    run_container
    wait_for_container
    show_info
    
    print_success "Setup complete! Open http://localhost:$HOST_PORT in your browser."
}

# Handle script interruption
trap 'print_error "Script interrupted. Cleaning up..."; cleanup_container; exit 1' INT TERM

# Run main function
main "$@"