#### After create route will need associate snet with specific routes
locals {
  snets = [
    # "${data.azurerm_subnet.svc.id}",
    # "${data.azurerm_subnet.adfir.id}",
    "${data.azurerm_subnet.dbw-ext.id}",
    #"${data.azurerm_subnet.lake.id}",
  ]
}


##
resource "azurerm_subnet_route_table_association" "snet_to_rt" {
  for_each       = toset(local.snets)
  subnet_id      = each.key
  route_table_id = data.azurerm_route_table.rt_table_product.id

  lifecycle {
    ignore_changes = [
      route_table_id,
    ]
  }
  depends_on = [
    data.azurerm_route_table.rt_table_product
  ]
}
