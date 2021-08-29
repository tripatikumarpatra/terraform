variable "accessKey" {
  default = "AK"
}
variable "secretKey" {
  default = "SK"
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

 

# Create Security Group
resource "aws_security_group" "vpc-sg-1" {
  name        = "vpc-sg-1"
  ingress {
    description = "Allow Port 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow Port 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow Port 443"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "ec2vm" {
  ami                    = var.AMI
  instance_type          = "t2.micro"
  key_name               = "iac"
  user_data              = file("${path.module}/app1-install.sh")
  vpc_security_group_ids = [aws_security_group.vpc-sg-1.id]
  tags = {
    "Name" = "EC2 Demo"
  }
}
