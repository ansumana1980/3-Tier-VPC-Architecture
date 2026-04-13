# store the terraform state in an s3 bucket
terraform {
  backend "s3" {
<<<<<<< HEAD
    bucket          = "3-tier-vpc-architecture-terraform-state"
    key             = "3-tier-vpc-architecture/terraform.tfstate"
    region          = "us-east-1"
    encrypt         = true
    dynamodb_table  = "terraform-3-tier-vpc-architecture-locks"
=======
    bucket         = "2-tier-vpc-architecture-terraform-state"
    key            = "2-tier-vpc-architecture/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-2-tier-vpc-architecture-locks"
>>>>>>> f4440188ab6c253222ef11af85a5fdec83784071
    # profile = "terraform-user"
  }


}

<<<<<<< HEAD
=======

# Life cycle rule to transition old versions to Glacier and expire them after a certain period
resource "aws_s3_bucket_lifecycle_configuration" "vpc_state" {
  bucket = "2-tier-vpc-architecture-terraform-state"
  rule {
    id     = "cleanup-old-versions"
    status = "Enabled"

    noncurrent_version_expiration {
      noncurrent_days = 90
    }
  }
}


>>>>>>> f4440188ab6c253222ef11af85a5fdec83784071
