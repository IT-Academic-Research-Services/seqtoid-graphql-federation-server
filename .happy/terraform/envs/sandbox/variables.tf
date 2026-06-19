variable "app" {
  type        = string
  description = "Application name"
  default     = "seqtoid-graphql-federation-server"
}

variable "aws_account_id" {
  type        = string
  description = "AWS account ID to apply changes to"
  default     = "941377154785"
}

# variable "aws_role" {
#   type        = string
#   description = "Name of the AWS role to assume to apply changes"
# }

variable "env" {
  type        = string
  description = "Environment name"
  default     = "sandbox"
}

# variable "happymeta_" {
#   type        = string
#   description = "Happy Path metadata. Ignored by actual terraform."
# }

variable "image_tag" {
  type        = string
  description = "Please provide an image tag"
}

variable "image_tags" {
  type        = string
  description = "Override the default image tags (json-encoded map)"
  default     = "{}"
}

variable "k8s_cluster_id" {
  type        = string
  description = "EKS K8S Cluster ID"
  default = "czid-sandbox-eks"
}

variable "k8s_namespace" {
  type        = string
  description = "K8S namespace for this stack"
  default = "czid-sandbox-happy-happy-env"
}

variable "stack_name" {
  type        = string
  description = "Happy Path stack name"
  default = "seqtoid-gql"
}
