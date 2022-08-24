
variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "ssh_key_name" {}

variable "private_key_path" {}

variable "region" {
    default = "us-east-1"
}

variable "vpc_cidr" {
    default = "10.0.0.0/16"
  
}

variable "public_subnet1_cidr" {
  default = "10.0.0.0/24"
}

variable "private_subnet1_cidr" {
  default = "10.0.1.0/24"
}


###############################################################################################################
# Provider

provider "aws" {
    access_key = var.aws_access_key
    secret_key = var.aws_secret_key
    region = var.region
}

################################################################################################################
# Resources

# AWS VPC
resource "aws_vpc" "myvpc" {
  cidr_block =  = var.vpc_cidr
  enable_dns_hostnames = "true"
}

# AWS Subnet 
resource "aws_subnet" "public_subnet1" {
    cidr_block = var.public_subnet1_cidr
    vpc_id = aws_vpc.myvpc.id
    map_public_ip_on_launch = "true"
    availability_zone = data.aws_availability_zones.available
}

resource "aws_subnet" "private_subnet1" {
  cidr_block = var.private_subnet1_cidr
  vpc_id = aws_vpc.myvpc.id
  availability_zone = data.aws_availability_zones.available
}

# AWS Internet Gateway

resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.myvpc.id 
}

# AWS Route Table

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.myvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.myvpc.id
}


# AWS Route Table Association
resource "aws_route_table_association" "route_public1" {
  subnet_id = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "route-private1" {
  subnet_id = aws_subnet.private_subnet1.id
  route_table_id = aws_route_table.private_route_table.id
  
}
###############################################################################################################
# Data 

data "aws_availability_zones" "available" {
    state = "available"
  
}

data "aws_ami" "aws-linux" {
    most_recent = "true"
    owners = ["amazon"]
    filter {
      name = "name"
      values = ["amzn-ami-hvm*"]
    }
    filter {
      name = "root-device-type"
      values = ["ebs"]
    }
    filter {
      name = "virtualization-type"
      values = ["hvm"]
    }
  
}

################################################################################################################
# Outputs

output "instance-dns" {
  value = public_dns
  
}
