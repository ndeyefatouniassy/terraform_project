package test

import (
	"fmt"
	"testing"

	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestTerraformAwsEc2Instance(t *testing.T) {
	t.Parallel()

	uniqueID := random.UniqueId()
	instanceName := fmt.Sprintf("terratest-ec2-%s", uniqueID)
	awsRegion := "us-east-1"

	terraformOptions := &terraform.Options{
		TerraformDir: "../exemple/simple", // Chemin relatif vers votre code Terraform

		Vars: map[string]interface{}{
			"region":        awsRegion,
			"ami_id":        "ami-084568db4383264d4", // Remplacez par un AMI valide dans votre région
			"instance_type": "t2.micro",
			"name":          instanceName,
			"vpc_id":        "vpc-0734c73b4f9dbc03c",    // Remplacez par un VPC valide
			"subnet_id":     "subnet-0e7a0d1908ebd0550", // Remplacez par un Subnet valide
			"key_name":      "my-ssh-key",               // Remplacez par une clé SSH valide
		},

		EnvVars: map[string]string{
			"AWS_DEFAULT_REGION": awsRegion,
		},
	}

	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)

	instanceID := terraform.Output(t, terraformOptions, "instance_id")
	publicIP := terraform.Output(t, terraformOptions, "instance_public_ip")

	assert.NotEmpty(t, instanceID, "L'ID de l'instance ne doit pas être vide")
	assert.NotEmpty(t, publicIP, "L'adresse IP publique ne doit pas être vide")
}
