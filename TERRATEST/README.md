# Terraform Testing with Terratest - PoC

This repository provides a **Proof of Concept (PoC)** for testing Terraform infrastructure using [Terratest](https://terratest.gruntwork.io/). It includes test cases for validating AWS resources such as **S3 Buckets** and **Security Groups**.

## 📌 Overview

Terratest is a Go testing framework that allows developers to write automated tests for infrastructure-as-code (IaC) configurations. This PoC demonstrates how to:

- Deploy AWS infrastructure using **Terraform**
- Validate Terraform outputs
- Fetch AWS resources dynamically and assert configurations
- Implement automated cleanup after tests

## 🛠 Installation

Follow these steps to set up your environment and run the tests:

### 1️⃣ Install Go

Ensure you have **Go** installed on your system:

```sh
# macOS
brew install go

# Ubuntu/Debian
sudo apt update && sudo apt install -y golang

# Windows (Using Chocolatey)
choco install golang
```

### 2️⃣ Initialize the Go Module

Navigate to the `tests` directory and initialize a Go module:

```sh
cd tests
go mod init terraform-terrtest-poc
```

### 3️⃣ Install Required Dependencies

Run the following `go get` commands to install the required Go packages:

```sh
go get github.com/gruntwork-io/terratest/modules/terraform
go get github.com/stretchr/testify/assert
go get github.com/gruntwork-io/terratest/modules/aws
go get github.com/aws/aws-sdk-go/aws
```


## 📂 Project Structure
```
.
├── tests
│   ├── terraform_s3_test.go        # Test case for S3 bucket
│   ├── terraform_sg_test.go        # Test case for Security Group
│   ├── go.mod                      # Go module dependencies
│   ├── go.sum                      # Dependency checksums
└── terraform
    ├── main.tf                     # Terraform configuration
    ├── outputs.tf                   # Terraform outputs
    ├── variables.tf                 # Terraform variables
    └── provider.tf                  # AWS provider configuration
```

-----

## 🚀 Running the Tests

Once the setup is complete, you can run the tests using the `go test` command.

### Running the S3 Test:

```sh
go test -v terraform_s3_test.go
```

#### ✅ Output (S3 Test):
```hcl
=== RUN   TestTerraformS3
=== PAUSE TestTerraformS3
=== CONT  TestTerraformS3
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67: 
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67: Terraform used the selected providers to generate the following execution
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67: plan. Resource actions are indicated with the following symbols:
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:   + create
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67: 
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67: Terraform will perform the following actions:
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67: 
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:   # aws_kms_key.this will be created
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:   + resource "aws_kms_key" "this" {
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:       + arn                                = (known after apply)
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:       + bypass_policy_lockout_safety_check = false
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:       + customer_master_key_spec           = "SYMMETRIC_DEFAULT"
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:       + description                        = "KMS key for S3 encryption"
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:       + enable_key_rotation                = false
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:       + id                                 = (known after apply)
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:       + is_enabled                         = true
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:       + key_id                             = (known after apply)
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:       + key_usage                          = "ENCRYPT_DECRYPT"
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:       + multi_region                       = (known after apply)
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:       + policy                             = (known after apply)
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:       + tags_all                           = (known after apply)
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:     }
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67: 
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:   # aws_s3_bucket.this will be created
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:   + resource "aws_s3_bucket" "this" {
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:       + acceleration_status         = (known after apply)
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:       + acl                         = (known after apply)
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:       + arn                         = (known after apply)
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:       + bucket                      = "terraform-test-bucket-1740455999-fvcshx"
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:       + bucket_domain_name          = (known after apply)
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:       + bucket_prefix               = (known after apply)
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:       + bucket_regional_domain_name = (known after apply)
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:       + force_destroy               = false
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:       + hosted_zone_id              = (known after apply)
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:       + id                          = (known after apply)
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:       + object_lock_enabled         = (known after apply)
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:       + policy                      = (known after apply)
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:       + region                      = (known after apply)
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:       + request_payer               = (known after apply)
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:       + tags_all                    = (known after apply)
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:       + website_domain              = (known after apply)
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:       + website_endpoint            = (known after apply)
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:     }
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67: 
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:   # aws_s3_bucket_server_side_encryption_configuration.this will be created
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:   + resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:       + bucket = (known after apply)
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:       + id     = (known after apply)
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67: 
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:       + rule {
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:           + apply_server_side_encryption_by_default {
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:               + kms_master_key_id = (known after apply)
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:               + sse_algorithm     = "aws:kms"
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:             }
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:         }
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:     }
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67: 
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:   # aws_security_group.secure_sg will be created
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:   + resource "aws_security_group" "secure_sg" {
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:       + arn                    = (known after apply)
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:       + description            = "Security Group that blocks global traffic"
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:       + egress                 = [
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:           + {
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:               + cidr_blocks      = [
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:                   + "0.0.0.0/0",
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:                 ]
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:               + description      = ""
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:               + from_port        = 0
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:               + ipv6_cidr_blocks = []
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:               + prefix_list_ids  = []
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:               + protocol         = "-1"
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:               + security_groups  = []
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:               + self             = false
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:               + to_port          = 0
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:             },
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:         ]
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:       + id                     = (known after apply)
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:       + ingress                = [
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:           + {
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:               + cidr_blocks      = [
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:                   + "10.0.0.0/24",
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:                 ]
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:               + description      = ""
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:               + from_port        = 22
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:               + ipv6_cidr_blocks = []
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:               + prefix_list_ids  = []
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:               + protocol         = "tcp"
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:               + security_groups  = []
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:               + self             = false
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:               + to_port          = 22
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:             },
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:         ]
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:       + name                   = "secure-sg"
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:       + name_prefix            = (known after apply)
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:       + owner_id               = (known after apply)
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:       + revoke_rules_on_delete = false
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:       + tags_all               = (known after apply)
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:       + vpc_id                 = (known after apply)
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:     }
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67: 
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67: Plan: 4 to add, 0 to change, 0 to destroy.
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67: 
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67: Changes to Outputs:
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:   + bucket_name        = (known after apply)
TestTerraformS3 2025-02-25T01:00:05-03:00 logger.go:67:   + encryption_key_arn = (known after apply)
TestTerraformS3 2025-02-25T01:00:06-03:00 logger.go:67: aws_kms_key.this: Creating...
TestTerraformS3 2025-02-25T01:00:06-03:00 logger.go:67: aws_security_group.secure_sg: Creating...
TestTerraformS3 2025-02-25T01:00:06-03:00 logger.go:67: aws_s3_bucket.this: Creating...
TestTerraformS3 2025-02-25T01:00:08-03:00 logger.go:67: aws_kms_key.this: Creation complete after 1s [id=3188d30d-c348-4503-9071-860356884f0c]
TestTerraformS3 2025-02-25T01:00:10-03:00 logger.go:67: aws_s3_bucket.this: Creation complete after 3s [id=terraform-test-bucket-1740455999-fvcshx]
TestTerraformS3 2025-02-25T01:00:10-03:00 logger.go:67: aws_s3_bucket_server_side_encryption_configuration.this: Creating...
TestTerraformS3 2025-02-25T01:00:10-03:00 logger.go:67: aws_s3_bucket_server_side_encryption_configuration.this: Creation complete after 1s [id=terraform-test-bucket-1740455999-fvcshx]
TestTerraformS3 2025-02-25T01:00:10-03:00 logger.go:67: aws_security_group.secure_sg: Creation complete after 4s [id=sg-0ffbb62075e0fb992]
TestTerraformS3 2025-02-25T01:00:11-03:00 logger.go:67: 
TestTerraformS3 2025-02-25T01:00:11-03:00 logger.go:67: Apply complete! Resources: 4 added, 0 changed, 0 destroyed.
TestTerraformS3 2025-02-25T01:00:11-03:00 logger.go:67: 
TestTerraformS3 2025-02-25T01:00:11-03:00 logger.go:67: Outputs:
TestTerraformS3 2025-02-25T01:00:11-03:00 logger.go:67: 
TestTerraformS3 2025-02-25T01:00:11-03:00 logger.go:67: bucket_name = "terraform-test-bucket-1740455999-fvcshx"
TestTerraformS3 2025-02-25T01:00:11-03:00 logger.go:67: encryption_key_arn = "arn:aws:kms:us-east-1:071090472443:key/3188d30d-c348-4503-9071-860356884f0c"
TestTerraformS3 2025-02-25T01:00:11-03:00 retry.go:91: terraform_1.7.5 [output -no-color -json bucket_name]
TestTerraformS3 2025-02-25T01:00:11-03:00 logger.go:67: Running command terraform_1.7.5 with args [output -no-color -json bucket_name]
TestTerraformS3 2025-02-25T01:00:13-03:00 logger.go:67: "terraform-test-bucket-1740455999-fvcshx"
TestTerraformS3 2025-02-25T01:00:13-03:00 retry.go:91: terraform_1.7.5 [output -no-color -json encryption_key_arn]
TestTerraformS3 2025-02-25T01:00:13-03:00 logger.go:67: Running command terraform_1.7.5 with args [output -no-color -json encryption_key_arn]
TestTerraformS3 2025-02-25T01:00:14-03:00 logger.go:67: "arn:aws:kms:us-east-1:071090472443:key/3188d30d-c348-4503-9071-860356884f0c"
TestTerraformS3 2025-02-25T01:00:14-03:00 retry.go:91: terraform_1.7.5 [destroy -auto-approve -input=false -var bucket_name=terraform-test-bucket-1740455999-fvcshx -lock=false]
TestTerraformS3 2025-02-25T01:00:14-03:00 logger.go:67: Running command terraform_1.7.5 with args [destroy -auto-approve -input=false -var bucket_name=terraform-test-bucket-1740455999-fvcshx -lock=false]
TestTerraformS3 2025-02-25T01:00:18-03:00 logger.go:67: aws_kms_key.this: Refreshing state... [id=3188d30d-c348-4503-9071-860356884f0c]
TestTerraformS3 2025-02-25T01:00:18-03:00 logger.go:67: aws_security_group.secure_sg: Refreshing state... [id=sg-0ffbb62075e0fb992]
TestTerraformS3 2025-02-25T01:00:18-03:00 logger.go:67: aws_s3_bucket.this: Refreshing state... [id=terraform-test-bucket-1740455999-fvcshx]
TestTerraformS3 2025-02-25T01:00:20-03:00 logger.go:67: aws_s3_bucket_server_side_encryption_configuration.this: Refreshing state... [id=terraform-test-bucket-1740455999-fvcshx]
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67: 
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67: Terraform used the selected providers to generate the following execution
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67: plan. Resource actions are indicated with the following symbols:
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:   - destroy
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67: 
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67: Terraform will perform the following actions:
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67: 
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:   # aws_kms_key.this will be destroyed
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:   - resource "aws_kms_key" "this" {
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:       - arn                                = "arn:aws:kms:us-east-1:071090472443:key/3188d30d-c348-4503-9071-860356884f0c" -> null
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:       - bypass_policy_lockout_safety_check = false -> null
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:       - customer_master_key_spec           = "SYMMETRIC_DEFAULT" -> null
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:       - description                        = "KMS key for S3 encryption" -> null
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:       - enable_key_rotation                = false -> null
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:       - id                                 = "3188d30d-c348-4503-9071-860356884f0c" -> null
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:       - is_enabled                         = true -> null
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:       - key_id                             = "3188d30d-c348-4503-9071-860356884f0c" -> null
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:       - key_usage                          = "ENCRYPT_DECRYPT" -> null
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:       - multi_region                       = false -> null
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:       - policy                             = jsonencode(
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:             {
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:               - Id        = "key-default-1"
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:               - Statement = [
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:                   - {
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:                       - Action    = "kms:*"
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:                       - Effect    = "Allow"
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:                       - Principal = {
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:                           - AWS = "arn:aws:iam::071090472443:root"
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:                         }
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:                       - Resource  = "*"
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:                       - Sid       = "Enable IAM User Permissions"
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:                     },
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:                 ]
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:               - Version   = "2012-10-17"
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:             }
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:         ) -> null
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:       - tags                               = {} -> null
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:       - tags_all                           = {} -> null
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:     }
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67: 
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:   # aws_s3_bucket.this will be destroyed
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:   - resource "aws_s3_bucket" "this" {
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:       - arn                         = "arn:aws:s3:::terraform-test-bucket-1740455999-fvcshx" -> null
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:       - bucket                      = "terraform-test-bucket-1740455999-fvcshx" -> null
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:       - bucket_domain_name          = "terraform-test-bucket-1740455999-fvcshx.s3.amazonaws.com" -> null
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:       - bucket_regional_domain_name = "terraform-test-bucket-1740455999-fvcshx.s3.amazonaws.com" -> null
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:       - force_destroy               = false -> null
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:       - hosted_zone_id              = "Z3AQBSTGFYJSTF" -> null
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:       - id                          = "terraform-test-bucket-1740455999-fvcshx" -> null
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:       - object_lock_enabled         = false -> null
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:       - region                      = "us-east-1" -> null
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:       - request_payer               = "BucketOwner" -> null
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:       - tags                        = {} -> null
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:       - tags_all                    = {} -> null
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67: 
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:       - grant {
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:           - id          = "d131019f8ca19c00de8d14117361488eebf2444f7887cfe4b741d6c934748fb0" -> null
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:           - permissions = [
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:               - "FULL_CONTROL",
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:             ] -> null
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:           - type        = "CanonicalUser" -> null
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:         }
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67: 
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:       - server_side_encryption_configuration {
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:           - rule {
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:               - bucket_key_enabled = false -> null
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67: 
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:               - apply_server_side_encryption_by_default {
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:                   - kms_master_key_id = "arn:aws:kms:us-east-1:071090472443:key/3188d30d-c348-4503-9071-860356884f0c" -> null
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:                   - sse_algorithm     = "aws:kms" -> null
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:                 }
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:             }
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:         }
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67: 
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:       - versioning {
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:           - enabled    = false -> null
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:           - mfa_delete = false -> null
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:         }
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:     }
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67: 
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:   # aws_s3_bucket_server_side_encryption_configuration.this will be destroyed
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:   - resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:       - bucket = "terraform-test-bucket-1740455999-fvcshx" -> null
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:       - id     = "terraform-test-bucket-1740455999-fvcshx" -> null
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67: 
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:       - rule {
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:           - bucket_key_enabled = false -> null
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67: 
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:           - apply_server_side_encryption_by_default {
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:               - kms_master_key_id = "arn:aws:kms:us-east-1:071090472443:key/3188d30d-c348-4503-9071-860356884f0c" -> null
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:               - sse_algorithm     = "aws:kms" -> null
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:             }
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:         }
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:     }
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67: 
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:   # aws_security_group.secure_sg will be destroyed
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:   - resource "aws_security_group" "secure_sg" {
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:       - arn                    = "arn:aws:ec2:us-east-1:071090472443:security-group/sg-0ffbb62075e0fb992" -> null
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:       - description            = "Security Group that blocks global traffic" -> null
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:       - egress                 = [
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:           - {
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:               - cidr_blocks      = [
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:                   - "0.0.0.0/0",
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:                 ]
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:               - description      = ""
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:               - from_port        = 0
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:               - ipv6_cidr_blocks = []
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:               - prefix_list_ids  = []
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:               - protocol         = "-1"
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:               - security_groups  = []
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:               - self             = false
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:               - to_port          = 0
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:             },
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:         ] -> null
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:       - id                     = "sg-0ffbb62075e0fb992" -> null
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:       - ingress                = [
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:           - {
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:               - cidr_blocks      = [
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:                   - "10.0.0.0/24",
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:                 ]
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:               - description      = ""
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:               - from_port        = 22
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:               - ipv6_cidr_blocks = []
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:               - prefix_list_ids  = []
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:               - protocol         = "tcp"
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:               - security_groups  = []
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:               - self             = false
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:               - to_port          = 22
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:             },
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:         ] -> null
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:       - name                   = "secure-sg" -> null
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:       - owner_id               = "071090472443" -> null
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:       - revoke_rules_on_delete = false -> null
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:       - tags                   = {} -> null
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:       - tags_all               = {} -> null
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:       - vpc_id                 = "vpc-5a9f9f20" -> null
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:     }
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67: 
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67: Plan: 0 to add, 0 to change, 4 to destroy.
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67: 
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67: Changes to Outputs:
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:   - bucket_name        = "terraform-test-bucket-1740455999-fvcshx" -> null
TestTerraformS3 2025-02-25T01:00:22-03:00 logger.go:67:   - encryption_key_arn = "arn:aws:kms:us-east-1:071090472443:key/3188d30d-c348-4503-9071-860356884f0c" -> null
TestTerraformS3 2025-02-25T01:00:23-03:00 logger.go:67: aws_s3_bucket_server_side_encryption_configuration.this: Destroying... [id=terraform-test-bucket-1740455999-fvcshx]
TestTerraformS3 2025-02-25T01:00:23-03:00 logger.go:67: aws_security_group.secure_sg: Destroying... [id=sg-0ffbb62075e0fb992]
TestTerraformS3 2025-02-25T01:00:23-03:00 logger.go:67: aws_s3_bucket_server_side_encryption_configuration.this: Destruction complete after 1s
TestTerraformS3 2025-02-25T01:00:23-03:00 logger.go:67: aws_kms_key.this: Destroying... [id=3188d30d-c348-4503-9071-860356884f0c]
TestTerraformS3 2025-02-25T01:00:23-03:00 logger.go:67: aws_s3_bucket.this: Destroying... [id=terraform-test-bucket-1740455999-fvcshx]
TestTerraformS3 2025-02-25T01:00:24-03:00 logger.go:67: aws_s3_bucket.this: Destruction complete after 0s
TestTerraformS3 2025-02-25T01:00:24-03:00 logger.go:67: aws_kms_key.this: Destruction complete after 0s
TestTerraformS3 2025-02-25T01:00:24-03:00 logger.go:67: aws_security_group.secure_sg: Destruction complete after 2s
TestTerraformS3 2025-02-25T01:00:25-03:00 logger.go:67: 
TestTerraformS3 2025-02-25T01:00:25-03:00 logger.go:67: Destroy complete! Resources: 4 destroyed.
TestTerraformS3 2025-02-25T01:00:25-03:00 logger.go:67: 
--- PASS: TestTerraformS3 (25.34s)
PASS
ok      command-line-arguments  25.884s
```
---

### Running the Security Group Test - PASS:

```sh
go test -v terraform_sg_test.go
```

#### ✅ Output (Security Group Test):
```hcl
=== RUN   TestTerraformSG
=== PAUSE TestTerraformSG
=== CONT  TestTerraformSG
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67: 
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67: Terraform used the selected providers to generate the following execution
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67: plan. Resource actions are indicated with the following symbols:
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:   + create
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67: 
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67: Terraform will perform the following actions:
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67: 
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:   # aws_kms_key.this will be created
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:   + resource "aws_kms_key" "this" {
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:       + arn                                = (known after apply)
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:       + bypass_policy_lockout_safety_check = false
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:       + customer_master_key_spec           = "SYMMETRIC_DEFAULT"
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:       + description                        = "KMS key for S3 encryption"
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:       + enable_key_rotation                = false
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:       + id                                 = (known after apply)
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:       + is_enabled                         = true
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:       + key_id                             = (known after apply)
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:       + key_usage                          = "ENCRYPT_DECRYPT"
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:       + multi_region                       = (known after apply)
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:       + policy                             = (known after apply)
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:       + tags_all                           = (known after apply)
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:     }
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67: 
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:   # aws_s3_bucket.this will be created
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:   + resource "aws_s3_bucket" "this" {
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:       + acceleration_status         = (known after apply)
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:       + acl                         = (known after apply)
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:       + arn                         = (known after apply)
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:       + bucket                      = "terraform-s3-bucke-poc-tftest"
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:       + bucket_domain_name          = (known after apply)
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:       + bucket_prefix               = (known after apply)
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:       + bucket_regional_domain_name = (known after apply)
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:       + force_destroy               = false
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:       + hosted_zone_id              = (known after apply)
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:       + id                          = (known after apply)
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:       + object_lock_enabled         = (known after apply)
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:       + policy                      = (known after apply)
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:       + region                      = (known after apply)
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:       + request_payer               = (known after apply)
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:       + tags_all                    = (known after apply)
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:       + website_domain              = (known after apply)
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:       + website_endpoint            = (known after apply)
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:     }
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67: 
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:   # aws_s3_bucket_server_side_encryption_configuration.this will be created
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:   + resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:       + bucket = (known after apply)
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:       + id     = (known after apply)
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67: 
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:       + rule {
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:           + apply_server_side_encryption_by_default {
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:               + kms_master_key_id = (known after apply)
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:               + sse_algorithm     = "aws:kms"
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:             }
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:         }
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:     }
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67: 
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:   # aws_security_group.secure_sg will be created
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:   + resource "aws_security_group" "secure_sg" {
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:       + arn                    = (known after apply)
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:       + description            = "Security Group that blocks global traffic"
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:       + egress                 = [
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:           + {
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:               + cidr_blocks      = [
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:                   + "0.0.0.0/0",
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:                 ]
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:               + description      = ""
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:               + from_port        = 0
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:               + ipv6_cidr_blocks = []
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:               + prefix_list_ids  = []
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:               + protocol         = "-1"
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:               + security_groups  = []
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:               + self             = false
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:               + to_port          = 0
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:             },
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:         ]
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:       + id                     = (known after apply)
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:       + ingress                = [
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:           + {
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:               + cidr_blocks      = [
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:                   + "10.0.0.0/24",
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:                 ]
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:               + description      = ""
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:               + from_port        = 22
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:               + ipv6_cidr_blocks = []
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:               + prefix_list_ids  = []
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:               + protocol         = "tcp"
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:               + security_groups  = []
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:               + self             = false
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:               + to_port          = 22
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:             },
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:         ]
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:       + name                   = "secure-sg"
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:       + name_prefix            = (known after apply)
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:       + owner_id               = (known after apply)
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:       + revoke_rules_on_delete = false
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:       + tags_all               = (known after apply)
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:       + vpc_id                 = (known after apply)
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:     }
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67: 
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67: Plan: 4 to add, 0 to change, 0 to destroy.
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67: 
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67: Changes to Outputs:
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:   + bucket_name        = (known after apply)
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:   + encryption_key_arn = (known after apply)
TestTerraformSG 2025-02-25T01:35:44-03:00 logger.go:67:   + sg_id              = (known after apply)
TestTerraformSG 2025-02-25T01:35:45-03:00 logger.go:67: aws_kms_key.this: Creating...
TestTerraformSG 2025-02-25T01:35:45-03:00 logger.go:67: aws_security_group.secure_sg: Creating...
TestTerraformSG 2025-02-25T01:35:45-03:00 logger.go:67: aws_s3_bucket.this: Creating...
TestTerraformSG 2025-02-25T01:35:46-03:00 logger.go:67: aws_kms_key.this: Creation complete after 2s [id=1e0143e5-f89d-4350-9ca0-8581a94c1e27]
TestTerraformSG 2025-02-25T01:35:48-03:00 logger.go:67: aws_s3_bucket.this: Creation complete after 4s [id=terraform-s3-bucke-poc-tftest]
TestTerraformSG 2025-02-25T01:35:48-03:00 logger.go:67: aws_s3_bucket_server_side_encryption_configuration.this: Creating...
TestTerraformSG 2025-02-25T01:35:48-03:00 logger.go:67: aws_s3_bucket_server_side_encryption_configuration.this: Creation complete after 0s [id=terraform-s3-bucke-poc-tftest]
TestTerraformSG 2025-02-25T01:35:49-03:00 logger.go:67: aws_security_group.secure_sg: Creation complete after 5s [id=sg-0fe4642e4b158320a]
TestTerraformSG 2025-02-25T01:35:50-03:00 logger.go:67: 
TestTerraformSG 2025-02-25T01:35:50-03:00 logger.go:67: Apply complete! Resources: 4 added, 0 changed, 0 destroyed.
TestTerraformSG 2025-02-25T01:35:50-03:00 logger.go:67: 
TestTerraformSG 2025-02-25T01:35:50-03:00 logger.go:67: Outputs:
TestTerraformSG 2025-02-25T01:35:50-03:00 logger.go:67: 
TestTerraformSG 2025-02-25T01:35:50-03:00 logger.go:67: bucket_name = "terraform-s3-bucke-poc-tftest"
TestTerraformSG 2025-02-25T01:35:50-03:00 logger.go:67: encryption_key_arn = "arn:aws:kms:us-east-1:071090472443:key/1e0143e5-f89d-4350-9ca0-8581a94c1e27"
TestTerraformSG 2025-02-25T01:35:50-03:00 logger.go:67: sg_id = "sg-0fe4642e4b158320a"
TestTerraformSG 2025-02-25T01:35:50-03:00 retry.go:91: terraform_1.7.5 [output -no-color -json sg_id]
TestTerraformSG 2025-02-25T01:35:50-03:00 logger.go:67: Running command terraform_1.7.5 with args [output -no-color -json sg_id]
TestTerraformSG 2025-02-25T01:35:51-03:00 logger.go:67: "sg-0fe4642e4b158320a"
TestTerraformSG 2025-02-25T01:35:52-03:00 retry.go:91: terraform_1.7.5 [destroy -auto-approve -input=false -lock=false]
TestTerraformSG 2025-02-25T01:35:52-03:00 logger.go:67: Running command terraform_1.7.5 with args [destroy -auto-approve -input=false -lock=false]
TestTerraformSG 2025-02-25T01:35:55-03:00 logger.go:67: aws_kms_key.this: Refreshing state... [id=1e0143e5-f89d-4350-9ca0-8581a94c1e27]
TestTerraformSG 2025-02-25T01:35:55-03:00 logger.go:67: aws_security_group.secure_sg: Refreshing state... [id=sg-0fe4642e4b158320a]
TestTerraformSG 2025-02-25T01:35:55-03:00 logger.go:67: aws_s3_bucket.this: Refreshing state... [id=terraform-s3-bucke-poc-tftest]
TestTerraformSG 2025-02-25T01:35:58-03:00 logger.go:67: aws_s3_bucket_server_side_encryption_configuration.this: Refreshing state... [id=terraform-s3-bucke-poc-tftest]
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67: 
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67: Terraform used the selected providers to generate the following execution
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67: plan. Resource actions are indicated with the following symbols:
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:   - destroy
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67: 
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67: Terraform will perform the following actions:
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67: 
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:   # aws_kms_key.this will be destroyed
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:   - resource "aws_kms_key" "this" {
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:       - arn                                = "arn:aws:kms:us-east-1:071090472443:key/1e0143e5-f89d-4350-9ca0-8581a94c1e27" -> null
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:       - bypass_policy_lockout_safety_check = false -> null
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:       - customer_master_key_spec           = "SYMMETRIC_DEFAULT" -> null
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:       - description                        = "KMS key for S3 encryption" -> null
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:       - enable_key_rotation                = false -> null
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:       - id                                 = "1e0143e5-f89d-4350-9ca0-8581a94c1e27" -> null
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:       - is_enabled                         = true -> null
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:       - key_id                             = "1e0143e5-f89d-4350-9ca0-8581a94c1e27" -> null
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:       - key_usage                          = "ENCRYPT_DECRYPT" -> null
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:       - multi_region                       = false -> null
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:       - policy                             = jsonencode(
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:             {
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:               - Id        = "key-default-1"
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:               - Statement = [
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:                   - {
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:                       - Action    = "kms:*"
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:                       - Effect    = "Allow"
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:                       - Principal = {
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:                           - AWS = "arn:aws:iam::071090472443:root"
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:                         }
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:                       - Resource  = "*"
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:                       - Sid       = "Enable IAM User Permissions"
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:                     },
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:                 ]
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:               - Version   = "2012-10-17"
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:             }
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:         ) -> null
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:       - tags                               = {} -> null
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:       - tags_all                           = {} -> null
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:     }
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67: 
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:   # aws_s3_bucket.this will be destroyed
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:   - resource "aws_s3_bucket" "this" {
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:       - arn                         = "arn:aws:s3:::terraform-s3-bucke-poc-tftest" -> null
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:       - bucket                      = "terraform-s3-bucke-poc-tftest" -> null
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:       - bucket_domain_name          = "terraform-s3-bucke-poc-tftest.s3.amazonaws.com" -> null
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:       - bucket_regional_domain_name = "terraform-s3-bucke-poc-tftest.s3.amazonaws.com" -> null
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:       - force_destroy               = false -> null
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:       - hosted_zone_id              = "Z3AQBSTGFYJSTF" -> null
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:       - id                          = "terraform-s3-bucke-poc-tftest" -> null
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:       - object_lock_enabled         = false -> null
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:       - region                      = "us-east-1" -> null
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:       - request_payer               = "BucketOwner" -> null
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:       - tags                        = {} -> null
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:       - tags_all                    = {} -> null
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67: 
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:       - grant {
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:           - id          = "d131019f8ca19c00de8d14117361488eebf2444f7887cfe4b741d6c934748fb0" -> null
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:           - permissions = [
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:               - "FULL_CONTROL",
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:             ] -> null
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:           - type        = "CanonicalUser" -> null
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:         }
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67: 
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:       - server_side_encryption_configuration {
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:           - rule {
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:               - bucket_key_enabled = false -> null
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67: 
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:               - apply_server_side_encryption_by_default {
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:                   - kms_master_key_id = "arn:aws:kms:us-east-1:071090472443:key/1e0143e5-f89d-4350-9ca0-8581a94c1e27" -> null
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:                   - sse_algorithm     = "aws:kms" -> null
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:                 }
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:             }
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:         }
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67: 
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:       - versioning {
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:           - enabled    = false -> null
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:           - mfa_delete = false -> null
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:         }
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:     }
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67: 
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:   # aws_s3_bucket_server_side_encryption_configuration.this will be destroyed
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:   - resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:       - bucket = "terraform-s3-bucke-poc-tftest" -> null
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:       - id     = "terraform-s3-bucke-poc-tftest" -> null
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67: 
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:       - rule {
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:           - bucket_key_enabled = false -> null
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67: 
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:           - apply_server_side_encryption_by_default {
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:               - kms_master_key_id = "arn:aws:kms:us-east-1:071090472443:key/1e0143e5-f89d-4350-9ca0-8581a94c1e27" -> null
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:               - sse_algorithm     = "aws:kms" -> null
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:             }
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:         }
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:     }
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67: 
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:   # aws_security_group.secure_sg will be destroyed
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:   - resource "aws_security_group" "secure_sg" {
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:       - arn                    = "arn:aws:ec2:us-east-1:071090472443:security-group/sg-0fe4642e4b158320a" -> null
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:       - description            = "Security Group that blocks global traffic" -> null
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:       - egress                 = [
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:           - {
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:               - cidr_blocks      = [
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:                   - "0.0.0.0/0",
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:                 ]
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:               - description      = ""
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:               - from_port        = 0
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:               - ipv6_cidr_blocks = []
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:               - prefix_list_ids  = []
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:               - protocol         = "-1"
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:               - security_groups  = []
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:               - self             = false
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:               - to_port          = 0
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:             },
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:         ] -> null
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:       - id                     = "sg-0fe4642e4b158320a" -> null
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:       - ingress                = [
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:           - {
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:               - cidr_blocks      = [
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:                   - "10.0.0.0/24",
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:                 ]
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:               - description      = ""
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:               - from_port        = 22
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:               - ipv6_cidr_blocks = []
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:               - prefix_list_ids  = []
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:               - protocol         = "tcp"
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:               - security_groups  = []
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:               - self             = false
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:               - to_port          = 22
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:             },
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:         ] -> null
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:       - name                   = "secure-sg" -> null
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:       - owner_id               = "071090472443" -> null
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:       - revoke_rules_on_delete = false -> null
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:       - tags                   = {} -> null
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:       - tags_all               = {} -> null
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:       - vpc_id                 = "vpc-5a9f9f20" -> null
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:     }
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67: 
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67: Plan: 0 to add, 0 to change, 4 to destroy.
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67: 
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67: Changes to Outputs:
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:   - bucket_name        = "terraform-s3-bucke-poc-tftest" -> null
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:   - encryption_key_arn = "arn:aws:kms:us-east-1:071090472443:key/1e0143e5-f89d-4350-9ca0-8581a94c1e27" -> null
TestTerraformSG 2025-02-25T01:35:59-03:00 logger.go:67:   - sg_id              = "sg-0fe4642e4b158320a" -> null
TestTerraformSG 2025-02-25T01:36:00-03:00 logger.go:67: aws_s3_bucket_server_side_encryption_configuration.this: Destroying... [id=terraform-s3-bucke-poc-tftest]
TestTerraformSG 2025-02-25T01:36:00-03:00 logger.go:67: aws_security_group.secure_sg: Destroying... [id=sg-0fe4642e4b158320a]
TestTerraformSG 2025-02-25T01:36:01-03:00 logger.go:67: aws_s3_bucket_server_side_encryption_configuration.this: Destruction complete after 0s
TestTerraformSG 2025-02-25T01:36:01-03:00 logger.go:67: aws_kms_key.this: Destroying... [id=1e0143e5-f89d-4350-9ca0-8581a94c1e27]
TestTerraformSG 2025-02-25T01:36:01-03:00 logger.go:67: aws_s3_bucket.this: Destroying... [id=terraform-s3-bucke-poc-tftest]
TestTerraformSG 2025-02-25T01:36:01-03:00 logger.go:67: aws_s3_bucket.this: Destruction complete after 1s
TestTerraformSG 2025-02-25T01:36:01-03:00 logger.go:67: aws_kms_key.this: Destruction complete after 1s
TestTerraformSG 2025-02-25T01:36:02-03:00 logger.go:67: aws_security_group.secure_sg: Destruction complete after 1s
TestTerraformSG 2025-02-25T01:36:02-03:00 logger.go:67: 
TestTerraformSG 2025-02-25T01:36:02-03:00 logger.go:67: Destroy complete! Resources: 4 destroyed.
TestTerraformSG 2025-02-25T01:36:02-03:00 logger.go:67: 
--- PASS: TestTerraformSG (24.40s)
PASS
ok      command-line-arguments  24.914s
```


### Running the Security Group Test - FAIL:

```sh
go test -v terraform_sg_test.go
```

#### ✅ Output (Security Group Test):
```hcl
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67: 
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67: Terraform used the selected providers to generate the following execution
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67: plan. Resource actions are indicated with the following symbols:
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:   + create
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67: 
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67: Terraform will perform the following actions:
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67: 
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:   # aws_kms_key.this will be created
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:   + resource "aws_kms_key" "this" {
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:       + arn                                = (known after apply)
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:       + bypass_policy_lockout_safety_check = false
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:       + customer_master_key_spec           = "SYMMETRIC_DEFAULT"
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:       + description                        = "KMS key for S3 encryption"
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:       + enable_key_rotation                = false
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:       + id                                 = (known after apply)
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:       + is_enabled                         = true
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:       + key_id                             = (known after apply)
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:       + key_usage                          = "ENCRYPT_DECRYPT"
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:       + multi_region                       = (known after apply)
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:       + policy                             = (known after apply)
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:       + tags_all                           = (known after apply)
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:     }
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67: 
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:   # aws_s3_bucket.this will be created
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:   + resource "aws_s3_bucket" "this" {
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:       + acceleration_status         = (known after apply)
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:       + acl                         = (known after apply)
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:       + arn                         = (known after apply)
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:       + bucket                      = "terraform-s3-bucke-poc-tftest"
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:       + bucket_domain_name          = (known after apply)
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:       + bucket_prefix               = (known after apply)
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:       + bucket_regional_domain_name = (known after apply)
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:       + force_destroy               = false
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:       + hosted_zone_id              = (known after apply)
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:       + id                          = (known after apply)
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:       + object_lock_enabled         = (known after apply)
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:       + policy                      = (known after apply)
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:       + region                      = (known after apply)
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:       + request_payer               = (known after apply)
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:       + tags_all                    = (known after apply)
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:       + website_domain              = (known after apply)
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:       + website_endpoint            = (known after apply)
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:     }
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67: 
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:   # aws_s3_bucket_server_side_encryption_configuration.this will be created
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:   + resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:       + bucket = (known after apply)
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:       + id     = (known after apply)
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67: 
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:       + rule {
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:           + apply_server_side_encryption_by_default {
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:               + kms_master_key_id = (known after apply)
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:               + sse_algorithm     = "aws:kms"
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:             }
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:         }
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:     }
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67: 
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:   # aws_security_group.secure_sg will be created
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:   + resource "aws_security_group" "secure_sg" {
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:       + arn                    = (known after apply)
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:       + description            = "Security Group that blocks global traffic"
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:       + egress                 = [
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:           + {
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:               + cidr_blocks      = [
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:                   + "0.0.0.0/0",
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:                 ]
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:               + description      = ""
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:               + from_port        = 0
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:               + ipv6_cidr_blocks = []
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:               + prefix_list_ids  = []
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:               + protocol         = "-1"
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:               + security_groups  = []
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:               + self             = false
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:               + to_port          = 0
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:             },
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:         ]
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:       + id                     = (known after apply)
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:       + ingress                = [
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:           + {
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:               + cidr_blocks      = [
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:                   + "0.0.0.0/0",
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:                 ]
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:               + description      = ""
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:               + from_port        = 80
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:               + ipv6_cidr_blocks = []
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:               + prefix_list_ids  = []
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:               + protocol         = "tcp"
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:               + security_groups  = []
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:               + self             = false
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:               + to_port          = 80
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:             },
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:           + {
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:               + cidr_blocks      = [
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:                   + "10.0.0.0/24",
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:                 ]
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:               + description      = ""
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:               + from_port        = 22
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:               + ipv6_cidr_blocks = []
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:               + prefix_list_ids  = []
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:               + protocol         = "tcp"
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:               + security_groups  = []
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:               + self             = false
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:               + to_port          = 22
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:             },
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:         ]
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:       + name                   = "secure-sg"
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:       + name_prefix            = (known after apply)
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:       + owner_id               = (known after apply)
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:       + revoke_rules_on_delete = false
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:       + tags_all               = (known after apply)
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:       + vpc_id                 = (known after apply)
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:     }
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67: 
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67: Plan: 4 to add, 0 to change, 0 to destroy.
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67: 
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67: Changes to Outputs:
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:   + bucket_name        = (known after apply)
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:   + encryption_key_arn = (known after apply)
TestTerraformSG 2025-02-25T01:40:07-03:00 logger.go:67:   + sg_id              = (known after apply)
TestTerraformSG 2025-02-25T01:40:08-03:00 logger.go:67: aws_kms_key.this: Creating...
TestTerraformSG 2025-02-25T01:40:08-03:00 logger.go:67: aws_security_group.secure_sg: Creating...
TestTerraformSG 2025-02-25T01:40:08-03:00 logger.go:67: aws_s3_bucket.this: Creating...
TestTerraformSG 2025-02-25T01:40:09-03:00 logger.go:67: aws_kms_key.this: Creation complete after 2s [id=817910f8-150f-4759-ac9f-820d6f6890fe]
TestTerraformSG 2025-02-25T01:40:11-03:00 logger.go:67: aws_s3_bucket.this: Creation complete after 4s [id=terraform-s3-bucke-poc-tftest]
TestTerraformSG 2025-02-25T01:40:11-03:00 logger.go:67: aws_s3_bucket_server_side_encryption_configuration.this: Creating...
TestTerraformSG 2025-02-25T01:40:12-03:00 logger.go:67: aws_s3_bucket_server_side_encryption_configuration.this: Creation complete after 0s [id=terraform-s3-bucke-poc-tftest]
TestTerraformSG 2025-02-25T01:40:12-03:00 logger.go:67: aws_security_group.secure_sg: Creation complete after 5s [id=sg-043f2c0b59db534c4]
TestTerraformSG 2025-02-25T01:40:13-03:00 logger.go:67: 
TestTerraformSG 2025-02-25T01:40:13-03:00 logger.go:67: Apply complete! Resources: 4 added, 0 changed, 0 destroyed.
TestTerraformSG 2025-02-25T01:40:13-03:00 logger.go:67: 
TestTerraformSG 2025-02-25T01:40:13-03:00 logger.go:67: Outputs:
TestTerraformSG 2025-02-25T01:40:13-03:00 logger.go:67: 
TestTerraformSG 2025-02-25T01:40:13-03:00 logger.go:67: bucket_name = "terraform-s3-bucke-poc-tftest"
TestTerraformSG 2025-02-25T01:40:13-03:00 logger.go:67: encryption_key_arn = "arn:aws:kms:us-east-1:071090472443:key/817910f8-150f-4759-ac9f-820d6f6890fe"
TestTerraformSG 2025-02-25T01:40:13-03:00 logger.go:67: sg_id = "sg-043f2c0b59db534c4"
TestTerraformSG 2025-02-25T01:40:13-03:00 retry.go:91: terraform_1.7.5 [output -no-color -json sg_id]
TestTerraformSG 2025-02-25T01:40:13-03:00 logger.go:67: Running command terraform_1.7.5 with args [output -no-color -json sg_id]
TestTerraformSG 2025-02-25T01:40:14-03:00 logger.go:67: "sg-043f2c0b59db534c4"
TestTerraformSG 2025-02-25T01:40:15-03:00 retry.go:91: terraform_1.7.5 [destroy -auto-approve -input=false -lock=false]
TestTerraformSG 2025-02-25T01:40:15-03:00 logger.go:67: Running command terraform_1.7.5 with args [destroy -auto-approve -input=false -lock=false]
TestTerraformSG 2025-02-25T01:40:18-03:00 logger.go:67: aws_kms_key.this: Refreshing state... [id=817910f8-150f-4759-ac9f-820d6f6890fe]
TestTerraformSG 2025-02-25T01:40:18-03:00 logger.go:67: aws_s3_bucket.this: Refreshing state... [id=terraform-s3-bucke-poc-tftest]
TestTerraformSG 2025-02-25T01:40:18-03:00 logger.go:67: aws_security_group.secure_sg: Refreshing state... [id=sg-043f2c0b59db534c4]
TestTerraformSG 2025-02-25T01:40:21-03:00 logger.go:67: aws_s3_bucket_server_side_encryption_configuration.this: Refreshing state... [id=terraform-s3-bucke-poc-tftest]
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67: 
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67: Terraform used the selected providers to generate the following execution
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67: plan. Resource actions are indicated with the following symbols:
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:   - destroy
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67: 
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67: Terraform will perform the following actions:
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67: 
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:   # aws_kms_key.this will be destroyed
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:   - resource "aws_kms_key" "this" {
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:       - arn                                = "arn:aws:kms:us-east-1:071090472443:key/817910f8-150f-4759-ac9f-820d6f6890fe" -> null
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:       - bypass_policy_lockout_safety_check = false -> null
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:       - customer_master_key_spec           = "SYMMETRIC_DEFAULT" -> null
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:       - description                        = "KMS key for S3 encryption" -> null
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:       - enable_key_rotation                = false -> null
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:       - id                                 = "817910f8-150f-4759-ac9f-820d6f6890fe" -> null
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:       - is_enabled                         = true -> null
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:       - key_id                             = "817910f8-150f-4759-ac9f-820d6f6890fe" -> null
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:       - key_usage                          = "ENCRYPT_DECRYPT" -> null
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:       - multi_region                       = false -> null
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:       - policy                             = jsonencode(
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:             {
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:               - Id        = "key-default-1"
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:               - Statement = [
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:                   - {
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:                       - Action    = "kms:*"
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:                       - Effect    = "Allow"
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:                       - Principal = {
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:                           - AWS = "arn:aws:iam::071090472443:root"
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:                         }
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:                       - Resource  = "*"
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:                       - Sid       = "Enable IAM User Permissions"
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:                     },
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:                 ]
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:               - Version   = "2012-10-17"
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:             }
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:         ) -> null
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:       - tags                               = {} -> null
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:       - tags_all                           = {} -> null
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:     }
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67: 
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:   # aws_s3_bucket.this will be destroyed
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:   - resource "aws_s3_bucket" "this" {
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:       - arn                         = "arn:aws:s3:::terraform-s3-bucke-poc-tftest" -> null
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:       - bucket                      = "terraform-s3-bucke-poc-tftest" -> null
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:       - bucket_domain_name          = "terraform-s3-bucke-poc-tftest.s3.amazonaws.com" -> null
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:       - bucket_regional_domain_name = "terraform-s3-bucke-poc-tftest.s3.amazonaws.com" -> null
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:       - force_destroy               = false -> null
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:       - hosted_zone_id              = "Z3AQBSTGFYJSTF" -> null
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:       - id                          = "terraform-s3-bucke-poc-tftest" -> null
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:       - object_lock_enabled         = false -> null
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:       - region                      = "us-east-1" -> null
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:       - request_payer               = "BucketOwner" -> null
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:       - tags                        = {} -> null
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:       - tags_all                    = {} -> null
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67: 
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:       - grant {
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:           - id          = "d131019f8ca19c00de8d14117361488eebf2444f7887cfe4b741d6c934748fb0" -> null
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:           - permissions = [
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:               - "FULL_CONTROL",
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:             ] -> null
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:           - type        = "CanonicalUser" -> null
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:         }
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67: 
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:       - server_side_encryption_configuration {
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:           - rule {
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:               - bucket_key_enabled = false -> null
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67: 
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:               - apply_server_side_encryption_by_default {
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:                   - kms_master_key_id = "arn:aws:kms:us-east-1:071090472443:key/817910f8-150f-4759-ac9f-820d6f6890fe" -> null
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:                   - sse_algorithm     = "aws:kms" -> null
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:                 }
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:             }
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:         }
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67: 
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:       - versioning {
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:           - enabled    = false -> null
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:           - mfa_delete = false -> null
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:         }
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:     }
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67: 
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:   # aws_s3_bucket_server_side_encryption_configuration.this will be destroyed
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:   - resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:       - bucket = "terraform-s3-bucke-poc-tftest" -> null
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:       - id     = "terraform-s3-bucke-poc-tftest" -> null
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67: 
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:       - rule {
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:           - bucket_key_enabled = false -> null
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67: 
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:           - apply_server_side_encryption_by_default {
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:               - kms_master_key_id = "arn:aws:kms:us-east-1:071090472443:key/817910f8-150f-4759-ac9f-820d6f6890fe" -> null
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:               - sse_algorithm     = "aws:kms" -> null
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:             }
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:         }
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:     }
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67: 
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:   # aws_security_group.secure_sg will be destroyed
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:   - resource "aws_security_group" "secure_sg" {
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:       - arn                    = "arn:aws:ec2:us-east-1:071090472443:security-group/sg-043f2c0b59db534c4" -> null
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:       - description            = "Security Group that blocks global traffic" -> null
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:       - egress                 = [
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:           - {
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:               - cidr_blocks      = [
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:                   - "0.0.0.0/0",
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:                 ]
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:               - description      = ""
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:               - from_port        = 0
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:               - ipv6_cidr_blocks = []
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:               - prefix_list_ids  = []
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:               - protocol         = "-1"
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:               - security_groups  = []
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:               - self             = false
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:               - to_port          = 0
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:             },
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:         ] -> null
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:       - id                     = "sg-043f2c0b59db534c4" -> null
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:       - ingress                = [
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:           - {
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:               - cidr_blocks      = [
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:                   - "0.0.0.0/0",
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:                 ]
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:               - description      = ""
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:               - from_port        = 80
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:               - ipv6_cidr_blocks = []
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:               - prefix_list_ids  = []
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:               - protocol         = "tcp"
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:               - security_groups  = []
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:               - self             = false
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:               - to_port          = 80
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:             },
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:           - {
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:               - cidr_blocks      = [
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:                   - "10.0.0.0/24",
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:                 ]
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:               - description      = ""
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:               - from_port        = 22
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:               - ipv6_cidr_blocks = []
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:               - prefix_list_ids  = []
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:               - protocol         = "tcp"
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:               - security_groups  = []
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:               - self             = false
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:               - to_port          = 22
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:             },
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:         ] -> null
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:       - name                   = "secure-sg" -> null
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:       - owner_id               = "071090472443" -> null
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:       - revoke_rules_on_delete = false -> null
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:       - tags                   = {} -> null
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:       - tags_all               = {} -> null
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:       - vpc_id                 = "vpc-5a9f9f20" -> null
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:     }
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67: 
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67: Plan: 0 to add, 0 to change, 4 to destroy.
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67: 
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67: Changes to Outputs:
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:   - bucket_name        = "terraform-s3-bucke-poc-tftest" -> null
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:   - encryption_key_arn = "arn:aws:kms:us-east-1:071090472443:key/817910f8-150f-4759-ac9f-820d6f6890fe" -> null
TestTerraformSG 2025-02-25T01:40:22-03:00 logger.go:67:   - sg_id              = "sg-043f2c0b59db534c4" -> null
TestTerraformSG 2025-02-25T01:40:23-03:00 logger.go:67: aws_s3_bucket_server_side_encryption_configuration.this: Destroying... [id=terraform-s3-bucke-poc-tftest]
TestTerraformSG 2025-02-25T01:40:23-03:00 logger.go:67: aws_security_group.secure_sg: Destroying... [id=sg-043f2c0b59db534c4]
TestTerraformSG 2025-02-25T01:40:24-03:00 logger.go:67: aws_s3_bucket_server_side_encryption_configuration.this: Destruction complete after 0s
TestTerraformSG 2025-02-25T01:40:24-03:00 logger.go:67: aws_kms_key.this: Destroying... [id=817910f8-150f-4759-ac9f-820d6f6890fe]
TestTerraformSG 2025-02-25T01:40:24-03:00 logger.go:67: aws_s3_bucket.this: Destroying... [id=terraform-s3-bucke-poc-tftest]
TestTerraformSG 2025-02-25T01:40:24-03:00 logger.go:67: aws_s3_bucket.this: Destruction complete after 1s
TestTerraformSG 2025-02-25T01:40:24-03:00 logger.go:67: aws_kms_key.this: Destruction complete after 1s
TestTerraformSG 2025-02-25T01:40:25-03:00 logger.go:67: aws_security_group.secure_sg: Destruction complete after 1s
TestTerraformSG 2025-02-25T01:40:25-03:00 logger.go:67: 
TestTerraformSG 2025-02-25T01:40:25-03:00 logger.go:67: Destroy complete! Resources: 4 destroyed.
TestTerraformSG 2025-02-25T01:40:25-03:00 logger.go:67: 
--- FAIL: TestTerraformSG (24.17s)
    terraform_sg_test.go:48: 
                Error Trace:    /TERRATEST/tests/terraform_sg_test.go:48
                Error:          Should not be: "0.0.0.0/0"
                Test:           TestTerraformSG
                Messages:       Inbound traffic is globally open!
FAIL
FAIL    command-line-arguments  24.653s
FAIL
```