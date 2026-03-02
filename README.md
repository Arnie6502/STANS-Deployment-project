# STANS Navigation System Deployment project

Overview

This project provides a complete DevOps solution for deploying the STANS (Smart Traffic-Aware Navigation System) with industry-standard practices including containerization, CI/CD pipelines, production deployment, monitoring, and infrastructure automation.

https://roadmap.sh/projects/stans-navigation-deployment



## 🚀 Quick Start

### Local Development

bash

## Install dependencies

npm install

## Start development server

npm run dev

## Build for production

npm run build

## Docker Deployment

bash

## Build Docker image

docker build -t stans-app .

## Run container

docker run -d -p 8080:80 --name stans-app stans-app

## Or use Docker Compose

docker-compose up -d

## 📦 Deployment

This project includes comprehensive deployment configurations:

- **Docker**: Multi-stage builds with Nginx
- **CI/CD**: GitHub Actions workflow
- **Kubernetes**: Production-ready manifests
- **Terraform**: Infrastructure as Code
- **Monitoring**: Prometheus, Grafana, Alertmanager

### Deployment Documentation

- [Quick Deployment Guide](DEPLOYMENT_README.md) - Get started quickly
- [Complete Deployment Guide](DEPLOYMENT.md) - Detailed instructions
- [Project Summary](PROJECT_SUMMARY.md) - Overview of all components

### Deployment Options

1. **Docker** - Simple containerized deployment
2. **Docker Compose** - Local development and production
3. **Kubernetes** - Scalable orchestration
4. **Terraform** - Automated infrastructure provisioning
5. **CI/CD** - Automated deployment with GitHub Actions

## 📊 Monitoring

The project includes a complete monitoring stack:

- **Prometheus** - Metrics collection
- **Grafana** - Visualization dashboards
- **Alertmanager** - Alert routing and notifications
- **Node Exporter** - System metrics
- **cAdvisor** - Container metrics

See [monitoring/README.md](monitoring/README.md) for setup instructions.

## 🔧 Scripts

Convenient scripts for development and deployment:

bash

## Development helper

./scripts/dev.sh dev          # Start dev server
./scripts/dev.sh build        # Build for production
./scripts/dev.sh docker:build # Build Docker image
./scripts/dev.sh docker:run   # Run Docker container

## Production deployment

./scripts/deploy.sh YOUR_USERNAME/STANS

## 📁 Project Structure

STANS/
├── src/                    # Application source code
├── .github/workflows/      # CI/CD pipelines
├── scripts/                # Deployment scripts
├── k8s/                    # Kubernetes manifests
├── terraform/              # Infrastructure as Code
├── monitoring/             # Monitoring stack
├── Dockerfile              # Container build
├── docker-compose.yml      # Local development
└── DEPLOYMENT.md           # Deployment documentation

## 🎯 Features

- Interactive graph visualization
- Multiple routing algorithms (Dijkstra, Prim, Kruskal)
- Real-time traffic simulation
- 3D graph visualization
- Educational mode with tutorials
- Performance benchmarking
- Mobile-responsive design
- Dark/Light theme support

## 📚 Documentation

- [Deployment Guide](DEPLOYMENT.md) - Complete deployment instructions
- [Kubernetes Deployment](k8s/README.md) - K8s setup and management
- [Terraform Setup](terraform/README.md) - Infrastructure automation
- [Monitoring Setup](monitoring/README.md) - Monitoring and alerting


