variable "project_name" {
  description = "Project name used for resource naming."
  type        = string
}

variable "environment" {
  description = "Deployment environment."
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC to monitor."
  type        = string
}

variable "enable_vpc_flow_logs" {
  description = "Whether to publish VPC Flow Logs to CloudWatch Logs."
  type        = bool
  default     = false
}

variable "flow_log_retention_days" {
  description = "Number of days CloudWatch retains VPC Flow Log records."
  type        = number
  default     = 30

  validation {
    condition     = var.flow_log_retention_days >= 1
    error_message = "Flow-log retention must be at least one day."
  }
}
