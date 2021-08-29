variable "accessKey" {
  default = "accessKey"
}
variable "secretKey" {
  default = "SecretKey"
}
variable "AWS_REGION" {
  default = "us-east-2"
}
variable "AMI" {
default = "ami-0b9064170e32bde34"
}

provider "aws" {
  access_key = var.accessKey
  secret_key = var.secretKey
  region     = var.AWS_REGION
}


resource "aws_instance" "ec2vm" {
  ami                    = var.AMI
  instance_type          = "t2.micro"
  key_name               = "iac"
  user_data              = file("${path.module}/app1-install.sh")
  tags = {
    "Name" = "EC2 Demo"
  }
}
