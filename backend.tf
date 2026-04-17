# Store the Terraform state in an S3 bucket
terraform {
  backend "s3" {
    bucket         = "ansu-3-tier-vpc-terraform-state"
    key            = "ansu-3-tier-vpc/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-ansu-3-tier-vpc-locks"
    # profile = "terraform-user"
  }
}