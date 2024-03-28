terraform {
  required_version = ">= 1.7.5"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.10"
    }

    local = {
      source  = "hashicorp/local"
      version = "~>1.4"
    }
  }
}

module "firefox_verify_env" {
  source            = "../../../modules"

  namespace         = var.namespace
  windows-password  = var.windows-password
}