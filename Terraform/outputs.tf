output "vm_public_ip" {
  description = "Public IP address to access the VM"
  value       = azurerm_public_ip.public_ip.ip_address
}

output "ssh_command" {
  description = "Command to SSH into the VM"
  value       = "ssh ${var.admin_username}@${azurerm_public_ip.public_ip.ip_address}"
}

output "application_url" {
  description = "URL to access your application"
  value       = "http://${azurerm_public_ip.public_ip.ip_address}:30080"
}

output "grafana_url" {
  description = "URL to access Grafana dashboard"
  value       = "http://${azurerm_public_ip.public_ip.ip_address}:30300"
}

output "prometheus_url" {
  description = "URL to access Prometheus"
  value       = "http://${azurerm_public_ip.public_ip.ip_address}:30900"
}