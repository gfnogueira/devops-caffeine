package test

import (
	"context"
	"testing"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/service/ec2"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestTerraformSG(t *testing.T) {
	t.Parallel()

	terraformOptions := &terraform.Options{
		TerraformDir:    "../",
		TerraformBinary: "terraform_1.7.5",
	}

	terraform.InitAndApply(t, terraformOptions)

	sgID := terraform.Output(t, terraformOptions, "sg_id")
	awsRegion := "us-east-1"

	// Load AWS configuration
	cfg, err := config.LoadDefaultConfig(context.TODO(), config.WithRegion(awsRegion))
	assert.NoError(t, err)

	// Create EC2 client
	ec2Svc := ec2.NewFromConfig(cfg)


	sgInput := &ec2.DescribeSecurityGroupsInput{
		GroupIds: []string{sgID},
	}

	result, err := ec2Svc.DescribeSecurityGroups(context.TODO(), sgInput)
	assert.NoError(t, err)
	assert.Len(t, result.SecurityGroups, 1, "Expected to find exactly one security group")

	// Ensure there are no open 0.0.0.0/0 inbound rules
	for _, sg := range result.SecurityGroups {
		for _, rule := range sg.IpPermissions {
			for _, ipRange := range rule.IpRanges {
				assert.NotEqual(t, "0.0.0.0/0", aws.ToString(ipRange.CidrIp), "Inbound traffic is globally open!")
			}
		}
	}


	defer terraform.Destroy(t, terraformOptions)
}