locals {
  organization_name         = "nogueira"
  account_name              = "shared"
  account_region            = "us-east-1"
  organization_account_name = format("%s-%s", local.organization_name, local.account_name)
}