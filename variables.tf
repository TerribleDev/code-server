variable "do_token" {
  type = string
}
variable "cloudflare_email" {
  type = string
}
variable "cloudflare_api_token" {
  type = string
}
variable "cloudflare_zone" {
  type = string
}

variable "ssh_keys" {
  type = list(string)
}

variable "dns_name" {
  type    = string
  default = "code"
}