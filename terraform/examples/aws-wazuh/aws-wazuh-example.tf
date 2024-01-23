terraform {
  required_version = ">= 1.6.1"
  cloud {
    organization = "cyberworld-builders"

    workspaces {
      name = "aws-wazuh"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.30.0"
    }
  }
}

module "aws-wazuh" {
  # source = "../../modules/aws-wazuh"

  # reference a specific branch as a source
  source = "github.com/cyberworld-builders/terraform/modules/aws-wazuh?ref=8-research-launch-a-wuzah-server-implementation-on-aws"

  # project_name = "br"
  # environment  = "example"
  # region       = "us-east-1"
}