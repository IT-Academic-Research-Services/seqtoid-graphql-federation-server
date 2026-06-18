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
    happy = {
      source  = "chanzuckerberg/happy"
      version = ">= 0.127.5"
    }
  }
  backend "s3" {
    bucket = "tfstate-491013321714-test"
    key    = "graphql.tfstate"
    # key="terraform/seqtoid-graphql/envs/dev/stack/happy.tfstate"
    encrypt = true
    region  = "us-west-2"
    profile = "idseq-dev"
  }
  required_version = ">= 1.3"
}
