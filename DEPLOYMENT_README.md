# STANS Navigation System - Quick Deployment Guide

This is a quick reference guide for deploying the STANS Navigation System. For detailed instructions, see DEPLOYMENT.md.

🚀 Quick Start

Local Development

-Install dependencies:

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

npm install

-Start development server:

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

npm run dev

## or use the dev script

./scripts/dev.sh dev

-Build for production:

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

npm run build

## or

./scripts/dev.sh build

Docker Deployment

Using Docker Compose (Recommended)

-Start the application:

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

docker-compose up -d

-View logs:

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

docker-compose logs -f

-Stop the application:

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

docker-compose down

Using Docker Commands

-Build the image:

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

docker build -t stans-app .

-Run the container:

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

docker run -d -p 8080:80 --name stans-app stans-app

-View logs:

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

docker logs -f stans-app

-Stop the container:

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

docker stop stans-app

docker rm stans-app

Production Deployment

Using Deployment Script

-Make the script executable:

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

chmod +x scripts/deploy.sh

-Run deployment:

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

./scripts/deploy.sh YOUR_USERNAME/STANS

Using Docker Compose (Production)

-Update the image name in docker-compose.prod.yml:

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

image: ghcr.io/YOUR_USERNAME/STANS:latest

-Deploy:

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

docker-compose -f docker-compose.prod.yml up -d

📋 CI/CD Setup

GitHub Actions

The project includes a GitHub Actions workflow that automatically:

- Builds and tests the application

- Creates Docker images

- Pushes to GitHub Container Registry

- Deploys to production (optional)

Required GitHub Secrets

For Docker Registry (GitHub Container Registry):

- GITHUB_TOKEN: Automatically provided

For Server Deployment (Optional):

- SERVER_HOST: Your server IP or hostname

- SERVER_USER: SSH username

- SSH_PRIVATE_KEY: SSH private key

Setting Up Secrets

- Go to your repository on GitHub

- Navigate to Settings > Secrets and variables > Actions

- Click New repository secret

- Add each secret with its value

🔧 Development Scripts

The scripts/dev.sh script provides convenient commands:

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

./scripts/dev.sh install     # Install dependencies

./scripts/dev.sh dev         # Start development server

./scripts/dev.sh build       # Build for production

./scripts/dev.sh lint        # Run linter

./scripts/dev.sh docker:build    # Build Docker image

./scripts/dev.sh docker:run      # Run Docker container

./scripts/dev.sh docker:stop     # Stop Docker container

./scripts/dev.sh docker:clean    # Clean Docker resources

./scripts/dev.sh clean       # Clean build artifacts

./scripts/dev.sh help        # Show help

🔒 SSL/TLS Setup

Using Certbot

-Install Certbot:

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

sudo apt install certbot python3-certbot-nginx -y

-Obtain SSL certificate:

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

sudo certbot --nginx -d yourdomain.com -d <www.yourdomain.com>

-Auto-renewal is configured automatically

📊 Monitoring

Check Container Health

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

## Check if container is running

docker ps

## Check container health status

docker inspect --format='{{.State.Health.Status}}' stans-app

## View health endpoint

curl <http://localhost/health>

View Logs

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

## Follow logs

docker logs -f stans-app

## View last 100 lines

docker logs --tail 100 stans-app

## View logs with timestamps

docker logs -t stans-app

Resource Usage

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

## View container stats

docker stats stans-app

## View disk usage

docker system df

🔄 Updating the Application

Manual Update

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

Using Deployment Script

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

./scripts/deploy.sh YOUR_USERNAME/STANS

Using Docker Compose

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

docker-compose -f docker-compose.prod.yml pull

docker-compose -f docker-compose.prod.yml up -d

🛠️ Troubleshooting

Container Won't Start

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

## Check logs

docker logs stans-app

## Check if port is in use

sudo netstat -tulpn | grep :80

## Stop conflicting services

sudo systemctl stop nginx

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

📁 Project Structure

STANS/
├── .github/
│   └── workflows/
│       └── deploy.yml          # GitHub Actions CI/CD workflow
├── scripts/
│   ├── deploy.sh               # Production deployment script
│   └── dev.sh                  # Development helper script
├── src/                        # Application source code
├── Dockerfile                  # Multi-stage Docker build
├── docker-compose.yml          # Local development compose file
├── docker-compose.prod.yml     # Production compose file
├── nginx.conf                  # Nginx configuration
├── .dockerignore               # Docker ignore file
├── DEPLOYMENT.md               # Detailed deployment guide
└── DEPLOYMENT_README.md        # This file

🔐 Security Best Practices

- Use strong passwords for all services

- Keep dependencies updated with npm audit fix

- Use HTTPS in production with SSL/TLS

- Configure firewall to allow only necessary ports

- Regular backups of important data

- Monitor logs for suspicious activity

- Use secrets management for sensitive data

- Enable automatic security updates

📞 Support

- GitHub Issues: <https://github.com/YOUR_USERNAME/STANS/issues>

- Documentation: <https://github.com/YOUR_USERNAME/STANS/wiki>

- Detailed Guide: See DEPLOYMENT.md

📝 License

This project is licensed under the terms specified in the LICENSE file.
