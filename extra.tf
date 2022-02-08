data "http" "whatsmyip" {
  url = "https://ifconfig.me"
}

resource "kubernetes_namespace" "current" {
  count = local.enabled ? 1 : 0
  metadata {
    name = local.environment
  }
  provider   = kubernetes.gke
  depends_on = [google_container_node_pool.current]
}

resource "helm_release" "nginx_ingress" {
  count = local.enabled ? 1 : 0
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

output "whatsmyip" {
  description = "IP from terraform execution environment"
  value       = chomp(data.http.whatsmyip.body)
}
