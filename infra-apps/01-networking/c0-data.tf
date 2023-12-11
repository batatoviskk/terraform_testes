data "azurerm_virtual_network" "vnet_root" {
  name                = var.env.vnet.virtual_network_name
  resource_group_name = var.env.vnet.resource_group_name
}
