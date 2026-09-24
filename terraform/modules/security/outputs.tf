output "workload_security_group_id" {
  description = "ID of the workload security group."
  value       = aws_security_group.workload.id
}

output "workload_security_group_arn" {
  description = "ARN of the workload security group."
  value       = aws_security_group.workload.arn
}

output "administrative_ingress_enabled" {
  description = "Whether any approved administrative CIDR blocks were configured."
  value       = length(var.allowed_admin_cidrs) > 0
}
