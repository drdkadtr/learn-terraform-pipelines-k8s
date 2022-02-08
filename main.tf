data "google_compute_zones" "available" {}
data "google_client_config" "default" {}

resource "google_container_cluster" "current" {
  name     = local.name
  location = data.google_compute_zones.available.names.0

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1

  ip_allocation_policy {}

  master_authorized_networks_config {

    dynamic "cidr_blocks" {
      for_each = local.cidr_blocks
      content {
        cidr_block = cidr_blocks.value
      }
    }
  }

  lifecycle {
    ignore_changes = [node_pool, initial_node_count, resource_labels["asmv"], resource_labels["mesh_id"]]
  }

  timeouts {
    create = "45m"
    update = "60m"
    delete = "45m"
  }
}

resource "google_container_node_pool" "current" {
  name       = "${local.name}-node-pool"
  cluster    = google_container_cluster.current.name
  location   = data.google_compute_zones.available.names.0
  node_count = var.enable_consul_and_vault ? 5 : 3

  node_config {
    preemptible  = true
    machine_type = "n1-standard-1"

    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }

  lifecycle {
    ignore_changes = [initial_node_count]
  }

  timeouts {
    create = "45m"
    update = "60m"
    delete = "45m"
  }
}
