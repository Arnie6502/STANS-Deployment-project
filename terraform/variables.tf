Terraform Variables for STANS Navigation System

variable "do_token" {
  description = "DigitalOcean API token"
  type        = string
  sensitive   = true
}


variable "ssh_key_fingerprint" {
  description = "SSH key fingerprint for server access"
  type        = string
  default     = ""
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


variable "server_region" {
  description = "Region for the server"
  type        = string
  default     = "nyc3"


  validation {
    condition     = contains(["nyc1", "nyc2", "nyc3", "ams1", "ams2", "ams3", "sfo1", "sfo2", "sfo3", "lon1", "fra1", "tor1", "sgp1", "blr1"], var.server_region)
    error_message = "The server_region must be a valid DigitalOcean region."
  }
}


variable "server_size" {
  description = "Size of the server (Droplet)"
  type        = string
  default     = "s-2vcpu-4gb"
}


variable "enable_monitoring" {
  description = "Enable monitoring on the droplet"
  type        = bool
  default     = true
}


variable "enable_backups" {
  description = "Enable backups on the droplet"
  type        = bool
  default     = true
}


variable "environment" {
  description = "Environment name (production, staging, development)"
  type        = string
  default     = "production"


  validation {
    condition     = contains(["production", "staging", "development"], var.environment)
    error_message = "The environment must be production, staging, or development."
  }
}
