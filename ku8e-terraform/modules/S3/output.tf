output "bucket-version" {
  value = "${aws_s3_bucket_object.file_upload.version_id}"
}


output "arn" {
  description = "ARN of the bucket"
  value       = aws_s3_bucket.s3_bucket.arn
}

output "bucket-name" {
  description = "Name (id) of the bucket"
  value       = aws_s3_bucket.s3_bucket.id
}

output "website-endpoint" {
  description = "Domain name of the bucket"
  value       = aws_s3_bucket.s3_bucket.website_endpoint
}