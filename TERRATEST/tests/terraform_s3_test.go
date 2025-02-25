package test

import (
	"fmt"
	"strings"
	"testing"
	"time"

	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestTerraformS3(t *testing.T) {
	t.Parallel()

	rawBucketName := fmt.Sprintf("terraform-test-bucket-%d-%s", time.Now().Unix(), random.UniqueId())
	bucketName := strings.ToLower(rawBucketName)

	terraformOptions := &terraform.Options{
		TerraformDir:    "../",
		TerraformBinary: "terraform_1.7.5",
		Vars: map[string]interface{}{
			"bucket_name": bucketName,
		},
	}

	terraform.InitAndApply(t, terraformOptions)

	// Verify if the S3 bucket was created successfully
	outputBucketName := terraform.Output(t, terraformOptions, "bucket_name")
	assert.NotEmpty(t, outputBucketName, "The bucket name cannot be empty")

	// Verify if the KMS key was created successfully
	encryptionKey := terraform.Output(t, terraformOptions, "encryption_key_arn")
	assert.NotEmpty(t, encryptionKey, "The KMS key cannot be empty")


	terraform.Destroy(t, terraformOptions)
}