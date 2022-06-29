terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.18.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region     = var.region
#  access_key = var.aws_access_key_id
#  secret_key = var.aws_secret_access_key
#  assume_role {
#    role_arn = var.role_arn
#  }
}

provider "azuread" {
  use_cli = false

  client_id     = var.client_id
  client_secret = var.client_secret
  tenant_id     = var.tenant_id
}

# provider "tfe" {
# }

# terraform {
#   backend "remote" {
#     organization = "sumup"
#     workspaces {
#       name = "sso-classic"
#     }
#   }
# }
