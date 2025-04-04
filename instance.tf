provider "aws" {
  region = "ap-south-1" # Change to your preferred region
}

# Create Security Group
resource "aws_security_group" "my_security_group" {
  name        = "terra_sg"
  description = "Security group with ingress and egress rules"
  

  # Allow SSH (port 22)
  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow HTTP (port 80)
  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "MySecurityGroup"
  }
}

# Create EC2 Instance and Attach the Security Group
resource "aws_instance" "my_instance" {
  ami           = "ami-002f6e91abff6eb96" # Replace with the latest AMI for your region
  instance_type = "t2.micro"
  vpc_security_group_ids = ["sg-038db67f21f2c79b8"]
  key_name      = "newt" # Replace with your actual key pair name

  tags = {
    Name = "MyTerraformInstance"
  }
}

