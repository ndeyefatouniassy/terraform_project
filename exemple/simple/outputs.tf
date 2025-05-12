output "instance_id" {
  description = "ID of the EC2 instance"
  value       = module.ec2_instance.instance_id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = module.ec2_instance.instance_public_ip
}

output "elastic_ip" {
  description = "Elastic IP address attached to the instance"
  value       = module.ec2_instance.elastic_ip
}
