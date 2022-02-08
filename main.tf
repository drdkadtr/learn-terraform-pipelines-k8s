data "google_compute_zones" "available" {}
data "google_client_config" "default" {}
data "google_client_openid_userinfo" "current" {}

data "http" "whatsmyip" {
  url = "https://ifconfig.me"
}

resource "google_container_cluster" "current" {
  name     = local.name
  location = data.google_compute_zones.available.names.0

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1

  ip_allocation_policy {}

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

resource "kubernetes_namespace" "current" {
  count = local.enable_ns ? 1 : 0
  metadata {
    name = local.environment
  }
  provider = kubernetes.gke
}

resource "helm_release" "nginx_ingress" {
  name = "nginx-ingress-controller"

  repository = "https://charts.bitnami.com/bitnami"
  chart      = "nginx-ingress-controller"

  set {
    name  = "service.type"
    value = "ClusterIP"
  }
  provider = helm.gke
}
