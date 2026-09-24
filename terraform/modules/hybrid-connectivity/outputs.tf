output "vpn_gateway_id" {
  description = "ID of the virtual private gateway when VPN creation is enabled."
  value       = try(aws_vpn_gateway.this[0].id, null)
}

output "customer_gateway_id" {
  description = "ID of the customer gateway when VPN creation is enabled."
  value       = try(aws_customer_gateway.this[0].id, null)
}

output "vpn_connection_id" {
  description = "ID of the Site-to-Site VPN connection when enabled."
  value       = try(aws_vpn_connection.this[0].id, null)
}

output "vpn_enabled" {
  description = "Whether Site-to-Site VPN resources are enabled."
  value       = var.enable_site_to_site_vpn
}
