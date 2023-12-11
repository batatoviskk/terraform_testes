data "azurerm_virtual_network" "vnet_root" {
  name                = var.env.vnet.virtual_network_name
  resource_group_name = var.env.vnet.resource_group_name
}


data "azurerm_subnet" "dbw-ext" {
  name                 = "snet-${var.project.team}-dbw-ext"
  virtual_network_name = var.env.vnet.virtual_network_name
  resource_group_name  = var.env.vnet.resource_group_name
}



data "azurerm_subnet" "dbw-int" {
  name                 = "snet-${var.project.team}-dbw-int"
  virtual_network_name = var.env.vnet.virtual_network_name
  resource_group_name  = var.env.vnet.resource_group_name
}


data "azurerm_route_table" "rt_table_product" {
  name                = "rt-gibdev-snet-product-${var.project.team}"
  resource_group_name = join("-", ["rg", "gib${var.env.name}", "team", var.project.team, "backend"])
  depends_on = [

    module.router-product
  ]
}
