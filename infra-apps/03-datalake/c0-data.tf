#----------------------------------------------------------------------------------------------------------------
# Obtain Data of  RG e VNET TGW
#----------------------------------------------------------------------------------------------------------------
data "azurerm_subscription" "primary" {}
data "azurerm_client_config" "current" {}

data "azurerm_resource_group" "rg" {
  name = var.project.rg_to_global == "true" ? "rg-gib${var.env.name}-global" : join("-", ["rg", "gib${var.env.name}", "team", var.project.team])
}

data "azurerm_virtual_network" "vnet_root" {
  name                = var.env.vnet.virtual_network_name
  resource_group_name = var.env.vnet.resource_group_name
}


#----------------------------------------------------------------------------------------------------------------
# Obtain Data of Storage Account of specific project -- Depends on module Networking
#----------------------------------------------------------------------------------------------------------------

data "azurerm_storage_account" "lake" {
  name                = "stgib${var.env.name}${var.project.team}"
  resource_group_name = data.azurerm_resource_group.rg.name
  depends_on = [
    module.storage
  ]
}


#----------------------------------------------------------------------------------------------------------------
# Obtain Data of zones de dns of  TGW to specific Private Endpoint
#----------------------------------------------------------------------------------------------------------------

data "azurerm_private_dns_zone" "dns_zone_dfs" {
  name                = "privatelink.dfs.core.windows.net"
  resource_group_name = var.tgw.dns_zones.resource_group_name
  provider            = azurerm.tgw
}

data "azurerm_private_dns_zone" "dns_zone_blob" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = var.tgw.dns_zones.resource_group_name
  provider            = azurerm.tgw
}

#----------------------------------------------------------------------------------------------------------------
# Obtain Data of Subnets around of project
#----------------------------------------------------------------------------------------------------------------

data "azurerm_subnet" "snet-svc" {
  name                 = "snet-${var.project.team}-svc"
  virtual_network_name = data.azurerm_virtual_network.vnet_root.name
  resource_group_name  = data.azurerm_virtual_network.vnet_root.resource_group_name
}

data "azurerm_subnet" "snet-adfir" {
  name                 = "snet-${var.project.team}-adfir"
  virtual_network_name = data.azurerm_virtual_network.vnet_root.name
  resource_group_name  = data.azurerm_virtual_network.vnet_root.resource_group_name
}


data "azurerm_subnet" "snet-dbw-int" {
  name                 = "snet-${var.project.team}-dbw-int"
  virtual_network_name = data.azurerm_virtual_network.vnet_root.name
  resource_group_name  = data.azurerm_virtual_network.vnet_root.resource_group_name
}


data "azurerm_subnet" "snet-dbw-ext" {
  name                 = "snet-${var.project.team}-dbw-ext"
  virtual_network_name = data.azurerm_virtual_network.vnet_root.name
  resource_group_name  = data.azurerm_virtual_network.vnet_root.resource_group_name
}


data "azurerm_subnet" "snet-lake" {
  name                 = "snet-${var.project.team}-lake"
  virtual_network_name = data.azurerm_virtual_network.vnet_root.name
  resource_group_name  = data.azurerm_virtual_network.vnet_root.resource_group_name
}


