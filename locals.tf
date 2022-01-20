locals {
  name = format("%s-%s", var.cluster_name, terraform.workspace)
}
