#----------------------------------------------------------------------------------------------------------------
# Variables to  private-endpoints
#----------------------------------------------------------------------------------------------------------------

locals {
  zones = [
    {
      name = "dfs",
      ids  = "${data.azurerm_private_dns_zone.dns_zone_dfs.id}",
    },

    {
      name = "blob",
      ids  = "${data.azurerm_private_dns_zone.dns_zone_blob.id}",
    },
  ]
}

#----------------------------------------------------------------------------------------------------------------
# Creating private-endpoints
#----------------------------------------------------------------------------------------------------------------

resource "azurerm_private_endpoint" "endpoint_dfs" {


  for_each = { for index, zone in local.zones : zone.name => zone }

  name                = join("-", ["pe", var.project.prefix, var.project.team, var.project.name, each.value.name])
  resource_group_name = join("-", ["rg", "gib${var.env.name}", "team", var.project.team, "backend"])
  location            = var.env.location
  subnet_id           = data.azurerm_subnet.snet-lake.id

  private_service_connection {
    name                           = join("-", ["pesvc", var.project.prefix, var.project.team, var.project.name])
    is_manual_connection           = false
    private_connection_resource_id = data.azurerm_storage_account.lake.id
    subresource_names              = [each.value.name]
  }

  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = [each.value.ids]
  }

  depends_on = [
    data.azurerm_storage_account.lake
  ]

  tags = var.env.name == "dev" ? var.project.tags-dev : var.env.name == "qas" ? var.project.tags-qas : var.project.tags-prd

}

