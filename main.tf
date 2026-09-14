locals {
  env         = terraform.workspace
  name_prefix = "${var.project}-${local.env}"
  
  instance_type = {
    dev  = "t3.micro"
    prod = "t3.small"
  }[terraform.workspace]

  common_tags = {
    Project   = var.project
    Env       = local.env
    ManagedBy = "terraform"
  }
}

provider "aws" {
  region = "eu-central-1"
}

terraform {
  required_version = ">= 1.9"

  cloud {
    organization = "devops-veisa"
    workspaces {
      tags = ["shop"]
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

module "network" {
  source   = "./modules/network"
  project  = var.project
  env      = local.env
  region   = var.region
  vpc_cidr = var.vpc_cidr
  subnets  = var.subnets
  tags     = local.common_tags
}