variable "do_token" {
    type = string
}
variable "cloudflare_email" {
    type = string
}
variable "cloudflare_api_key" {
    type = string
}

variable "cloudflare_zone" {
    type = string
}

variable "ssh_keys" {
    type = list(string)
}