# Terraform Block
terraform {
  required_version = ">= 1.2.3, < 1.4.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.0"
    }
  }
}

# Provider Block
provider "azurerm" {
  features {}
}

terraform {
  backend "azurerm" {
    container_name = "tfstates-rg"
    key            = "rg-estruturante.tfstate"
  }
}

resource "null_resource" "git_init" {

}