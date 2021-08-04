## Providers definition
provider "aws" {
  region = "eu-west-3"
  shared_credentials_file = "%USERPROFILE%\\.aws\\credentials"
}

## S3
# Creates bucket to store logs
resource "aws_s3_bucket" "website_logs" {
  bucket = "${var.bucket-name}-logs"
  acl    = "log-delivery-write"

  # Comment the following line if you are uncomfortable with Terraform destroying the bucket even if this one is not empty 
  force_destroy = true

  tags = {
    Owner = "pp"
    ManagedBy = "terraform"
    Changed   = formatdate("YYYY-MM-DD hh:mm ZZZ", timestamp())
  }

  lifecycle {
    ignore_changes = [tags]
  }
}

# Creates bucket to store the static website
resource "aws_s3_bucket" "website" {
  bucket = "${var.bucket-name}"
  acl    = "public-read"

  # Comment the following line if you are uncomfortable with Terraform destroying the bucket even if not empty 
  force_destroy = true

  logging {
    target_bucket = aws_s3_bucket.website_logs.bucket
    target_prefix = "${var.bucket-name}/"
  }

  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  tags = {
    ManagedBy = "terraform"
    Changed   = formatdate("YYYY-MM-DD hh:mm ZZZ", timestamp())
  }

  lifecycle {
    ignore_changes = [tags]
  }
}

# Creates policy to allow public access to the S3 bucket
resource "aws_s3_bucket_policy" "update_website_bucket_policy" {
  bucket = aws_s3_bucket.website.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "PolicyForWebsiteEndpointsPublicContent",
  "Statement": [
    {
      "Sid": "PublicRead",
      "Effect": "Allow",
      "Principal": "*",
      "Action": [
        "s3:GetObject"
      ],
      "Resource": [
        "${aws_s3_bucket.website.arn}/*",
        "${aws_s3_bucket.website.arn}"
      ]
    }
  ]
}
POLICY
}
