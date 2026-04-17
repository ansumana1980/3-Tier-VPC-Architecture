# Create VPC module with public, private app, and private data subnets,
# internet gateway, NAT gateway, and route tables
module "vpc" {
  source = "./modules/vpc"

  region       = var.region
  project_name = var.project_name
  environment  = var.environment
  common_tags  = var.common_tags

  availability_zone_1 = var.availability_zone_1
  availability_zone_2 = var.availability_zone_2

  vpc_cidr_block                  = var.vpc_cidr_block
  enable_dns_support              = var.enable_dns_support
  enable_dns_hostnames            = var.enable_dns_hostnames
  map_public_ip_on_launch         = var.map_public_ip_on_launch
  private_map_public_ip_on_launch = var.private_map_public_ip_on_launch

  public_subnet_az1_cidr       = var.public_subnet_az1_cidr
  public_subnet_az2_cidr       = var.public_subnet_az2_cidr
  private_app_subnet_az1_cidr  = var.private_app_subnet_az1_cidr
  private_app_subnet_az2_cidr  = var.private_app_subnet_az2_cidr
  private_data_subnet_az1_cidr = var.private_data_subnet_az1_cidr
  private_data_subnet_az2_cidr = var.private_data_subnet_az2_cidr
}