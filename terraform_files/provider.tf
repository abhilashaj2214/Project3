terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.57.1"
    }
  }
backend "s3" {
    bucket = "terraformnetwork"
    key    = "state/terraform.state"
    region = "us-east-1"
  }
}

provider "aws" {
  # Configuration options
  region= "us-east-1"
}
