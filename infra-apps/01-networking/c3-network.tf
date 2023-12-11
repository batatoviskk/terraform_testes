locals {
  cidr-svc   = "${var.env.vnet.num_ip}.128/28"
  cidr-adfir = "${var.env.vnet.num_ip}.144/28"
  cidr-lake  = "${var.env.vnet.num_ip}.160/27"
}


module "networking" {
  source = "git@ssh.dev.azure.com:/v3/ArquiteturaEstacio/Gibraltar - Plataforma/terraform-yduqs-modules//networking"
  # Networking

  resource_group_name                           = data.azurerm_virtual_network.vnet_root.resource_group_name
  virtual_network_name                          = data.azurerm_virtual_network.vnet_root.name
  private_link_service_network_policies_enabled = true

  config_subnets_to_project = {
    "svc" = {

      subnet_name       = "snet-${var.project.team}-svc"
      address_prefixes  = ["${var.env.vnet.range_network}${local.cidr-svc}"]
      service_endpoints = ["Microsoft.Storage", "Microsoft.Sql", "Microsoft.KeyVault"]
    },

    "adfir" = {

      subnet_name       = "snet-${var.project.team}-adfir"
      address_prefixes  = ["${var.env.vnet.range_network}${local.cidr-adfir}"]
      service_endpoints = ["Microsoft.Storage", "Microsoft.Sql", "Microsoft.KeyVault"]
    },


    "lake" = {
      subnet_name       = "snet-${var.project.team}-lake"
      address_prefixes  = ["${var.env.vnet.range_network}${local.cidr-lake}"]
      service_endpoints = ["Microsoft.Storage", "Microsoft.Sql", "Microsoft.KeyVault"]
    },
  }
}




