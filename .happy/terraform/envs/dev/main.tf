locals {
  alb_name         = "czid-${var.env}-web" //module.secrets.values.alb_name
  service_type     = "TARGET_GROUP_ONLY" //var.stack_name == local.magic_stack_name ? "TARGET_GROUP_ONLY" : "INTERNAL"
  routing_config   = {
    "INTERNAL" = {},
    "TARGET_GROUP_ONLY" = {
      path = "/graphqlfed*",
      alb = {
        name          = local.alb_name,
        listener_port = 443,
      }
    }
  }
  image_uri = "${var.aws_account_id}.dkr.ecr.us-west-2.amazonaws.com/seqtoid-gql/${var.env}/gql-federation"
}

# module "secrets" {
#   source = "github.com/chanzuckerberg/cztack//aws-ssm-params?ref=v0.40.0"
#
#   project = "czid"
#   env     = "dev"
#   service = "graphql-federation"
#
#   parameters = ["integration-secret"]
# }

module "stack" {
  source           = "../../modules/happy-stack-eks"
  image_tag        = var.image_tag
  image_tags       = jsondecode(var.image_tags)
  image_uri        = local.image_uri
  stack_name       = var.stack_name
  deployment_stage = var.env
  stack_prefix     = "/${var.stack_name}"
  k8s_namespace    = var.k8s_namespace
  app_name         = var.app
  additional_env_vars = {
    # API_URL = "https://${var.env}.seqtoid.org" http or https?
    # API_URL = "http://${var.env}.seqtoid.org:4444"
    API_URL = "https://${var.env}.seqtoid.org"
    # NEXTGEN_ENTITIES_URL = "http://ryan-test-entities.czid-dev-happy-happy-env.svc.cluster.local:8008"
    # NEXTGEN_WORKFLOWS_URL = "http://workflows.czidnet"
  }

  services = {
    gql = merge(local.routing_config[local.service_type], {
      # name                  = "graphql-federation"
      name              = "gql-federation",
      desired_count    = 1
      port                  = "4444"
      memory                = "1024Mi"
      memory_requests       = "1024Mi"
      cpu                   = "500m"
      cpu_requests          = "500m"
      initial_delay_seconds = "120"
      health_check_path     = "/health"
      // INTERNAL - OIDC protected ALB
      // EXTERNAL - external ALB
      // PRIVATE - cluster IP only, no ALB at all
      // TARGET_GROUP_ONLY - Only create a target group for use with an existing ALB
      service_type          = local.service_type
      platform_architecture = "amd64" # TODO: Was arm64

      additional_env_vars_from_secrets = {
        items = ["integration-secret"]
      }
    })
  }

  tasks = {
  }
}
