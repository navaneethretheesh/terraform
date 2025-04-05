provider "aws" {
  region = "ap-south-1"
}

resource "random_id" "bucket_suffix" {
  byte_length = 4
}

# Create the bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-terraform-bucket-${random_id.bucket_suffix.hex}"

  tags = {
    Name        = "nav-terraobj-buck3"
    Environment = "Dev"
  }
}

# ✅ Disable public access block so we can apply a public policy
resource "aws_s3_bucket_public_access_block" "no_block" {
  bucket = aws_s3_bucket.my_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# ✅ Apply a public-read bucket policy
resource "aws_s3_bucket_policy" "public_policy" {
  bucket = aws_s3_bucket.my_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.my_bucket.arn}/*"
      }
    ]
  })
}

# ✅ Upload file without ACL
resource "aws_s3_object" "upload_sample_file" {
  bucket       = aws_s3_bucket.my_bucket.id
  key          = "sample.txt"
  source       = "${path.module}/sample.txt"
  etag         = filemd5("${path.module}/sample.txt")
  content_type = "text/plain"
}

