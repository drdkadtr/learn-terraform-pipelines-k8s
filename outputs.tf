output "project_id" {
  description = "Shared terraform remote state"
  sensitive   = true
  value       = google_container_cluster.current.project
}

output "region" {
  description = "Shared terraform remote state"
  sensitive   = true
  value       = var.region
}

output "host" {
  description = "Shared terraform remote state"
  sensitive   = true
  value       = "https://${google_container_cluster.current.endpoint}"
}

output "cluster_ca_certificate" {
  description = "Shared terraform remote state"
  sensitive   = true
  value       = base64decode(google_container_cluster.current.master_auth[0].cluster_ca_certificate, )
}

output "token" {
  description = "Shared terraform remote state"
  sensitive   = true
  value       = data.google_client_config.default.access_token
}

output "control_flow" {
  description = "Control flow for upstream workspaces"
  value = {
    enable_consul_and_vault = var.enable_consul_and_vault
  }
}

output "kubeconfig_generate" {
  description = "Generate GKE connection string"
  value       = "gcloud container clusters get-credentials ${local.name} --region ${var.region}  --project ${var.google_project}"
}
