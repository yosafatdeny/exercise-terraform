terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.26.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region     = var.AWS_REGION
}