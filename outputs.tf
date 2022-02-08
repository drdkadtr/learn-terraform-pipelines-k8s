output "project_id" {
  value = google_container_cluster.current.project
}

output "region" {
  value = data.google_compute_zones.available.region
}

output "enable_consul_and_vault" {
  value = var.enable_consul_and_vault
}

