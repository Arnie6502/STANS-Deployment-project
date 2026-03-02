# Terraform Infrastructure Setup for STANS

This directory contains Terraform configurations for automating the infrastructure setup for the STANS Navigation System.

Prerequisites

- Terraform installed (v1.0+)

- DigitalOcean account

- DigitalOcean API token

- SSH key pair for server access

Quick Start

1. Install Terraform

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

## On macOS

brew install terraform

## On Linux

wget <https://releases.hashicorp.com/terraform/1.5.0/terraform_1.5.0_linux_amd64.zip>

unzip terraform_1.5.0_linux_amd64.zip

sudo mv terraform /usr/local/bin/

## Verify installation

terraform version

1. Configure Variables

Copy the example variables file and fill in your values:

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

cp terraform.tfvars.example terraform.tfvars

Edit terraform.tfvars and provide:

- do_token: Your DigitalOcean API token

- domain_name: Your domain name

- Other optional variables as needed

1. Initialize Terraform

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

terraform init

1. Review the Plan

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

terraform plan

This will show you what resources will be created without actually creating them.

1. Apply the Configuration

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

terraform apply

Type yes when prompted to confirm.

1. Get the Outputs

After successful deployment, get the server details:

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

terraform output

This will display:

- Server IP address

- Server name

- Load balancer IP (if enabled)

- Domain name

Infrastructure Components

The Terraform configuration creates the following resources:

1. DigitalOcean Project

- Organizes all resources under a single project

- Easy management and billing

1. Droplet (Server)

- Ubuntu 22.04 LTS

- Configured size (default: 2 vCPU, 4GB RAM)

- Automatic Docker installation

- Firewall configured (ports 22, 80, 443)

- Monitoring enabled

- Automatic backups

1. SSH Key

- Automatically creates or uses existing SSH key

- Enables secure server access

1. Domain Configuration

- Creates domain record in DigitalOcean

- Configures A records for root and www subdomains

1. Load Balancer (Optional)

- Distributes traffic across multiple instances

- SSL termination

- Health checks

- Sticky sessions

1. SSL Certificate

- Automatic Let's Encrypt certificate

- Auto-renewal

- Supports both root and www subdomains

Usage

Deploy Infrastructure

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

terraform apply

Update Infrastructure

Make changes to the configuration files, then:

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

terraform plan

terraform apply

Destroy Infrastructure

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

terraform destroy

⚠️ Warning: This will delete all resources and data!

Import Existing Resources

If you have existing resources you want to manage with Terraform:

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

terraform import digitalocean_droplet.stans_app 123456789

Advanced Usage

Workspaces

Use Terraform workspaces for multiple environments:

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

## Create production workspace

terraform workspace new production

## Create staging workspace

terraform workspace new staging

## Switch between workspaces

terraform workspace select production

## List workspaces

terraform workspace list

State Management

Remote State with S3

The configuration uses S3 for remote state storage. Configure your backend:

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

backend "s3" {

  bucket = "stans-terraform-state"

  key    = "production/terraform.tfstate"

  region = "us-east-1"

}

State Locking

Enable state locking with DynamoDB:

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

backend "s3" {

  bucket         = "stans-terraform-state"

  key            = "production/terraform.tfstate"

  region         = "us-east-1"

  dynamodb_table = "stans-terraform-locks"

  encrypt        = true

}

Modules

For larger deployments, use Terraform modules:

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

module "stans_app" {

  source = "./modules/stans-app"

  domain_name = "stans-app.com"

  server_size = "s-2vcpu-4gb"

}

Variables

Required Variables

- do_token: DigitalOcean API token

Optional Variables

- domain_name: Domain name (default: "stans-app.com")

- project_name: Project name (default: "stans-navigation")

- server_region: Server region (default: "nyc3")

- server_size: Server size (default: "s-2vcpu-4gb")

- enable_monitoring: Enable monitoring (default: true)

- enable_backups: Enable backups (default: true)

- environment: Environment name (default: "production")

See variables.tf for complete variable definitions.

Outputs

After deployment, the following outputs are available:

- server_ip: IP address of the application server

- server_name: Name of the server

- load_balancer_ip: IP address of the load balancer

- domain_name: Domain name for the application

Post-Deployment Steps

After Terraform completes the infrastructure setup:

-

Connect to the server:

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

ssh root@<server_ip>

-

Deploy the application:

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

docker pull ghcr.io/YOUR_USERNAME/STANS:latest

docker run -d --name stans-app --restart=always -p 80:80 ghcr.io/YOUR_USERNAME/STANS:latest

-

Configure SSL:

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

certbot --nginx -d yourdomain.com -d <www.yourdomain.com>

-

Verify deployment:

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

curl <http://localhost/health>

Troubleshooting

State Lock Issues

If you encounter state lock issues:

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

terraform force-unlock <LOCK_ID>

Resource Already Exists

If a resource already exists:

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

## Import the existing resource

terraform import <resource_type>.<resource_name> <resource_id>

API Token Issues

If you get authentication errors:

- Verify your API token is valid

- Check token has necessary permissions

- Regenerate token if needed

Network Issues

If you can't connect to the server:

- Check firewall rules

- Verify SSH key is configured

- Check DigitalOcean networking settings

Best Practices

- Version Control: Keep Terraform code in Git

- State Management: Use remote state with locking

- Variables: Use .tfvars files for environment-specific values

- Security: Never commit sensitive data (API tokens, SSH keys)

- Documentation: Document your infrastructure decisions

- Testing: Use terraform plan before applying

- Backups: Regularly backup Terraform state

- Review: Review changes before applying

Cost Optimization

To reduce costs:

- Use smaller droplet sizes for development

- Disable monitoring and backups for non-production

- Use spot instances when available

- Clean up unused resources regularly

- Use reserved instances for long-running workloads

Security Considerations

- API Tokens: Rotate API tokens regularly

- SSH Keys: Use strong SSH keys and rotate them

- Firewall: Configure firewall rules properly

- SSL/TLS: Always use HTTPS in production

- Backups: Enable regular backups

- Monitoring: Monitor for suspicious activity

- Updates: Keep system and dependencies updated

Support

- Terraform Documentation

- DigitalOcean Provider Documentation

- DigitalOcean API Documentation

License

This infrastructure code is part of the STANS Navigation System project.
