terraform {
  backend "remote" {
    organization = "terribledev"

    workspaces {
      name = "code-server"
    }
  }

  required_version = ">= 0.14.0"
}