# configured aws provider with proper credentials
provider "aws" {
   region     = "us-east-1"
   access_key = ""
   secret_key = ""
}

# store the terraform state file in s3
terraform {
  backend "s3" {
    bucket  = "myterraformbucket-test"
    key     = "build/terraform.tfstate"
    region  = "us-east-1"
    profile = "terraform-user"
  }
}

# create a VPC
resource "aws_vpc" "dev-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Dev"
  }
}

# Create an internet gateway
resource "aws_internet_gateway" "dev-igw" {
  vpc_id = aws_vpc.dev-vpc.id
}

resource "aws_route_table" "dev-route-01" {
  vpc_id = aws_vpc.dev-vpc.id

  route {
    cidr_block = "0.0.0.0/0" # NOT SAFE JUST FOR TESTING
    gateway_id = aws_internet_gateway.dev-igw.id
  }

  route {
    ipv6_cidr_block        = "::/0"
    egress_only_gateway_id = aws_internet_gateway.dev-igw.id
  }

  tags = {
    Name = "Dev"
  }
}

# Create a subnet

resource "aws_subnet" "subnet-01" {
  vpc_id = aws_vpc.dev-vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "Dev-subnet"
  }
}

# Associate subnet with Route table

resource "aws_route_table_association" "associate-subnet" {
  subnet_id      = aws_subnet.subnet-01.id
  route_table_id = aws_route_table.dev-route-01.id
}

# Create Security Group to allow port 22, 80, 443

resource "aws_security_group" "allow_web" {
  name        = "allow_web_traffic"
  description = "Allow Web inbound traffic"
  vpc_id      = aws_vpc.dev-vpc.id

  ingress {
    description      = "HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ] # Anyone can access
    # cidr_blocks      = [aws_vpc.dev-vpc.cidr_block]
    # ipv6_cidr_blocks = [aws_vpc.dev-vpc.ipv6_cidr_block]
  }
  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ] # Anyone can access
    # cidr_blocks      = [aws_vpc.dev-vpc.cidr_block]
    # ipv6_cidr_blocks = [aws_vpc.dev-vpc.ipv6_cidr_block]
  }
  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ] # Anyone can access
    # cidr_blocks      = [aws_vpc.dev-vpc.cidr_block]
    # ipv6_cidr_blocks = [aws_vpc.dev-vpc.ipv6_cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"] # Anyone can access
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_web"
  }
}

resource "aws_network_interface" "web_server_nic" {
  subnet_id       = aws_subnet.subnet-01.id
  private_ips     = ["10.0.0.50"]
  security_groups = [aws_security_group.allow_web.id]
}

resource "aws_eip" "lb" {
  domain                        = "vpc"
  network_interface             = aws_network_interface.web_server_nic.id
  associate_with_private_ip     = "10.0.1.50" # assign one from 10.0.0.50
  depends_on                    = [aws_internet_gateway.dev-igw]
}