# EC2 instance resource
resource "aws_instance" "this" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = var.security_group_ids
  subnet_id              = var.subnet_id

  associate_public_ip_address = var.associate_public_ip

  root_block_device {
    volume_size           = var.root_volume_size
    volume_type           = var.root_volume_type
    delete_on_termination = true
    encrypted             = var.encrypt_root_volume
  }

  tags = merge(
    {
      Name = var.name
    },
    var.tags
  )

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required" # IMDSv2 - security best practice
    http_put_response_hop_limit = 1
  }

  monitoring = var.enable_detailed_monitoring

  lifecycle {
    create_before_destroy = true
  }
}

# Security group for SSH access
resource "aws_security_group" "launch-wizard-1" {
  count       = var.create_ssh_security_group ? 1 : 0
  name        = "${var.name}-ssh-sg"
  description = "Security group for SSH access to ${var.name}"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.ssh_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    {
      Name = "${var.name}-ssh-sg"
    },
    var.tags
  )
}



# Create Elastic IP if specified
resource "aws_eip" "this" {
  count    = var.create_elastic_ip ? 1 : 0
  instance = aws_instance.this.id
  domain   = "vpc"

  tags = merge(
    {
      Name = "${var.name}-eip"
    },
    var.tags
  )
}
