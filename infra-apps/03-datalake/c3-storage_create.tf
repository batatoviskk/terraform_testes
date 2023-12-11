#----------------------------------------------------------------------------------------------------------------
# Module main - Create Storage 
#----------------------------------------------------------------------------------------------------------------

module "storage" {

  source = "git@ssh.dev.azure.com:/v3/ArquiteturaEstacio/Gibraltar - Plataforma/terraform-yduqs-modules//storage"
  storage = {
    name                = "stgib${var.env.name}${var.project.team}"
    resource_group_name = data.azurerm_resource_group.rg.name
    location            = var.env.location

    account_kind                      = "StorageV2"
    account_tier                      = "Standard"
    account_replication_type          = "LRS"
    allow_nested_items_to_be_public   = false
    shared_access_key_enabled         = true
    infrastructure_encryption_enabled = true
    is_hns_enabled                    = true
    enable_https_traffic_only         = true
    min_tls_version                   = "TLS1_2"

    blob_properties_change_feed_enabled = false
    blob_properties_versioning_enabled  = false
    delete_retention_policy_days        = "7"
    container_delete_retention_policy   = "7"

  }

  storage_network_rules = {
    default_action = "Deny"
    bypass         = ["AzureServices"]

    network_subnet_ids = [
      data.azurerm_subnet.snet-svc.id,
      data.azurerm_subnet.snet-adfir.id,
      data.azurerm_subnet.snet-dbw-int.id,
      data.azurerm_subnet.snet-dbw-ext.id,
      data.azurerm_subnet.snet-lake.id,
    ]
  }

  tags = var.env.name == "dev" ? var.project.tags-dev : var.env.name == "qas" ? var.project.tags-qas : var.project.tags-prd

}





