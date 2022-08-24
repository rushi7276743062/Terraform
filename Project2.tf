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
