output "google" {
  description = "Shared terraform remote state"
  sensitive   = true
  value = {
    project_id = google_container_cluster.current.project
    region     = var.region
  }
}

output "kubernetes" {
  description = "Shared terraform remote state"
  sensitive   = true
  value = {
    host                   = "https://${google_container_cluster.current.endpoint}"
    cluster_ca_certificate = base64decode(google_container_cluster.current.master_auth[0].cluster_ca_certificate, )
    token                  = data.google_client_config.default.access_token
  }
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

/*
output "kubeconfig" {
  value      = local.kubeconfig
  sensitive  = true
  depends_on = [google_container_node_pool.current]
}
*/

