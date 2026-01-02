variable "audit_log_bucket_name" {
  description = "The name of the S3 bucket to store CloudTrail logs."
  type        = string
}

variable "password_min_length" {
  description = "Minimum IAM password length."
  type        = number
  default     = 14
}

variable "kms_key_arn" {
  description = "Optional KMS Key ARN for CloudTrail encryption."
  type        = string
  default     = null
}

variable "tags" {
  description = "Resource tags."
  type        = map(string)
  default     = {}
}
