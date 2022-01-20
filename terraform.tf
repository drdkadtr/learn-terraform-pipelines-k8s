terraform {
  #backend "remote" {}
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 3.55"
    }
  }
  required_version = ">= 1.0.0"
}
