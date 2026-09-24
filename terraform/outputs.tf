output "vpc_id" {
  description = "ID of the hybrid-infrastructure VPC."
  value       = module.networking.vpc_id
}

output "vpc_cidr" {
  description = "CIDR block assigned to the VPC."
  value       = module.networking.vpc_cidr
}

output "public_subnet_ids" {
  description = "Map of Availability Zones to public subnet IDs."
  value       = module.networking.public_subnet_ids
}

output "private_subnet_ids" {
  description = "Map of Availability Zones to private subnet IDs."
  value       = module.networking.private_subnet_ids
}

output "workload_security_group_id" {
  description = "ID of the private workload security group."
  value       = module.security.workload_security_group_id
}

output "administrative_ingress_enabled" {
  description = "Whether approved administrative ingress networks were configured."
  value       = module.security.administrative_ingress_enabled
}

output "site_to_site_vpn_enabled" {
  description = "Whether Site-to-Site VPN resources are enabled."
  value       = module.hybrid_connectivity.vpn_enabled
}

output "vpn_connection_id" {
  description = "ID of the Site-to-Site VPN connection when enabled."
  value       = module.hybrid_connectivity.vpn_connection_id
}

output "vpc_flow_logs_enabled" {
  description = "Whether VPC Flow Logs are enabled."
  value       = module.monitoring.vpc_flow_logs_enabled
}

output "flow_log_group_name" {
  description = "CloudWatch log-group name when VPC Flow Logs are enabled."
  value       = module.monitoring.cloudwatch_log_group_name
}
