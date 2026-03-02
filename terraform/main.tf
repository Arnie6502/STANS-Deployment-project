STANS Navigation System - Terraform Configuration

This configuration sets up the infrastructure for production deployment

terraform {
  required_version = ">= 1.0"


  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }


  backend "s3" {
    bucket = "stans-terraform-state"
    key    = "production/terraform.tfstate"
    region = "us-east-1"
  }
}


provider "digitalocean" {
  token = var.do_token
}


Variables

variable "do_token" {
  description = "DigitalOcean API token"
  type        = string
  sensitive   = true
}


variable "ssh_key_fingerprint" {
  description = "SSH key fingerprint for server access"
  type        = string
}


variable "domain_name" {
  description = "Domain name for the application"
  type        = string
  default     = "stans-app.com"
}


variable "project_name" {
  description = "Project name for resource tagging"
  type        = string
  default     = "stans-navigation"
}


Create a project

resource "digitalocean_project" "stans" {
  name        = var.project_name
  description = "STANS Navigation System"
  purpose     = "Web Application"
}


Create SSH key

resource "digitalocean_ssh_key" "default" {
  name       = "stans-deploy-key"
  public_key = file("~/.ssh/id_rsa.pub")
}


Create a droplet (server)

resource "digitalocean_droplet" "stans_app" {
  image  = "ubuntu-22-04-x64"
  name   = "stans-app-server"
  region = "nyc3"
  size   = "s-2vcpu-4gb"


  ssh_keys = [
    digitalocean_ssh_key.default.fingerprint
  ]


  monitoring = true
  backups    = true


  tags = [
    digitalocean_project.stans.id,
    "production",
    "web-app"
  ]


  user_data = <<-EOF
              #!/bin/bash
              # Update system
              apt-get update && apt-get upgrade -y


          # Install Docker
          curl -fsSL https://get.docker.com -o get-docker.sh
          sh get-docker.sh
          usermod -aG docker root
          
          # Install Docker Compose
          curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
          chmod +x /usr/local/bin/docker-compose
          
          # Configure firewall
          ufw allow 22/tcp
          ufw allow 80/tcp
          ufw allow 443/tcp
          ufw --force enable
          
          # Install Nginx for SSL termination
          apt-get install -y nginx certbot python3-certbot-nginx
          
          echo "Server setup completed"
          EOF

}


Create a domain record

resource "digitalocean_domain" "stans" {
  name       = var.domain_name
  ip_address = digitalocean_droplet.stans_app.ipv4_address
}


Create A record for www subdomain

resource "digitalocean_record" "www" {
  domain = digitalocean_domain.stans.id
  type   = "A"
  name   = "www"
  value  = digitalocean_droplet.stans_app.ipv4_address
  ttl    = 3600
}


Create a load balancer (optional, for high availability)

resource "digitalocean_loadbalancer" "stans_lb" {
  name   = "stans-load-balancer"
  region = "nyc3"


  forwarding_rule {
    entry_port     = 80
    entry_protocol = "http"


target_port     = 80
target_protocol = "http"

  }


  forwarding_rule {
    entry_port     = 443
    entry_protocol = "https"


target_port     = 443
target_protocol = "https"

certificate_id = digitalocean_certificate.stans_cert.id

  }


  healthcheck {
    port     = 80
    protocol = "http"
    path     = "/health"
  }


  droplet_ids = [
    digitalocean_droplet.stans_app.id
  ]


  sticky_sessions {
    type             = "cookies"
    cookie_name      = "STANS_SESSION"
    cookie_ttl_seconds = 3600
  }
}


Create SSL certificate

resource "digitalocean_certificate" "stans_cert" {
  name              = "stans-ssl-cert"
  type              = "lets_encrypt"
  domains           = [var.domain_name, "www.${var.domain_name}"]
  dns_names         = [var.domain_name, "www.${var.domain_name}"]
  not_after         = "2025-12-31"
}


Outputs

output "server_ip" {
  description = "IP address of the STANS application server"
  value       = digitalocean_droplet.stans_app.ipv4_address
}


output "server_name" {
  description = "Name of the STANS application server"
  value       = digitalocean_droplet.stans_app.name
}


output "load_balancer_ip" {
  description = "IP address of the load balancer"
  value       = digitalocean_loadbalancer.stans_lb.ip
}


output "domain_name" {
  description = "Domain name for the application"
  value       = var.domain_name
}
