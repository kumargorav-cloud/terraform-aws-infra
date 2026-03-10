resource "aws_s3_bucket" "storage" {
  bucket = var.bucket_name

  tags = {
    Name        = "devops-project-bucket"
    Environment = "dev"
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.storage.id

  versioning_configuration {
    status = "Enabled"
  }
}
