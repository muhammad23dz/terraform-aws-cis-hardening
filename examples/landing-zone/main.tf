module "security_baseline" {
  source = "../"

  audit_log_bucket_name = "corp-auditing-logs-${data.aws_caller_identity.current.account_id}"
  alert_email           = "security-ops@example.com"

  tags = {
    Environment = "Production"
    ManagedBy   = "Terraform"
    Project     = "Security-Baseline"
  }
}

data "aws_caller_identity" "current" {}

provider "aws" {
  region = "us-east-1"
}
