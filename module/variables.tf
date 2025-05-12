variable "name" {
  description = "Name of the EC2 instance"
  type        = string
}


variable "ami_id" {
  description = "ID of the AMI to use for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "Type of EC2 instance to use"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Name of the SSH key pair to use"
  type        = string
  default     = null
}

variable "vpc_id" {
  description = "ID of the VPC where the instance will be created"
  type        = string
}


# Ajouter les autres variables nécessaires...

variable "subnet_id" {
  description = "ID of the subnet where the instance will be created"
  type        = string
}

variable "security_group_ids" {
  description = "List of security group IDs to associate with the instance"
  type        = list(string)
  default     = []
}

variable "associate_public_ip" {
  description = "Whether to associate a public IP address with the instance"
  type        = bool
  default     = false
}

variable "create_elastic_ip" {
  description = "Whether to create and attach an Elastic IP to the instance"
  type        = bool
  default     = false
}

variable "root_volume_size" {
  description = "Size of the root volume in GB"
  type        = number
  default     = 8
}

variable "root_volume_type" {
  description = "Type of the root volume (standard, gp2, gp3, io1, io2)"
  type        = string
  default     = "gp3"
}

variable "encrypt_root_volume" {
  description = "Whether to encrypt the root volume"
  type        = bool
  default     = true
}

variable "enable_detailed_monitoring" {
  description = "Whether to enable detailed monitoring on the instance"
  type        = bool
  default     = false
}

variable "create_ssh_security_group" {
  description = "Whether to create a security group for SSH access"
  type        = bool
  default     = false
}

variable "ssh_cidr_blocks" {
  description = "List of CIDR blocks to allow SSH access from"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
