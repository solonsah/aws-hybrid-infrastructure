locals {
  name_prefix = "${var.project_name}-${var.environment}"
}

resource "aws_vpn_gateway" "this" {
  count = var.enable_site_to_site_vpn ? 1 : 0

  vpc_id = var.vpc_id

  tags = {
    Name = "${local.name_prefix}-vpn-gateway"
  }
}

resource "aws_customer_gateway" "this" {
  count = var.enable_site_to_site_vpn ? 1 : 0

  bgp_asn    = var.customer_gateway_bgp_asn
  ip_address = var.customer_gateway_ip
  type       = "ipsec.1"

  tags = {
    Name = "${local.name_prefix}-customer-gateway"
  }

  lifecycle {
    precondition {
      condition     = var.customer_gateway_ip != null
      error_message = "customer_gateway_ip must be provided when Site-to-Site VPN creation is enabled."
    }
  }
}

resource "aws_vpn_connection" "this" {
  count = var.enable_site_to_site_vpn ? 1 : 0

  customer_gateway_id = aws_customer_gateway.this[0].id
  vpn_gateway_id      = aws_vpn_gateway.this[0].id
  type                = "ipsec.1"
  static_routes_only  = true

  tags = {
    Name = "${local.name_prefix}-vpn-connection"
  }
}

resource "aws_vpn_connection_route" "on_premises" {
  count = var.enable_site_to_site_vpn ? 1 : 0

  destination_cidr_block = var.simulated_on_premises_cidr
  vpn_connection_id      = aws_vpn_connection.this[0].id
}

resource "aws_vpn_gateway_route_propagation" "private" {
  for_each = var.enable_site_to_site_vpn ? var.private_route_table_ids : {}

  vpn_gateway_id = aws_vpn_gateway.this[0].id
  route_table_id = each.value
}
