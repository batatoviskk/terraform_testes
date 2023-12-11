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
# Obtain Databricks
#----------------------------------------------------------------------------------------------------------------

data "azurerm_databricks_workspace" "adb-wks" {
  name                = "dbw-gib${var.env.name}-${var.project.team}"
  resource_group_name = data.azurerm_resource_group.rg.name
}


# #----------------------------------------------------------------------------------------------------------------
# # Obtain PrivateDns Zone 
# #----------------------------------------------------------------------------------------------------------------


data "azurerm_private_dns_zone" "dns_zone_dataFactory" {
  name                = "privatelink.datafactory.azure.net"
  resource_group_name = var.tgw.dns_zones.resource_group_name
  provider            = azurerm.tgw
}

data "azurerm_private_dns_zone" "dns_zone_portal" {
  name                = "privatelink.adf.azure.com"
  resource_group_name = var.tgw.dns_zones.resource_group_name
  provider            = azurerm.tgw
}


# #----------------------------------------------------------------------------------------------------------------
# # Obtain Subnets
# #----------------------------------------------------------------------------------------------------------------

data "azurerm_subnet" "subnet_adf" {
  name                 = "snet-${var.project.team}-adfir"
  virtual_network_name = data.azurerm_virtual_network.vnet_root.name
  resource_group_name  = data.azurerm_virtual_network.vnet_root.resource_group_name
}


# # #----------------------------------------------------------------------------------------------------------------
# # # Obtain Lake
# # #----------------------------------------------------------------------------------------------------------------
# data "azurerm_storage_account" "datalake" {
#   name                = "stgib${var.env.name}platform"
#   resource_group_name = "rg-gib${var.env.name}-team-platform"
# }