terraform {
  required_version = ">= 1.7.5"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.97.1"
    }

    local = {
      source  = "hashicorp/local"
      version = ">=2.5.1"
    }
  }
}

module "firefox_verify_env" {
  source = "../../../modules"
}