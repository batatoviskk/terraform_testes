resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-${var.env.name}-adb-${var.project.team}"
  resource_group_name = join("-", ["rg", "gib${var.env.name}", "team", var.project.team, "backend"])
  #resource_group_name = "rg-gibdev-tombamento2"
  location = var.env.location

  tags = var.env.name == "dev" ? var.project.tags-dev : var.env.name == "qas" ? var.project.tags-qas : var.project.tags-prd
}

resource "azurerm_subnet_network_security_group_association" "nsg_subnet_private" {
  subnet_id                 = data.azurerm_subnet.snet-dbw-int.id
  network_security_group_id = azurerm_network_security_group.nsg.id
  depends_on = [
    azurerm_network_security_group.nsg
  ]

}

resource "azurerm_subnet_network_security_group_association" "nsg_subnet_public" {
  subnet_id                 = data.azurerm_subnet.snet-dbw-ext.id
  network_security_group_id = azurerm_network_security_group.nsg.id

  depends_on = [
    azurerm_network_security_group.nsg
  ]
}
