resource "aws_s3_bucket" "secure_files" {
  bucket = "secure-files-bucket"
}

resource "aws_s3_bucket_public_access_block" "secure_files" {
  bucket = aws_s3_bucket.secure_files.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "secure_files" {
  bucket = aws_s3_bucket.secure_files.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "secure_files" {
  bucket = aws_s3_bucket.secure_files.id

  rule {
    id     = "cleanup-old-versions"
    status = "Enabled"

    noncurrent_version_expiration {
      noncurrent_days = 30
    }
  }
}
