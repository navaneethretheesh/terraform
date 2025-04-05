provider "aws" {
  region = "ap-south-1" # or your preferred region
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "nav-tfbucket"  # must be globally unique
  acl    = "private"

  tags = {
    Name        = "MyTerraformBucket"
    Environment = "Dev"
  }
}
