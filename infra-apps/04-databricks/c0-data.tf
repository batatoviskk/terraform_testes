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
# Obtain Data of Subnets around of project
#----------------------------------------------------------------------------------------------------------------



data "azurerm_subnet" "snet-dbw-int" {
  #name                 = "snet-databricks-tombamento-priv"
  name                 = "snet-${var.project.team}-dbw-int"
  virtual_network_name = data.azurerm_virtual_network.vnet_root.name
  resource_group_name  = data.azurerm_virtual_network.vnet_root.resource_group_name
}


data "azurerm_subnet" "snet-dbw-ext" {
  #name                 = "snet-databricks-tombamento-pub"
  name = "snet-${var.project.team}-dbw-ext"

  virtual_network_name = data.azurerm_virtual_network.vnet_root.name
  resource_group_name  = data.azurerm_virtual_network.vnet_root.resource_group_name
}




