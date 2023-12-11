##----------------------------------------------------------------------------------------------------------------
# Variables to containers
##----------------------------------------------------------------------------------------------------------------

locals {
  sto-lakegen2 = ["bronze", "silver", "gold", "landing", "processing", "curated"]
  sto-general  = ["config"]
}


##----------------------------------------------------------------------------------------------------------------
#   Sleep is needed to wait for role assignment to propagate
##----------------------------------------------------------------------------------------------------------------


resource "time_sleep" "role_assignment_sleep" {
  count           = var.storage != "false" ? 1 : 0
  create_duration = "180s"

  triggers = {
    #role_assignment = azurerm_role_assignment.role_assignment.id
  }
}


##----------------------------------------------------------------------------------------------------------------
#  Creating General containers
##----------------------------------------------------------------------------------------------------------------

resource "azurerm_storage_container" "stg_config" {
  for_each              = var.storage ? toset(local.sto-general) : []
  name                  = each.key
  storage_account_name  = "stgib${var.env.name}${var.project.team}"
  container_access_type = "private"

  # lifecycle {
  #   prevent_destroy = true
  # }

  depends_on = [
    data.azurerm_storage_account.lake,
    azurerm_storage_encryption_scope.crypto_config_scope,
    time_sleep.role_assignment_sleep
  ]

}


##----------------------------------------------------------------------------------------------------------------
#  Creating Data Lake Gen2 containers
##----------------------------------------------------------------------------------------------------------------


resource "azurerm_storage_data_lake_gen2_filesystem" "stg_gen2fs_bronze" {

  for_each           = var.storage ? toset(local.sto-lakegen2) : []
  name               = each.key
  storage_account_id = data.azurerm_storage_account.lake.id

  depends_on = [
    data.azurerm_storage_account.lake,
    azurerm_storage_encryption_scope.crypto_config_scope,
    time_sleep.role_assignment_sleep
  ]

  # lifecycle {
  #   prevent_destroy = true
  # }

}
