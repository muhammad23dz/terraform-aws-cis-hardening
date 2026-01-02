variable "audit_log_bucket_name" {
  description = "The name of the S3 bucket to store CloudTrail logs."
  type        = string
}

variable "password_min_length" {
  description = "Minimum IAM password length."
  type        = number
  default     = 14
}

variable "alert_email" {
  description = "Email address to receive security alerts."
  type        = string
}

variable "tags" {
  description = "Resource tags."
  type        = map(string)
  default     = {}
}
