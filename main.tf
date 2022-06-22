resource "digitalocean_droplet" "web" {
  image  = "ubuntu-20-04-x64"
  name   = "web-1"
  region = "nyc1"
  size   = "s-1vcpu-1gb-amd"
  ssh_keys = var.ssh_keys
}

resource "cloudflare_record" "foobar" {
  zone_id = var.cloudflare_zone
  name    = "ide"
  value   = digitalocean_droplet.web.ipv4_address
  type    = "CNAME"
  ttl     = 3600
}