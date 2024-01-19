# Retrieves the information from the remote vpc state file
data "terraform_remote_state" "vpc" {
  backend  = "s3"
  config = {
    bucket = "b53-s3-bucket"
    key    = "vpc/${var.ENV}/terraform.tfstate"
    region = "us-east-1"
  }
}

#Retrieves the information from the remote vpc alb file
data "terraform_remote_state" "alb" {
  backend  = "s3"
  config = {
    bucket = "b53-s3-bucket"
    key    = "alb/${var.ENV}/terraform.tfstate"
    region = "us-east-1"
  }
}

#Retrieves the information from the remote db file
data "terraform_remote_state" "db" {
  backend  = "s3"
  config = {
    bucket = "b53-s3-bucket"
    key    = "databases/${var.ENV}/terraform.tfstate"
    region = "us-east-1"
  }
}

# Fetches the information of the LAB AMI
data "aws_ami" "ami" {
  most_recent      = true
  name_regex       = "Lab-Ami-With-Ansible_Installed"
  owners           = ["self"] 
}
