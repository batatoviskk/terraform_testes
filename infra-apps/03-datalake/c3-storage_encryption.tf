
#----------------------------------------------------------------------------------------------------------------
#  Storage Account Encryption Configuration
#----------------------------------------------------------------------------------------------------------------


resource "azurerm_storage_encryption_scope" "crypto_config_scope" {
  name               = "microsoftmanaged"
  storage_account_id = data.azurerm_storage_account.lake.id
  source             = "Microsoft.Storage"

  infrastructure_encryption_required = true

  depends_on = [
    module.storage
  ]

}

