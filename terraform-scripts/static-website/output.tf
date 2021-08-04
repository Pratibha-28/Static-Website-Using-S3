output "website_endpoint" {
  description = "Main CloudFront Distribution ID"
  value       = aws_s3_bucket.website.website_endpoint
}