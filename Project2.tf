###########################################################################################################
# Variable

variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "region" {
    default = "us-east-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/0"
}

variable "public_subnet_cidr" {
    default = "10.0.0.0/0"
}

variable "enviroment_list" {
  type = list(string)
  default = [ "Dev","QA","Stage","Production" ]

}

variable "enviroment_map" {
  type = map(string)
  default = {
    "DEV" = "DEV",
    "QA" = "QA",
    "Stage" = "Stage",
    "Production" = "production"
  }

}

variable "enviroment_instance_type" {
    type = map(string)
    default = {
    "DEV" = "t2.micro",
    "QA" = "t2.micro",
    "Stage" = "t2.micro"
    "Production" = "t2.micro"
    }
}

variable "enviroment_instance_setting" {
    type = map(object({instance_type=string,monitoring=bool}))
    default = {
      "DEV" = {
        instance_type = "t2.micro"
        monitoring = false
      }
      "QA" = {
        instance_type = "t2.micro"
        monitoring = false
      }
      "Stage" = {
        instance_type = "t2.micro"
        monitoring = false
      }
      "Production" = {
        instance_type = "t2.micro"
        monitoring = false
      }

    }
  
}
