# STANS Navigation System - Deployment Guide

This guide provides comprehensive instructions for deploying the STANS Navigation System using Docker, CI/CD pipelines, and production deployment strategies.

Table of Contents

- Prerequisites

- Local Development

- Docker Containerization

- CI/CD Pipeline Setup

- Production Deployment

- SSL/TLS Configuration

- Monitoring and Maintenance

- Troubleshooting

Prerequisites

Required Tools

- Docker (v20.10+)

- Docker Compose (v2.0+)

- Node.js (v20+)

- npm (v9+)

- Git

- A cloud server (AWS, DigitalOcean, etc.) with SSH access

- Domain name (for production)

Required Accounts

- GitHub account

- Docker Hub account or GitHub Container Registry

- Cloud provider account

Local Development

1. Clone the Repository

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

git clone <https://github.com/YOUR_USERNAME/STANS.git>

cd STANS

1. Install Dependencies

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

npm install

1. Run Development Server

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

npm run dev

The application will be available at <http://localhost:5173>

1. Build for Production

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

npm run build

Docker Containerization

Build Docker Image

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

docker build -t stans-app .

Run Container Locally

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

docker run -d -p 8080:80 --name stans-app stans-app

Access the application at <http://localhost:8080>

Docker Compose (Optional)

Create a docker-compose.yml file:

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

version: '3.8'

services:

  stans-app:

    build: .

    ports:

      - "8080:80"

    restart: unless-stopped

    healthcheck:

      test: ["CMD", "wget", "--quiet", "--tries=1", "--spider", "http://localhost/health"]

      interval: 30s

      timeout: 10s

      retries: 3

      start_period: 40s

Run with Docker Compose:

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

docker-compose up -d

CI/CD Pipeline Setup

GitHub Actions Workflow

The project includes a GitHub Actions workflow (.github/workflows/deploy.yml) that:

- Builds and tests the application on every push

- Builds Docker images and pushes to GitHub Container Registry

- Deploys to production server (optional)

Required GitHub Secrets

Configure these secrets in your GitHub repository settings (Settings > Secrets and variables > Actions):

For Docker Registry (GitHub Container Registry)

- GITHUB_TOKEN: Automatically provided by GitHub Actions

For Server Deployment (Optional)

- SERVER_HOST: Your server IP address or hostname

- SERVER_USER: SSH username (usually root or ubuntu)

- SSH_PRIVATE_KEY: Your SSH private key for server access

Setting Up GitHub Secrets

- Go to your repository on GitHub

- Navigate to Settings > Secrets and variables > Actions

- Click New repository secret

- Add each secret with its corresponding value

SSH Key Setup for Deployment

Generate SSH key pair:

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

ssh-keygen -t ed25519 -C "github-actions" -f ~/.ssh/github_actions

Add public key to server:

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

ssh-copy-id -i ~/.ssh/github_actions.pub <user@your-server.com>

Add private key to GitHub Secrets:

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

cat ~/.ssh/github_actions

Copy the output and add it as SSH_PRIVATE_KEY secret.

Production Deployment

Server Setup

1. Connect to Your Server

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

ssh <user@your-server.com>

1. Update System

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

sudo apt update && sudo apt upgrade -y

1. Install Docker

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

curl -fsSL <https://get.docker.com> -o get-docker.sh

sudo sh get-docker.sh

sudo usermod -aG docker $USER

1. Install Docker Compose

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

sudo curl -L "<https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname> -s)-$(uname -m)" -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

Deploy Application

Option 1: Manual Deployment

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

## Pull the image

docker pull ghcr.io/YOUR_USERNAME/STANS:latest

## Run the container

docker run -d \

  --name stans-app \

  --restart=always \

  -p 80:80 \

  ghcr.io/YOUR_USERNAME/STANS:latest

Option 2: Using Docker Compose

Create docker-compose.prod.yml:

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

version: '3.8'

services:

  stans-app:

    image: ghcr.io/YOUR_USERNAME/STANS:latest

    ports:

      - "80:80"

    restart: always

    healthcheck:

      test: ["CMD", "wget", "--quiet", "--tries=1", "--spider", "http://localhost/health"]

      interval: 30s

      timeout: 10s

      retries: 3

      start_period: 40s

    logging:

      driver: "json-file"

      options:

        max-size: "10m"

        max-file: "3"

Deploy:

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

docker-compose -f docker-compose.prod.yml up -d

Firewall Configuration

Configure UFW (Uncomplicated Firewall):

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

## Allow SSH

sudo ufw allow 22/tcp

## Allow HTTP

sudo ufw allow 80/tcp

## Allow HTTPS

sudo ufw allow 443/tcp

## Enable firewall

sudo ufw enable

## Check status

