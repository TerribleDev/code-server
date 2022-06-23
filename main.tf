resource "digitalocean_droplet" "web" {
  image     = "ubuntu-20-04-x64"
  name      = "web-1"
  region    = "nyc1"
  size      = "s-1vcpu-1gb-amd"
  ssh_keys  = var.ssh_keys
  user_data = templatefile("deploy-vm/launch-code-server.sh", { dns_name = "${var.dns_name}.${data.cloudflare_zone.main_zone.name}" })
}

data "cloudflare_zone" "main_zone" {
  zone_id = var.cloudflare_zone
}

resource "cloudflare_record" "droplet" {
  zone_id = data.cloudflare_zone.main_zone.id
  name    = "ide"
  value   = digitalocean_droplet.web.ipv4_address
  type    = "A"
  ttl     = 300
}