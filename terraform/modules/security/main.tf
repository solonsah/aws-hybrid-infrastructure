locals {
  name_prefix = "${var.project_name}-${var.environment}"
}

resource "aws_security_group" "workload" {
  name        = "${local.name_prefix}-workload-sg"
  description = "Controlled access for private hybrid workloads"
  vpc_id      = var.vpc_id

  revoke_rules_on_delete = true

  tags = {
    Name = "${local.name_prefix}-workload-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "https_from_vpc" {
  security_group_id = aws_security_group.workload.id
  description       = "Permit HTTPS from within the VPC"
  cidr_ipv4         = var.vpc_cidr
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "https_from_on_premises" {
  security_group_id = aws_security_group.workload.id
  description       = "Permit HTTPS from the simulated on-premises network"
  cidr_ipv4         = var.simulated_on_premises_cidr
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "ssh_from_approved_admin" {
  for_each = toset(var.allowed_admin_cidrs)

  security_group_id = aws_security_group.workload.id
  description       = "Permit SSH from an explicitly approved administrative network"
  cidr_ipv4         = each.value
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "https_outbound" {
  security_group_id = aws_security_group.workload.id
  description       = "Permit outbound HTTPS for approved updates and services"
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "dns_udp" {
  security_group_id = aws_security_group.workload.id
  description       = "Permit UDP DNS queries within the VPC"
  cidr_ipv4         = var.vpc_cidr
  from_port         = 53
  to_port           = 53
  ip_protocol       = "udp"
}

resource "aws_vpc_security_group_egress_rule" "dns_tcp" {
  security_group_id = aws_security_group.workload.id
  description       = "Permit TCP DNS queries within the VPC"
  cidr_ipv4         = var.vpc_cidr
  from_port         = 53
  to_port           = 53
  ip_protocol       = "tcp"
}
