variable "aws_region" {
  description = "AWS region where the infrastructure will be deployed."
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Name used to identify and tag project resources."
  type        = string
  default     = "aws-hybrid-infrastructure"
}

variable "environment" {
  description = "Deployment environment."
  type        = string
  default     = "demo"

  validation {
    condition     = contains(["dev", "test", "demo", "prod"], var.environment)
    error_message = "Environment must be dev, test, demo, or prod."
  }
}

variable "vpc_cidr" {
  description = "CIDR block assigned to the AWS VPC."
  type        = string
  default     = "10.20.0.0/16"
}

variable "availability_zones" {
  description = "Availability Zones used for highly available resources."
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]

  validation {
    condition     = length(var.availability_zones) >= 2
    error_message = "At least two Availability Zones must be specified."
  }
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks assigned to public subnets."
  type        = list(string)
  default     = ["10.20.10.0/24", "10.20.20.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks assigned to private subnets."
  type        = list(string)
  default     = ["10.20.110.0/24", "10.20.120.0/24"]
}

variable "simulated_on_premises_cidr" {
  description = "Documentation-only CIDR representing the simulated on-premises network."
  type        = string
  default     = "172.20.0.0/16"
}

variable "enable_nat_gateway" {
  description = "Whether to create NAT gateways for private-subnet outbound connectivity."
  type        = bool
  default     = false
}

variable "allowed_admin_cidrs" {
  description = "CIDR blocks permitted to reach approved administrative services."
  type        = list(string)
  default     = []
}

variable "enable_site_to_site_vpn" {
  description = "Whether to create billable AWS Site-to-Site VPN resources."
  type        = bool
  default     = false
}

variable "customer_gateway_ip" {
  description = "Public IP address of the customer gateway. Required only when VPN creation is enabled."
  type        = string
  default     = null
  nullable    = true
}

variable "customer_gateway_bgp_asn" {
  description = "Private BGP ASN assigned to the simulated customer gateway."
  type        = number
  default     = 65000

  validation {
    condition = (
      var.customer_gateway_bgp_asn >= 64512 &&
      var.customer_gateway_bgp_asn <= 65534
    )
    error_message = "The customer gateway BGP ASN must be in the private 16-bit range 64512–65534."
  }
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
