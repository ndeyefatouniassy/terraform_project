provider "aws" {
  region = var.region
}

module "ec2_instance" {
  source = "C:/Users/HP 1030 G2/Bureau/Terraform_Project/module"
  name           = "example-instance"
  ami_id         = "ami-084568db4383264d4" #var.ami_id
  instance_type  = "t2.micro"#var.instance_type
  key_name       = "my-ssh-key"#var.key_name
  vpc_id         = "vpc-0734c73b4f9dbc03c"#var.vpc_id
  subnet_id      = "subnet-0e7a0d1908ebd0550"#var.subnet_id
  
  associate_public_ip     = true
  create_elastic_ip       = true
  create_ssh_security_group = true
  ssh_cidr_blocks         = ["102.164.181.195/32"]
  
  root_volume_size = 20
  
  tags = {
    Environment = "dev"
    Project     = "terraform-aws-ec2-example"
  }
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "ami_id" {
  description = "ID of the AMI to use"
  type        = string
}

variable "instance_type" {
  description = "Type of EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet"
  type        = string
}