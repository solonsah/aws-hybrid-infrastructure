output "vpc_id" {
  description = "ID of the created VPC."
  value       = aws_vpc.this.id
}

output "vpc_cidr" {
  description = "CIDR block assigned to the VPC."
  value       = aws_vpc.this.cidr_block
}

output "public_subnet_ids" {
  description = "Map of Availability Zones to public subnet IDs."
  value = {
    for availability_zone, subnet in aws_subnet.public :
    availability_zone => subnet.id
  }
}

output "private_subnet_ids" {
  description = "Map of Availability Zones to private subnet IDs."
  value = {
    for availability_zone, subnet in aws_subnet.private :
    availability_zone => subnet.id
  }
}

output "public_route_table_id" {
  description = "ID of the public route table."
  value       = aws_route_table.public.id
}

output "private_route_table_ids" {
  description = "Map of Availability Zones to private route-table IDs."
  value = {
    for availability_zone, route_table in aws_route_table.private :
    availability_zone => route_table.id
  }
}

output "nat_gateway_ids" {
  description = "Map of Availability Zones to NAT gateway IDs when enabled."
  value = {
    for availability_zone, nat_gateway in aws_nat_gateway.this :
    availability_zone => nat_gateway.id
  }
}
