terraform {
  required_version = ">= 1.6.4"
  required_providers {
    aws = {
      version = "~> 5.12.0"
      source  = "hashicorp/aws"
    }
  }

  backend "s3" {
    bucket = "llm-streaming"
    key = "terraform-state/teraform.tfstate"
    region = "us-east-1"
    profile = "default"

  }
}

provider "aws" {
  region = "us-east-1"
  profile = "default"

}
