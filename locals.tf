locals {
  name        = coalesce(var.cluster_name, terraform.workspace)
  cidr_blocks = sort(compact(concat(local.scalr_ips, var.extra_cidr_blocks)))

  template_vars = {
    cluster_name     = google_container_cluster.current.name
    cluster_endpoint = google_container_cluster.current.endpoint
    cluster_ca       = google_container_cluster.current.master_auth[0].cluster_ca_certificate
    client_cert      = google_container_cluster.current.master_auth[0].client_certificate
    client_cert_key  = google_container_cluster.current.master_auth[0].client_key
  }

  kubeconfig = templatefile("${path.module}/templates/kubeconfig-template.yaml", local.template_vars)
}
