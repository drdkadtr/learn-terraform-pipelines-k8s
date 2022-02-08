# https://docs.scalr.com/en/latest/faq/whitelist_ips.html

/*
data "http" "scalr" {
  url = "https://scalr.io/.well-known/allowlist.txt"

  request_headers = {
    Accept = "application/txt"
  }
}
*/

locals {
  //scalr_ips = formatlist("%s/32", split("\n", trimspace(data.http.scalr.body)))

  scalr_ips = tolist([
    "34.134.245.131/32",
    "35.202.87.57/32",
    "35.225.139.3/32",
    "35.194.10.166/32",
    "34.134.102.126/32",
    "34.69.121.179/32",
    "35.225.153.7/32",
    "35.232.103.9/32",
    "34.132.12.27/32",
    "104.154.95.253/32",
    "34.71.68.209/32",
    "146.148.52.18/32",
    "34.121.100.155/32",
    "35.232.193.181/32",
    "34.132.166.190/32",
    "104.198.68.185/32",
    "34.134.132.240/32",
    "35.202.43.8/32",
    "34.149.169.167/32",
  ])
}
