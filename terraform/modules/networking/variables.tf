variable "project_name" {
  description = "Project name used for resource naming."
  type        = string
}

variable "environment" {
  description = "Deployment environment."
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block assigned to the VPC."
  type        = string
}

variable "availability_zones" {
  description = "Availability Zones used by the subnets."
  type        = list(string)

  validation {
    condition     = length(var.availability_zones) >= 2
    error_message = "At least two Availability Zones must be provided."
  }
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks assigned to public subnets."
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks assigned to private subnets."
  type        = list(string)
}

variable "enable_nat_gateway" {
  description = "Whether to deploy NAT gateways for private-subnet outbound access."
  type        = bool
  default     = false
}