sudo ufw status

SSL/TLS Configuration

Using Certbot with Let's Encrypt

1. Install Certbot

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

sudo apt install certbot python3-certbot-nginx -y

1. Obtain SSL Certificate

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

sudo certbot --nginx -d yourdomain.com -d <www.yourdomain.com>

1. Auto-renewal Setup

Certbot automatically sets up a cron job for renewal. Verify:

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

sudo certbot renew --dry-run

Nginx Reverse Proxy Configuration

Create /etc/nginx/sites-available/stans-app:

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

server {

    listen 80;

    server_name yourdomain.com www.yourdomain.com;

    return 301 https://$server_name$request_uri;

}

server {

    listen 443 ssl http2;

    server_name yourdomain.com www.yourdomain.com;

    ssl_certificate /etc/letsencrypt/live/yourdomain.com/fullchain.pem;

    ssl_certificate_key /etc/letsencrypt/live/yourdomain.com/privkey.pem;

    ssl_protocols TLSv1.2 TLSv1.3;

    ssl_ciphers HIGH:!aNULL:!MD5;

    location / {

        proxy_pass http://localhost:8080;

        proxy_http_version 1.1;

        proxy_set_header Upgrade $http_upgrade;

        proxy_set_header Connection 'upgrade';

        proxy_set_header Host $host;

        proxy_cache_bypass $http_upgrade;

        proxy_set_header X-Real-IP $remote_addr;

        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

        proxy_set_header X-Forwarded-Proto $scheme;

    }

}

Enable the configuration:

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

sudo ln -s /etc/nginx/sites-available/stans-app /etc/nginx/sites-enabled/

sudo nginx -t

sudo systemctl reload nginx

Monitoring and Maintenance

View Container Logs

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

docker logs -f stans-app

Container Health Check

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

docker inspect --format='{{.State.Health.Status}}' stans-app

Update Application

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

## Pull latest image

docker pull ghcr.io/YOUR_USERNAME/STANS:latest

## Stop and remove old container

docker stop stans-app

docker rm stans-app

## Run new container

docker run -d \

  --name stans-app \

  --restart=always \

  -p 80:80 \

  ghcr.io/YOUR_USERNAME/STANS:latest

System Resources Monitoring

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

## Check container stats

docker stats stans-app

## Check disk usage

docker system df

## Clean up unused resources

docker system prune -a

Troubleshooting

Container Won't Start

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

## Check logs

docker logs stans-app

## Check if port is already in use

sudo netstat -tulpn | grep :80

## Stop conflicting services

sudo systemctl stop nginx  # if needed

Build Failures

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

## Clean build cache

docker builder prune -a

## Rebuild without cache

docker build --no-cache -t stans-app .

SSL Certificate Issues

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

## Check certificate status

sudo certbot certificates

## Renew certificate manually

sudo certbot renew

## Check Nginx configuration

sudo nginx -t

Performance Issues

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

## Check container resource usage

docker stats stans-app

## Increase container resources

docker run -d \

  --name stans-app \

  --restart=always \

  -p 80:80 \

  --memory="512m" \

  --cpus="1.0" \

  ghcr.io/YOUR_USERNAME/STANS:latest

Stretch Goals Implementation

Monitoring with Prometheus and Grafana

Create docker-compose.monitoring.yml:

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

version: '3.8'

services:

  prometheus:

    image: prom/prometheus:latest

    ports:

      - "9090:9090"

    volumes:

      - ./prometheus.yml:/etc/prometheus/prometheus.yml

      - prometheus_data:/prometheus

    command:

      - '--config.file=/etc/prometheus/prometheus.yml'

      - '--storage.tsdb.path=/prometheus'

  grafana:

    image: grafana/grafana:latest

    ports:

      - "3000:3000"

    volumes:

      - grafana_data:/var/lib/grafana

    environment:

      - GF_SECURITY_ADMIN_PASSWORD=admin

volumes:

  prometheus_data:

  grafana_data:

Health Checks

The Dockerfile includes a health check endpoint at /health. Monitor it:

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

curl <http://localhost/health>

Load Balancing

For multiple instances, use Nginx as a load balancer:

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

upstream stans_backend {

    least_conn;

    server localhost:8081;

    server localhost:8082;

    server localhost:8083;

}

server {

    listen 80;

    location / {

        proxy_pass http://stans_backend;

        proxy_set_header Host $host;

        proxy_set_header X-Real-IP $remote_addr;

    }

}

Support

For issues and questions:

- GitHub Issues: <https://github.com/YOUR_USERNAME/STANS/issues>

- Documentation: <https://github.com/YOUR_USERNAME/STANS/wiki>

License

This project is licensed under the terms specified in the LICENSE file.
