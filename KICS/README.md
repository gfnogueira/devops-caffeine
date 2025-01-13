# KICS (Keeping Infrastructure as Code Secure) POC

☕ **Fueling DevOps ideas with caffeine and security automation magic.**

## What is KICS?

KICS (**Keeping Infrastructure as Code Secure**) is an open-source tool designed to scan Infrastructure as Code (IaC) files for security vulnerabilities and misconfigurations. It supports popular IaC formats like Terraform, CloudFormation, Kubernetes, and Ansible, providing actionable insights to improve your infrastructure's security posture.

## What does it do?

- Detects vulnerabilities and misconfigurations in IaC files.
- Supports multiple IaC frameworks like:
  - **Terraform**
  - **CloudFormation**
  - **Kubernetes**
  - **Ansible**
- Provides detailed reports for easy remediation.

## How to Use

### Prerequisites

- Install [Go](https://golang.org/doc/install) (if you want to build KICS from source).
- Download KICS from the official [GitHub repository](https://github.com/Checkmarx/kics) or install it via Docker.

### Installation

#### Option 1: Using Docker
```bash
docker pull checkmarx/kics
```

#### Option 2: Using Precompiled Binary
- Download the latest release from the [KICS GitHub Releases page](https://github.com/Checkmarx/kics/releases).


#### Option 3: Build from Source
```bash
git clone https://github.com/Checkmarx/kics.git
cd kics
make build
```
or
```bashcd kics
go mod vendor
LINUX/MAC: go build -o ./bin/kics cmd/console/main.go
WINDOWS: go build -o ./bin/kics.exe cmd/console/main.go (make sure to create the bin folder)
```


## Running KICS

### Basic Scan

To scan a specific directory:
```bash
kics scan --path <directory-path>
```

### Specify a Query File

To run a scan with specific queries:
```bash
kics scan --path <directory-path> --queries-path <path-to-queries>
```

### Generate a Report

To generate a JSON or SARIF report:
```bash
kics scan --path <directory-path> --output-path <output-directory>
```

### Using Docker

Run KICS with Docker:
```bash
docker run --rm -v $(pwd):/tmp checkmarx/kics scan --path /tmp
```



### Kick a scan!
```bash
./bin/kics scan -p '<path-of-your-project-to-scan>' --report-formats json -o ./results
```


### List Supported Scanners

```bash
kics list --scanners
```


----

## RUNNING
```
./bin/kics scan -p './devops-caffeine/KICS' --report-formats json -o ./results





   MLLLLLM             MLLLLLLLLL   LLLLLLL             KLLLLLLLLLLLLLLLL       LLLLLLLLLLLLLLLLLLLLLLL
   MMMMMMM           MMMMMMMMMML    MMMMMMMK       LMMMMMMMMMMMMMMMMMMMML   KLMMMMMMMMMMMMMMMMMMMMMMMMM
   MMMMMMM         MMMMMMMMML       MMMMMMMK     LMMMMMMMMMMMMMMMMMMMMMML  LMMMMMMMMMMMMMMMMMMMMMMMMMMM
   MMMMMMM      MMMMMMMMMML         MMMMMMMK   LMMMMMMMMMMMMMMMMMMMMMMMML LMMMMMMMMMMMMMMMMMMMMMMMMMMMM
   MMMMMMM    LMMMMMMMMML           MMMMMMMK  LMMMMMMMMMLLMLLLLLLLLLLLLLL LMMMMMMMLLLLLLLLLLLLLLLLLLLLM
   MMMMMMM  MMMMMMMMMLM             MMMMMMMK LMMMMMMMM                    LMMMMMML
   MMMMMMMLMMMMMMMML                MMMMMMMK MMMMMMML                     LMMMMMMMMLLLLLLLLLLLLLMLL
   MMMMMMMMMMMMMMMM                 MMMMMMMK MMMMMML                       LMMMMMMMMMMMMMMMMMMMMMMMMML
   MMMMMMMMMMMMMMMMMM               MMMMMMMK MMMMMMM                         LMMMMMMMMMMMMMMMMMMMMMMMML
   MMMMMMM KLMMMMMMMMML             MMMMMMMK LMMMMMMM                                          MMMMMMMML
   MMMMMMM    LMMMMMMMMMM           MMMMMMMK LMMMMMMMMLL                                        MMMMMMML
   MMMMMMM      LMMMMMMMMMLL        MMMMMMMK  LMMMMMMMMMMMMMMMMMMMMMMMMML LLLLLLLLLLLLLLLLLLLLMMMMMMMMMM
   MMMMMMM        MMMMMMMMMMML      MMMMMMMK   MMMMMMMMMMMMMMMMMMMMMMMMML LMMMMMMMMMMMMMMMMMMMMMMMMMMMM
   MMMMMMM          LLMMMMMMMMML    MMMMMMMK     LLMMMMMMMMMMMMMMMMMMMMML LMMMMMMMMMMMMMMMMMMMMMMMMMML
   MMMMMMM             MMMMMMMMMML  MMMMMMMK         KLMMMMMMMMMMMMMMMMML LMMMMMMMMMMMMMMMMMMMMMMMLK




Scanning with Keeping Infrastructure as Code Secure development


Preparing Scan Assets: Done
Executing queries: [---------------------------------------------------] 100.00%



Variable Without Type, Severity: INFO, Results: 3
Description: All variables should contain a valid type.
Platform: Terraform
CWE: 710
Learn more about this vulnerability: https://docs.kics.io/latest/queries/terraform-queries/fc5109bf-01fd-49fb-8bde-4492b543c34a

	[1]: ./devops-caffeine/KICS/modules/aws/vpc/vars.tf:26

		025:
		026: variable "cluster_name" {
		027:   default     = "cluster"


	[2]: ./devops-caffeine/KICS/modules/aws/vpc/vars.tf:21

		020:
		021: variable "destination_logs_arn" {
		022:   default     = null


	[3]: ./devops-caffeine/KICS/modules/aws/vpc/vars.tf:6

		005:
		006: variable "identifier" {
		007:   default     = null


Resource Not Using Tags, Severity: INFO, Results: 4
Description: AWS services resource tags are an essential part of managing components. As a best practice, the field 'tags' should have additional tags defined other than 'Name'
Platform: Terraform
CWE: 665
Learn more about this vulnerability: https://docs.kics.io/latest/queries/terraform-queries/aws/e38a8e0a-b88b-4902-b3fe-b0fcb17d5c10

	[1]: ./devops-caffeine/KICS/modules/aws/vpc/main.tf:28

		027:
		028:   tags = {
		029:     Name = local.nat_gateway_name


	[2]: ./devops-caffeine/KICS/modules/aws/vpc/main.tf:15

		014:
		015:   tags = {
		016:     Name = local.vpc_name


	[3]: ./devops-caffeine/KICS/modules/aws/vpc/main.tf:38

		037:
		038:   tags = {
		039:     Name = local.internet_gateway_name


	[4]: ./devops-caffeine/KICS/modules/aws/vpc/main.tf:20

		019:
		020: resource "aws_eip" "this" {
		021:   depends_on = [aws_vpc.this]


Shield Advanced Not In Use, Severity: LOW, Results: 1
Description: AWS Shield Advanced should be used for Amazon Route 53 hosted zone, AWS Global Accelerator accelerator, Elastic IP Address, Elastic Load Balancing, and Amazon CloudFront Distribution to protect these resources against robust DDoS attacks
Platform: Terraform
CWE: 665
Learn more about this vulnerability: https://docs.kics.io/latest/queries/terraform-queries/aws/084c6686-2a70-4710-91b1-000393e54c12

	[1]: ./devops-caffeine/KICS/modules/aws/vpc/main.tf:20

		019:
		020: resource "aws_eip" "this" {
		021:   depends_on = [aws_vpc.this]


IAM Access Analyzer Not Enabled, Severity: LOW, Results: 3
Description: IAM Access Analyzer should be enabled and configured to continuously monitor resource permissions
Platform: Terraform
CWE: 710
Learn more about this vulnerability: https://docs.kics.io/latest/queries/terraform-queries/aws/e592a0c5-5bdb-414c-9066-5dba7cdea370

	[1]: ./devops-caffeine/KICS/modules/aws/vpc/subnets.tf:14

		013:
		014: resource "aws_subnet" "private" {
		015:   count                   = length(data.aws_availability_zones.available.names)


	[2]: ./devops-caffeine/KICS/modules/aws/vpc/route-tables.tf:14

		013:
		014: resource "aws_route_table" "private" {
		015:   vpc_id = aws_vpc.this.id


	[3]: ./devops-caffeine/KICS/modules/aws/vpc/main.tf:8

		007:
		008: resource "aws_vpc" "this" {
		009:   cidr_block                       = var.cidr_block


VPC Without Network Firewall, Severity: MEDIUM, Results: 1
Description: VPC should have a Network Firewall associated
Platform: Terraform
CWE: 311
Learn more about this vulnerability: https://docs.kics.io/latest/queries/terraform-queries/aws/fd632aaf-b8a1-424d-a4d1-0de22fd3247a

	[1]: ./devops-caffeine/KICS/modules/aws/vpc/main.tf:8

		007:
		008: resource "aws_vpc" "this" {
		009:   cidr_block                       = var.cidr_block


VPC FlowLogs Disabled, Severity: MEDIUM, Results: 1
Description: Every VPC resource should have an associated Flow Log
Platform: Terraform
CWE: 778
Learn more about this vulnerability: https://docs.kics.io/latest/queries/terraform-queries/aws/f83121ea-03da-434f-9277-9cd247ab3047

	[1]: ./devops-caffeine/KICS/modules/aws/vpc/main.tf:8

		007:
		008: resource "aws_vpc" "this" {
		009:   cidr_block                       = var.cidr_block



Results Summary:
CRITICAL: 0
HIGH: 0
MEDIUM: 2
LOW: 4
INFO: 7
TOTAL: 13

Generating Reports: Done

```