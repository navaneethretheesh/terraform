provider "aws" {
  region = "ap-south-1"
}

#  Create EC2 instance
resource "aws_instance" "example" {
  ami           =  "ami-03bb6d83c60fc5f7c"  
  instance_type = "t2.micro"

  tags = {
    Name = "EC2-With-EBS"
  }
}

#  Create EBS volume
resource "aws_ebs_volume" "example_volume" {
  availability_zone = aws_instance.example.availability_zone
  size              = 8 
  type              = "gp2"

  tags = {
    Name = "MyEBSVolume"
  }
}

#  Attach EBS volume to EC2 instance
resource "aws_volume_attachment" "ebs_attached" {
  device_name = "/dev/sdf"
  volume_id   = aws_ebs_volume.example_volume.id
  instance_id = aws_instance.example.id
  force_detach = true
}

