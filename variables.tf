variable "region" {
  type        = string
  default     = "europe-west2"
  description = "GCP region to deploy clusters."
}

variable "cluster_name" {
  type        = string
  description = "Name of cluster."
}

variable "google_project" {
  type        = string
  description = "Google Project to deploy cluster"
}

variable "enable_consul_and_vault" {
  type        = bool
  default     = false
  description = "Enable consul and vault for the secrets cluster"
}

variable "extra_cidr_blocks" {
  type        = any
  default     = []
  description = "Your cidr with access to cluster"
}
