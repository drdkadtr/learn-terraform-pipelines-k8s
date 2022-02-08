data "http" "whatsmyip" {
  url = "https://ifconfig.me"
}

output "whatsmyip" {
  description = "IP from terraform execution environment"
  value       = chomp(data.http.whatsmyip.body)
}
