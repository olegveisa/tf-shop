locals {
  name_prefix = "${var.project}-${var.env}"
  common_tags = {
    Project   = var.project
    Env       = var.env
    ManagedBy = "terraform"
  }
}

# main.tf
terraform {
  required_version = ">= 1.9"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
}

resource "aws_s3_bucket" "assets" {
  bucket = "tf-shop-assets-veisa-2026"
  tags   = merge(local.common_tags, { Name = "${local.name_prefix}-assets" })
}

terraform {
  backend "s3" {
    bucket      = "tf-state-veisa-2026"
    key         = "shop/terraform.tfstate" # шлях усередині бакета
    region      = "eu-central-1"
    encrypt     = true
    use_lockfile = true                    # блокування засобами S3
  }
}

