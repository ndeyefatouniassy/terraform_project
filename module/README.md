# Module Terraform AWS EC2

Module Terraform pour déployer une instance EC2 sur AWS avec des configurations de sécurité renforcées.

## Caractéristiques

- Création d'une instance EC2 sécurisée
- Groupe de sécurité SSH


## Prérequis

- Terraform >= 1.0.0
- AWS CLI configuré avec les permissions appropriées
- VPC et sous-réseau existants

## Utilisation

```hcl
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

  tags = {
    Environment = "dev"
    Project     = "my-project"
  }
}
```
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eip.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_security_group.launch-wizard-1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami_id"></a> [ami\_id](#input\_ami\_id) | ID of the AMI to use for the EC2 instance | `string` | n/a | yes |
| <a name="input_associate_public_ip"></a> [associate\_public\_ip](#input\_associate\_public\_ip) | Whether to associate a public IP address with the instance | `bool` | `false` | no |
| <a name="input_create_elastic_ip"></a> [create\_elastic\_ip](#input\_create\_elastic\_ip) | Whether to create and attach an Elastic IP to the instance | `bool` | `false` | no |
| <a name="input_create_ssh_security_group"></a> [create\_ssh\_security\_group](#input\_create\_ssh\_security\_group) | Whether to create a security group for SSH access | `bool` | `false` | no |
| <a name="input_enable_detailed_monitoring"></a> [enable\_detailed\_monitoring](#input\_enable\_detailed\_monitoring) | Whether to enable detailed monitoring on the instance | `bool` | `false` | no |
| <a name="input_encrypt_root_volume"></a> [encrypt\_root\_volume](#input\_encrypt\_root\_volume) | Whether to encrypt the root volume | `bool` | `true` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Type of EC2 instance to use | `string` | `"t2.micro"` | no |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | Name of the SSH key pair to use | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the EC2 instance | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | `"us-east-1"` | no |
| <a name="input_root_volume_size"></a> [root\_volume\_size](#input\_root\_volume\_size) | Size of the root volume in GB | `number` | `8` | no |
| <a name="input_root_volume_type"></a> [root\_volume\_type](#input\_root\_volume\_type) | Type of the root volume (standard, gp2, gp3, io1, io2) | `string` | `"gp3"` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | List of security group IDs to associate with the instance | `list(string)` | `[]` | no |
| <a name="input_ssh_cidr_blocks"></a> [ssh\_cidr\_blocks](#input\_ssh\_cidr\_blocks) | List of CIDR blocks to allow SSH access from | `list(string)` | <pre>[<br/>  "0.0.0.0/0"<br/>]</pre> | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | ID of the subnet where the instance will be created | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to all resources | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of the VPC where the instance will be created | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_elastic_ip"></a> [elastic\_ip](#output\_elastic\_ip) | Elastic IP address attached to the instance, if applicable |
| <a name="output_instance_arn"></a> [instance\_arn](#output\_instance\_arn) | ARN of the EC2 instance |
| <a name="output_instance_id"></a> [instance\_id](#output\_instance\_id) | ID of the EC2 instance |
| <a name="output_instance_private_ip"></a> [instance\_private\_ip](#output\_instance\_private\_ip) | Private IP address of the EC2 instance |
| <a name="output_instance_public_ip"></a> [instance\_public\_ip](#output\_instance\_public\_ip) | Public IP address of the EC2 instance, if applicable |
| <a name="output_ssh_security_group_id"></a> [ssh\_security\_group\_id](#output\_ssh\_security\_group\_id) | ID of the SSH security group, if created |
<!-- END_TF_DOCS -->
## Tests

Ce module est testé avec [Terratest](https://github.com/gruntwork-io/terratest).

```bash
cd test
go test -v -timeout 30m
```

## Validation de sécurité

Ce module est analysé avec [Trivy](https://github.com/aquasecurity/trivy) pour identifier les vulnérabilités.

```bash
trivy config --severity HIGH,CRITICAL .
```

## Licence

MIT
