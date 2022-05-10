terraform {
  required_version = ">=1.1.9"

  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

output "endpoint-url" {
  value = "http://${aws_lb.example_ecspresso.dns_name}/"
}
