
output "s3_bucket_name" {
  description = "Name of the provisioned S3 bucket"
  value       = aws_s3_bucket.project_bucket.bucket
}

output "s3_bucket_arn" {
  description = "ARN of the provisioned S3 bucket"
  value       = aws_s3_bucket.project_bucket.arn
}

output "s3_bucket_region" {
  description = "AWS region of the S3 bucket"
  value       = var.aws_region
}