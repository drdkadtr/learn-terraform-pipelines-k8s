terraform {
  #backend "remote" {}
  required_providers {
    # https://registry.terraform.io/providers/hashicorp/google/latest
    google = {
      source  = "hashicorp/google"
      version = ">= 4.0.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.7.1"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.4.1"
    }
  }
  required_version = ">= 1.0.0"
}
