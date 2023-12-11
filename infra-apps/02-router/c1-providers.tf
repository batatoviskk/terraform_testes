# Terraform Block
terraform {
  required_version = ">= 1.2.3, < 1.4.0"
  required_providers {
    azurerm = {
      configuration_aliases = [azurerm.tgw]
      source                = "hashicorp/azurerm"
      version               = ">= 2.0"
    }
  }
}

# Provider Block
provider "azurerm" {
  features {}

  subscription_id = var.env.subscription_id
  tenant_id       = var.env.tenant_id
}
provider "azurerm" {
  features {}

  alias                      = "tgw"
  skip_provider_registration = true
  subscription_id            = var.tgw.subscription_id
  tenant_id                  = var.tgw.tenant_id

}

terraform {
  backend "azurerm" {
    container_name = "tfstates-net"
    key            = "router-estruturante.tfstate"
  }
}


