output "vpc_flow_logs_enabled" {
  description = "Whether VPC Flow Logs are enabled."
  value       = var.enable_vpc_flow_logs
}

output "flow_log_id" {
  description = "ID of the VPC Flow Log when enabled."
  value       = try(aws_flow_log.vpc[0].id, null)
}

output "cloudwatch_log_group_name" {
  description = "Name of the CloudWatch log group when flow logging is enabled."
  value       = try(aws_cloudwatch_log_group.vpc_flow_logs[0].name, null)
}

output "flow_logs_role_arn" {
  description = "ARN of the VPC Flow Logs delivery role when enabled."
  value       = try(aws_iam_role.flow_logs[0].arn, null)
}
