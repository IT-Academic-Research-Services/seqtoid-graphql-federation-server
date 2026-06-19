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
    bucket = "tfstate-941377154785-test"
    key     = "terraform/seqtoid-graphql/envs/sandbox/stack/happy.tfstate"
    encrypt = true
    region  = "us-west-2"
    //TODO - Can remove if this doesn't play nice with GHA
    profile = "default"
  }
  required_version = ">= 1.3"
}