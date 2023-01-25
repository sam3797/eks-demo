terraform {
 required_providers {
  aws = {
   source = "hashicorp/aws"
  }

kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.16.1"
    }
  }
  backend "s3" {
  region = "us-east-1"
  bucket = "statefiles-terraform-github"
  key    = "eks.tfstate"
  }
}