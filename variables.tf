<<<<<<< HEAD
# -----------------------------
# ENVIRONMENT VARIABLES
# -----------------------------
=======
# Environment variables
>>>>>>> f4440188ab6c253222ef11af85a5fdec83784071
variable "region" {
  description = "AWS region"
  type        = string
}
<<<<<<< HEAD

variable "project_name" {
  description = "Project name used for naming resources"
  type        = string
}

variable "environment" {
  description = "Environment (dev, test, prod)"
  type        = string
}

variable "common_tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
}

variable "availability_zone_1" {
  description = "Availability Zone 1"
  type        = string
}

variable "availability_zone_2" {
  description = "Availability Zone 2"
  type        = string
}

# -----------------------------
# VPC VARIABLES
# -----------------------------
variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "enable_dns_support" {
  description = "Enable DNS support in the VPC"
  type        = bool
}

=======

variable "project_name" {
  description = "Project name used for naming resources"
  type        = string
}

variable "environment" {
  description = "Environment (dev, test, prod)"
  type        = string
}

variable "common_tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
}

variable "availability_zone_1" {
  description = "Availability Zone 1"
  type        = string
}

variable "availability_zone_2" {
  description = "Availability Zone 2"
  type        = string
}

# VPC variables
variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "enable_dns_support" {
  description = "Enable DNS support in the VPC"
  type        = bool
}

>>>>>>> f4440188ab6c253222ef11af85a5fdec83784071
variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames in the VPC"
  type        = bool
}

variable "map_public_ip_on_launch" {
  description = "Assign public IP addresses to resources launched in public subnets"
  type        = bool
}

variable "private_map_public_ip_on_launch" {
  description = "Assign public IP addresses to resources launched in private subnets"
  type        = bool
}

<<<<<<< HEAD
# -----------------------------
# PUBLIC SUBNETS (WEB TIER)
# -----------------------------
variable "public_subnet_az1_cidr" {
  description = "CIDR block for public subnet in AZ1"
=======
variable "public_subnet_az1_cidr" {
  description = "CIDR block for public subnet in Availability Zone 1"
>>>>>>> f4440188ab6c253222ef11af85a5fdec83784071
  type        = string
}

variable "public_subnet_az2_cidr" {
<<<<<<< HEAD
  description = "CIDR block for public subnet in AZ2"
  type        = string
}

# -----------------------------
# PRIVATE APP SUBNETS (APP TIER)
# -----------------------------
variable "private_app_subnet_az1_cidr" {
  description = "CIDR block for private app subnet in AZ1"
  type        = string
}

variable "private_app_subnet_az2_cidr" {
  description = "CIDR block for private app subnet in AZ2"
  type        = string
}

# -----------------------------
# PRIVATE DATA SUBNETS (DB TIER)
# -----------------------------
variable "private_data_subnet_az1_cidr" {
  description = "CIDR block for private data subnet in AZ1"
  type        = string
}

variable "private_data_subnet_az2_cidr" {
  description = "CIDR block for private data subnet in AZ2"
=======
  description = "CIDR block for public subnet in Availability Zone 2"
  type        = string
}

variable "private_subnet_az1_cidr" {
  description = "CIDR block for private subnet in Availability Zone 1"
  type        = string
}

variable "private_subnet_az2_cidr" {
  description = "CIDR block for private subnet in Availability Zone 2"
>>>>>>> f4440188ab6c253222ef11af85a5fdec83784071
  type        = string
}