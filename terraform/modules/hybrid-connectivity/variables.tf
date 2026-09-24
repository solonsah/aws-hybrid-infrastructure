variable "project_name" {
  description = "Project name used for resource naming."
  type        = string
}

variable "environment" {
  description = "Deployment environment."
  type        = string
}

variable "vpc_id" {
  description = "ID of the AWS VPC."
  type        = string
}

variable "private_route_table_ids" {
  description = "Map of Availability Zones to private route-table IDs."
  type        = map(string)
}

variable "simulated_on_premises_cidr" {
  description = "CIDR block representing the simulated on-premises network."
  type        = string
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
