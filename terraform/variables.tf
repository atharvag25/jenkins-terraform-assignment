
variable "aws_region" {
  description = "AWS region for S3 bucket provisioning"
  type        = string
  default     = "ap-southeast-2"
}

variable "bucket_name" {
  description = "Globally unique S3 bucket name"
  type        = string
  default     = "atharvag25-terraform-cicd-demo-2026"
}
