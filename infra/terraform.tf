terraform {
  required_version = ">= 1.6.4"
  required_providers {
    aws = {
      version = "~> 5.12.0"
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  profile = "default"
}
