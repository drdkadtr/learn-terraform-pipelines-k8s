provider "google" {
  project = var.google_project
  region  = var.region
}

provider "kubernetes" {
  alias                  = "gke"
  host                   = "https://${google_container_cluster.current.endpoint}"
  cluster_ca_certificate = base64decode(google_container_cluster.current.master_auth[0].cluster_ca_certificate, )
  token                  = data.google_client_config.default.access_token
}

provider "helm" {
  kubernetes {
    host                   = "https://${google_container_cluster.current.endpoint}"
    cluster_ca_certificate = base64decode(google_container_cluster.current.master_auth[0].cluster_ca_certificate, )
    token                  = data.google_client_config.default.access_token
  }
}
