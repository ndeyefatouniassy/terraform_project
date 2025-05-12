output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.this.id
}

output "instance_arn" {
  description = "ARN of the EC2 instance"
  value       = aws_instance.this.arn
}

output "instance_private_ip" {
  description = "Private IP address of the EC2 instance"
  value       = aws_instance.this.private_ip
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance, if applicable"
  value       = aws_instance.this.public_ip
}

output "elastic_ip" {
  description = "Elastic IP address attached to the instance, if applicable"
  value       = var.create_elastic_ip ? aws_eip.this[0].public_ip : null
}

output "ssh_security_group_id" {
  description = "ID of the SSH security group, if created"
  value       = var.create_ssh_security_group ? aws_security_group.launch-wizard-1[0].id : null
}
