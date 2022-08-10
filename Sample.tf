provider "aws" {
    region = "us-east-1"
    secret_key = ""
    access_key = ""
}

resource "aws_instance" "web-server" {
    ami = ""
    instance_type = "t2.micro"
  
}

resource "aws_s3" "" {
  
}