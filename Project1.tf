
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

resource "aws_vpc" "myvpc" {
  cidr_block =  = var.vpc_cidr
  enable_dns_hostnames = "true"
}

resource "aws_subnet" "public_subnet1" {
    cidr_block = var.public_subnet1_cidr
    vpc_id = aws_vpc.myvpc.id
    map_public_ip_on_launch = "true"
    availability_zone = data.aws_availability_zones.available
}

###############################################################################################################
# Data 

data "aws_availability_zones" "available" {
    state = "available"
  
}
