#----------------------------------------------------------------------------------------------------------------
# Module main - Create Storage 
#----------------------------------------------------------------------------------------------------------------
module "adb-wks" {
  source = "git@ssh.dev.azure.com:/v3/ArquiteturaEstacio/Gibraltar - Plataforma/terraform-yduqs-modules//databricks"

  bricks_name                   = "dbw-gib${var.env.name}-${var.project.team}"
  resource_group_name           = data.azurerm_resource_group.rg.name
  location                      = var.env.location
  sku                           = "premium"
  managed_resource_group_name   = join("-", ["rg", "gib${var.env.name}", "team", var.project.team, "adbclusters"])
  customer_managed_key_enabled  = true
  public_network_access_enabled = true

  custom_parameters = {
    no_public_ip          = true
    virtual_network_id    = data.azurerm_virtual_network.vnet_root.id
    subnet_public_name    = data.azurerm_subnet.snet-dbw-ext.name
    subnet_private_name   = data.azurerm_subnet.snet-dbw-int.name
    nsg_subnet_public_id  = azurerm_subnet_network_security_group_association.nsg_subnet_public.id
    nsg_subnet_private_id = azurerm_subnet_network_security_group_association.nsg_subnet_private.id
  }


  depends_on = [
    azurerm_subnet_network_security_group_association.nsg_subnet_public,
    azurerm_subnet_network_security_group_association.nsg_subnet_private
  ]



  tags = var.env.name == "dev" ? var.project.tags-dev : var.env.name == "qas" ? var.project.tags-qas : var.project.tags-prd

}
