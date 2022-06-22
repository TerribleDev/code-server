terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.0"
    }
    required_providers {
        digitalocean = {
        source = "digitalocean/digitalocean"
        version = "~> 2.0"
        }
    }
  }
}

variable "do_token" {
    type = "string"
}
variable "cloudflare_email" {
    type = "string"
}
variable "cloudflare_api_key" {
    type = "string"
}

variable "cloudflare_zone" {
    type = "string"
}


# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = var.do_token
}

provider "cloudflare" {
  email   = var.cloudflare_email
  api_key = var.cloudflare_api_key
}