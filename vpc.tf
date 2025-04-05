provider "aws" {
  region = "ap-south-1"
}


resource "aws_vpc" "class_a_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "class-a-vpc"
  }
}

resource "aws_subnet" "class_a_subnet" {
  vpc_id            = aws_vpc.class_a_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-south-1a"
  tags = {
    Name = "class-a-subnet"
  }
}

resource "aws_internet_gateway" "class_a_igw" {
  vpc_id = aws_vpc.class_a_vpc.id
  tags = {
    Name = "class-a-igw"
  }
}

resource "aws_route_table" "class_a_rt" {
  vpc_id = aws_vpc.class_a_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.class_a_igw.id
  }

  tags = {
    Name = "class-a-route-table"
  }
}

resource "aws_route_table_association" "class_a_rta" {
  subnet_id      = aws_subnet.class_a_subnet.id
  route_table_id = aws_route_table.class_a_rt.id
}

resource "aws_vpc" "class_c_vpc" {
  cidr_block = "192.168.0.0/24"
  tags = {
    Name = "class-c-vpc"
  }
}

resource "aws_subnet" "class_c_subnet" {
  vpc_id            = aws_vpc.class_c_vpc.id
  cidr_block        = "192.168.0.0/28"
  availability_zone = "ap-south-1b"
  tags = {
    Name = "class-c-subnet"
  }
}

resource "aws_internet_gateway" "class_c_igw" {
  vpc_id = aws_vpc.class_c_vpc.id
  tags = {
    Name = "class-c-igw"
  }
}

resource "aws_route_table" "class_c_rt" {
  vpc_id = aws_vpc.class_c_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.class_c_igw.id
  }

  tags = {
    Name = "class-c-route-table"
  }
}

resource "aws_route_table_association" "class_c_rta" {
  subnet_id      = aws_subnet.class_c_subnet.id
  route_table_id = aws_route_table.class_c_rt.id
}

