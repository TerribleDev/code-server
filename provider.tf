terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.0"
    }
  }
}



# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = var.do_token
}

provider "cloudflare" {
  api_key = var.cloudflare_api_key
  email  = var.cloudflare_email
}