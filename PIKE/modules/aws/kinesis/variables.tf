variable "environment" {}
variable "kinesis_stream" {}
variable "kinesis_retention_period" {}
variable "kinesis_shard_count" {
  default = 1
}
