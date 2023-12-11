## Module Responsible to create routes.
module "router-product" {
  source              = "git@ssh.dev.azure.com:/v3/ArquiteturaEstacio/Gibraltar - Plataforma/terraform-yduqs-modules//router-table"
  router_name         = "rt-gibdev-snet-product-${var.project.team}"
  resource_group_name = join("-", ["rg", "gib${var.env.name}", "team", var.project.team, "backend"])
  location            = var.env.location
  config_routes = [
    { name = "FirewallHub", address_prefix = "0.0.0.0/0", next_hop_type = "VirtualAppliance", next_hop_in_ip_address = "10.140.249.4" },
    { name = "DataBricks", address_prefix = "AzureDatabricks", next_hop_type = "Internet" },
    # { name = "LUMEN",       address_prefix = "10.150.0.0/16",    next_hop_type = "VirtualAppliance", next_hop_in_ip_address = "10.140.249.4"},
    # { name = "AWS-DEV",     address_prefix = "10.150.0.0/16",    next_hop_type = "VirtualAppliance", next_hop_in_ip_address = "10.140.249.4"},
  ]
  disable_bgp_route_propagation = false
}

