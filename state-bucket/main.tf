provider "aws" {
  region = "eu-central-1"
}

resource "aws_s3_bucket" "protected_state" {
  bucket = "tf-state-protected-veisa-2026"

  lifecycle {
    prevent_destroy = true
  }
}
