package test

import (
	"fmt"
	"testing"

	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestTerraformAwsEc2Example(t *testing.T) {
	t.Parallel()

	// Génère un nom unique pour éviter les conflits
	uniqueID := random.UniqueId()
	instanceName := fmt.Sprintf("terratest-ec2-%s", uniqueID)

	// Région AWS pour le test
	awsRegion := "us-east-1"

	// Variables à passer au module Terraform
	terraformOptions := &terraform.Options{
		// Emplacement du code Terraform à tester
		TerraformDir: "C:/Users/HP 1030 G2/Bureau/Terraform_Project/exemple/simple",

		// Variables à passer
		Vars: map[string]interface{}{
			"region":        awsRegion,
			"ami_id":        "ami-084568db4383264d4", // Remplacer par un AMI valide dans votre région
			"instance_type": "t2.micro",
			"name":          instanceName,
			// Ces valeurs doivent être configurées selon votre environnement AWS:
			"vpc_id":    "vpc-0734c73b4f9dbc03c",    // Remplacer par un VPC valide
			"subnet_id": "subnet-0e7a0d1908ebd0550", // Remplacer par un Subnet valide
			"key_name":  "my-ssh-key",        // Remplacer par une clé SSH valide
		},

		// Options pour supprimer les ressources après le test
		EnvVars: map[string]string{
			"AWS_DEFAULT_REGION": awsRegion,
		},
	}

	// Nettoyage des ressources à la fin du test
	defer terraform.Destroy(t, terraformOptions)

	// Déploie l'infrastructure
	terraform.InitAndApply(t, terraformOptions)

	// Récupère l'ID de l'instance
	instanceID := terraform.Output(t, terraformOptions, "instance_id")

	// Vérifie que l'instance existe
	instance := aws.GetEc2InstanceDetailsE(t, instanceID, awsRegion)
	assert.Equal(t, "running", *instance.State.Name)

	// Vérifie que l'instance a le bon type
	assert.Equal(t, "t3.micro", *instance.InstanceType)

	// Vérifie que l'IP élastique est associée
	elasticIP := terraform.Output(t, terraformOptions, "elastic_ip")
	assert.NotEmpty(t, elasticIP, "Elastic IP should be created and associated")

	// Vérifie les tags
	instanceName, containsName := instance.Tags["Name"]
	assert.True(t, containsName)
	assert.Equal(t, "example-instance", *instanceName)
}