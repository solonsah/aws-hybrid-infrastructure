variable "project_name" {
  description = "Project name used for resource naming."
  type        = string
}

variable "environment" {
  description = "Deployment environment."
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC where security groups will be created."
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block assigned to the AWS VPC."
  type        = string
}

variable "simulated_on_premises_cidr" {
  description = "CIDR block representing the simulated on-premises network."
  type        = string
}

variable "allowed_admin_cidrs" {
  description = "Approved CIDR blocks allowed to reach administrative services."
  type        = list(string)
  default     = []
}

