module "networking" {
  source = "./modules/networking"

  project_name         = var.project_name
  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  availability_zones   = var.availability_zones
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  enable_nat_gateway   = var.enable_nat_gateway
}

module "security" {
  source = "./modules/security"

  project_name               = var.project_name
  environment                = var.environment
  vpc_id                     = module.networking.vpc_id
  vpc_cidr                   = module.networking.vpc_cidr
  simulated_on_premises_cidr = var.simulated_on_premises_cidr
  allowed_admin_cidrs        = var.allowed_admin_cidrs
}

module "hybrid_connectivity" {
  source = "./modules/hybrid-connectivity"

  project_name               = var.project_name
  environment                = var.environment
  vpc_id                     = module.networking.vpc_id
  private_route_table_ids    = module.networking.private_route_table_ids
  simulated_on_premises_cidr = var.simulated_on_premises_cidr
  enable_site_to_site_vpn    = var.enable_site_to_site_vpn
  customer_gateway_ip        = var.customer_gateway_ip
  customer_gateway_bgp_asn   = var.customer_gateway_bgp_asn
}

module "monitoring" {
  source = "./modules/monitoring"

  project_name            = var.project_name
  environment             = var.environment
  vpc_id                  = module.networking.vpc_id
  enable_vpc_flow_logs    = var.enable_vpc_flow_logs
  flow_log_retention_days = var.flow_log_retention_days
}
