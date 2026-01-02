output "cloudtrail_arn" {
  value = aws_cloudtrail.global.arn
}

output "audit_log_bucket_id" {
  value = aws_s3_bucket.audit_logs.id
}
