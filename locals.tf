locals {
  environment = "dev"
  name        = coalesce(var.cluster_name, terraform.workspace)
  enable_ns   = local.environment == "dev" ? false : true

  template_vars = {
    cluster_name     = google_container_cluster.current.name
    cluster_endpoint = google_container_cluster.current.endpoint
    cluster_ca       = google_container_cluster.current.master_auth[0].cluster_ca_certificate
    client_cert      = google_container_cluster.current.master_auth[0].client_certificate
    client_cert_key  = google_container_cluster.current.master_auth[0].client_key
  }

  kubeconfig = templatefile("${path.module}/templates/kubeconfig-template.yaml", local.template_vars)
}
