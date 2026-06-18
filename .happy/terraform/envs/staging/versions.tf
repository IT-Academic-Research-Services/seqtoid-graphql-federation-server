terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.45"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.16"
    }
    datadog = {
      source  = "datadog/datadog"
      version = ">= 3.20.0"
    }
  }
  backend "s3" {
    bucket  = "tfstate-030998640247"
    key     = "graphql.tfstate"
    encrypt = true
    region  = "us-west-2"
    profile = "idseq-staging"
  }
  required_version = ">= 1.3"
}
