module "my_stream" {
  source                   = "./modules/aws/kinesis"
  environment              = local.account_name
  kinesis_stream           = "my-stream"
  kinesis_retention_period = 24
  kinesis_shard_count      = 1
}
