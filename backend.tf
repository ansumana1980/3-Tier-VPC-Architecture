# Store the Terraform state in an S3 bucket
terraform {
  backend "s3" {
    bucket         = "3-tier-vpc-architecture-terraform-state"
    key            = "3-tier-vpc-architecture/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-3-tier-vpc-architecture-locks"
    # profile = "terraform-user"
  }
}