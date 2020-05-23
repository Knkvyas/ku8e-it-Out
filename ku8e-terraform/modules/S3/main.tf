# still need to work on this module..



resource "aws_s3_bucket" "s3-bucket" {
  bucket = "ku8e-s3-test-bucket"
  acl    = "private"
    versioning {
    enabled = true
  }
  tags = {
    Name        = "ku8e-s3-product"
    Environment = "Prod"
    tag         = "HU2020-product-ku8e"
  }
}



# # upload file 
# resource "aws_s3_bucket_object" "upload-file" {
#   bucket = "s3-bucket"
#   key    = "my_bucket_key"
#   source = "${path.module}/my_files.zip"
#   etag   = "${filemd5("${path.module}/my_files.zip")}"
# #   source = "my_files.zip"
# }