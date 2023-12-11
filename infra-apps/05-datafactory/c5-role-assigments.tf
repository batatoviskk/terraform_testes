#----------------------------------------------------------------------
# Allow managment Identity datafactoy on Databricks 
# To associate linked service
#-----------------------------------------------------------------------

resource "azurerm_role_assignment" "adf_to_databricks" {
  role_definition_name = "Contributor"

  scope        = data.azurerm_databricks_workspace.adb-wks.id
  principal_id = module.adf.data_factory_principal_id
  depends_on = [
    module.adf,
    data.azurerm_databricks_workspace.adb-wks
  ]
}


# #----------------------------------------------------------------------
# # Allow managment Identity datafactoy on StorageAccount [ Datalake ]
# # To associate linked service
# #-----------------------------------------------------------------------

# resource "azurerm_role_assignment" "adf_to_datalake" {
#   role_definition_name = "Storage Blob Data Contributor"

#   scope        = data.azurerm_storage_account.datalake.id
#   principal_id = module.adf.factory.principal_id
#   depends_on = [
#     data.azurerm_storage_account.datalake,
#     module.adf
#   ]
# }
