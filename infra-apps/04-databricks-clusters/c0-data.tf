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
data "azurerm_databricks_workspace" "dbw" {
  name                = "dbw-gib${var.env.name}-${var.project.team}"
  resource_group_name = data.azurerm_resource_group.rg.name
}


output "databricks_workspace_id" {
  value = data.azurerm_databricks_workspace.dbw.workspace_id
}


output "databricks_workspace_url" {
  value = data.azurerm_databricks_workspace.dbw.workspace_url
}



output "databricks_id" {
  value = data.azurerm_databricks_workspace.dbw.id
}