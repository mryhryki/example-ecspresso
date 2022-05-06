terraform {
  required_version = ">=1.1.9"

  backend "s3" {
    bucket = "mryhryki"
    region = "us-east-1"
    key    = "terraform/example-ecspresso/terraform.tfstate"
  }

  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

data "aws_caller_identity" "current" {}

locals {
  aws_account_id = data.aws_caller_identity.current.account_id
}
