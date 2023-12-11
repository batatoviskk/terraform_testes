#Range IPS 
locals {
  cidr-dbw-int = "${var.env.vnet.num_ip}.0/26"
  cidr_dbw-ext = "${var.env.vnet.num_ip}.64/26"
}


module "networking" {
  source = "git@ssh.dev.azure.com:/v3/ArquiteturaEstacio/Gibraltar - Plataforma/terraform-yduqs-modules//networking-delegation"

  resource_group_name                           = data.azurerm_virtual_network.vnet_root.resource_group_name
  virtual_network_name                          = data.azurerm_virtual_network.vnet_root.name
  private_link_service_network_policies_enabled = true

  delegations_to = {
    ### Subnets will be to create
    "dbw-int" = {
      subnet_name       = "snet-${var.project.team}-dbw-int",
      address_prefixes  = ["${var.env.vnet.range_network}${local.cidr-dbw-int}"],
      service_endpoints = ["Microsoft.Storage", "Microsoft.Sql", "Microsoft.KeyVault"],

      delegation_name         = "delegation-to-${var.project.team}-dbw-int",
      service_delegation_name = "Microsoft.Databricks/workspaces",
      service_delegation_actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
        "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
        "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"
      ]
    },

    "dbw-ext" = {
      subnet_name       = "snet-${var.project.team}-dbw-ext",
      address_prefixes  = ["${var.env.vnet.range_network}${local.cidr_dbw-ext}"],
      service_endpoints = ["Microsoft.Storage", "Microsoft.Sql", "Microsoft.KeyVault"],

      delegation_name         = "delegation-to-${var.project.team}-dbw-ext",
      service_delegation_name = "Microsoft.Databricks/workspaces",
      service_delegation_actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
        "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
        "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"
      ]
    },

  }
}

