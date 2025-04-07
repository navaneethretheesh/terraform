provider "aws" {
  region = "ap-south-1"
}

#  Create IAM User
resource "aws_iam_user" "example_user" {
  name = "terraform-user"
  tags = {
    CreatedBy = "Terraform"
  }
}

#  Create IAM Access Key (for programmatic access)
resource "aws_iam_access_key" "user_key" {
  user = aws_iam_user.example_user.name
}

#  Create a Custom Policy
resource "aws_iam_policy" "custom_policy" {
  name        = "terraform-user-policy"
  description = "Custom policy for the user created by Terraform"
  policy      = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "s3:ListBucket",
          "s3:GetObject"
        ],
        Effect   = "Allow",
        Resource = "*"
      }
    ]
  })
}

#  Attach Policy to the User
resource "aws_iam_user_policy_attachment" "attach_policy" {
  user       = aws_iam_user.example_user.name
  policy_arn = aws_iam_policy.custom_policy.arn
}

