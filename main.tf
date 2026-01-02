/**
 * AWS CIS Foundations Benchmark v1.4.0 Baseline
 * 
 * Enforces Level 1 security controls across an AWS account.
 */

# --- 1. IAM SECURITY ---

resource "aws_iam_account_password_policy" "strict" {
  minimum_password_length        = var.password_min_length
  require_lowercase_characters   = true
  require_numbers               = true
  require_uppercase_characters   = true
  require_symbols               = true
  allow_users_to_change_password = true
  password_reuse_prevention      = 24
  max_password_age              = 90
}

# --- 3. LOGGING & MONITORING ---

resource "aws_s3_bucket" "audit_logs" {
  bucket        = var.audit_log_bucket_name
  force_destroy = false
}

resource "aws_s3_bucket_public_access_block" "audit_logs" {
  bucket = aws_s3_bucket.audit_logs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_cloudtrail" "global" {
  name                          = "organizational-audit-trail"
  s3_bucket_name                = aws_s3_bucket.audit_logs.id
  include_global_service_events = true
  is_multi_region_trail         = true
  enable_log_file_validation    = true
  kms_key_id                    = var.kms_key_arn

  event_selector {
    read_write_type           = "All"
    include_management_events = true

    data_resource {
      type   = "AWS::S3::Object"
      values = ["arn:aws:s3:::"]
    }
  }

  tags = var.tags
}

# --- 4. NETWORKING ---

resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC (Locked Down)"
  }
}

resource "aws_default_security_group" "default" {
  vpc_id = aws_default_vpc.default.id

  # CIS 4.3: Ensure no security groups allow ingress from 0.0.0.0/0
  # No ingress rules defined = Default Deny
}
