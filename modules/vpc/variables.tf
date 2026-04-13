<<<<<<< HEAD
=======
# Environment variables
variable "region" {
  description = "AWS region"
  type        = string
}

>>>>>>> f4440188ab6c253222ef11af85a5fdec83784071
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

<<<<<<< HEAD
=======
variable "availability_zone_1" {
  description = "Availability Zone 1"
  type        = string
}

variable "availability_zone_2" {
  description = "Availability Zone 2"
  type        = string
}
>>>>>>> f4440188ab6c253222ef11af85a5fdec83784071

# VPC variables
variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "enable_dns_support" {
<<<<<<< HEAD
  description = "Enable DNS support in the VPC"
=======
  description = "Enable DNS support"
>>>>>>> f4440188ab6c253222ef11af85a5fdec83784071
  type        = bool
}

variable "enable_dns_hostnames" {
<<<<<<< HEAD
  description = "Enable DNS hostnames in the VPC"
  type        = bool
}

variable "availability_zone_1" {
  description = "Availability Zone 1"
  type        = string
}

variable "availability_zone_2" {
  description = "Availability Zone 2"
  type        = string
}

variable "map_public_ip_on_launch" {
  description = "Assign public IP addresses to resources launched in public subnets"
=======
  description = "Enable DNS hostnames"
  type        = bool
}

variable "map_public_ip_on_launch" {
  description = "Assign public IPs to public subnets"
>>>>>>> f4440188ab6c253222ef11af85a5fdec83784071
  type        = bool
}

variable "private_map_public_ip_on_launch" {
<<<<<<< HEAD
  description = "Assign public IP addresses to resources launched in private subnets"
=======
  description = "Assign public IPs to private subnets"
>>>>>>> f4440188ab6c253222ef11af85a5fdec83784071
  type        = bool
}

variable "public_subnet_az1_cidr" {
<<<<<<< HEAD
  description = "CIDR block for public subnet in Availability Zone 1"
=======
  description = "Public subnet AZ1 CIDR"
>>>>>>> f4440188ab6c253222ef11af85a5fdec83784071
  type        = string
}

variable "public_subnet_az2_cidr" {
<<<<<<< HEAD
  description = "CIDR block for public subnet in Availability Zone 2"
  type        = string
}

variable "private_app_subnet_az1_cidr" {
  description = "CIDR block for private application subnet in Availability Zone 1"
  type        = string
}

variable "private_app_subnet_az2_cidr" {
  description = "CIDR block for private application subnet in Availability Zone 2"
  type        = string
}

variable "private_data_subnet_az1_cidr" {
  description = "CIDR block for private data subnet in Availability Zone 1"
  type        = string
}

variable "private_data_subnet_az2_cidr" {
  description = "CIDR block for private data subnet in Availability Zone 2"
=======
  description = "Public subnet AZ2 CIDR"
  type        = string
}

variable "private_subnet_az1_cidr" {
  description = "Private subnet AZ1 CIDR"
  type        = string
}

variable "private_subnet_az2_cidr" {
  description = "Private subnet AZ2 CIDR"
>>>>>>> f4440188ab6c253222ef11af85a5fdec83784071
  type        = string
}