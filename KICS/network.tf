locals {
  vpc = {
    cidr_block = "10.10.0.0/16"
  }
}

module "vpc" {
  source                    = "./modules/aws/vpc"
  organization_account_name = local.organization_account_name
  cidr_block                = local.vpc.cidr_block
}