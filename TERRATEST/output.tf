output "bucket_name" {
  value = aws_s3_bucket.this.id
}

output "encryption_key_arn" {
  value = aws_kms_key.this.arn
}

output "sg_id" {
  value = aws_security_group.secure_sg.id
}