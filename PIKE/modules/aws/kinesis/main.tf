resource "aws_kinesis_stream" "this" {
  name             = var.kinesis_stream
  retention_period = var.kinesis_retention_period
  encryption_type  = "NONE"
  shard_count      = var.kinesis_shard_count
  shard_level_metrics = [
    "OutgoingRecords",
    "IteratorAgeMilliseconds",
    "IncomingRecords",
    "ReadProvisionedThroughputExceeded",
    "WriteProvisionedThroughputExceeded"
  ]

  stream_mode_details {
    stream_mode = "PROVISIONED"
  }

  tags = {
    Environment = var.environment
  }
}
