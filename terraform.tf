terraform {
  #backend "remote" {}
  required_providers {
    # https://registry.terraform.io/providers/hashicorp/google/latest
    google = {
      source  = "hashicorp/google"
      version = ">= 4.10.0"
    }
  }
  required_version = ">= 1.0.0"
}
