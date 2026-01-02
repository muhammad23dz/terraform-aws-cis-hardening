# AWS CIS Hardening Terraform Module

[![Security: CIS Benchmark](https://img.shields.io/badge/Security-CIS%20Benchmark-emerald)](https://www.cisecurity.org/benchmark/amazon_web_services)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

A production-ready Terraform module designed to enforce the **CIS AWS Foundations Benchmark v1.4.0 (Level 1)**. This module is intended for use during initial account provisioning to establish an immutable security baseline.

## Architectural Overview

This module focuses on the most critical identity and logging controls required by the CIS benchmark. It avoids "black-box" magic by using standard AWS resources with strict variable enforcement.

### Implemented Controls
- **IAM (Section 1)**: Strict password policies and root account monitoring.
- **Logging (Section 3)**: Global CloudTrail multi-region trails with log-file validation.
- **Networking (Section 4)**: Default VPC lockdown and security group restrictions.

## Usage

```hcl
module "cis_baseline" {
  source = "github.com/muhammad23dz/terraform-aws-cis-hardening"

  audit_log_bucket_name = "my-org-audit-logs"
  tags = {
    Environment = "Production"
    ManagedBy   = "Terraform"
  }
}
```

## Security Design Decisions

### Why CloudTrail Multi-Region?
Ensuring `is_multi_region_trail = true` is critical for detecting API activity in regions that your organization does not actively use. Attackers often provision high-cost or shadow resources in forgotten regions (e.g., `me-central-1`) to avoid detection.

### Password Policy Nuances
We enforce a 14-character minimum and 24-period reuse prevention. While modern identity focuses on MFA (also recommended), a strong password baseline reduces the success rate of automated credential stuffing against IAM users without MFA.

## License
MIT
