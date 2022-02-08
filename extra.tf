locals {
  extra_enabled = true
}

resource "kubernetes_namespace" "extra" {
  count = local.extra_enabled ? 1 : 0
  metadata {
    name = "extra"
  }
  provider   = kubernetes.gke
  depends_on = [google_container_node_pool.current]
}

resource "helm_release" "nginx_ingress" {
  count = local.extra_enabled ? 1 : 0
  name  = "nginx-ingress-controller"

  repository = "https://charts.bitnami.com/bitnami"
  chart      = "nginx-ingress-controller"

  set {
    name  = "service.type"
    value = "ClusterIP"
  }
  provider   = helm.gke
  depends_on = [google_container_node_pool.current]
}
