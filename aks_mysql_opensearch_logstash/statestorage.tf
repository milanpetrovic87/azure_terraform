#Create random unique stirng for Azure storage account
resource "random_string" "resource_code" {
  length  = 5
  special = false
  upper   = false

}

resource "azurerm_storage_account" "tfstate" {
  name                            = "tfstate${random_string.resource_code.result}"
  resource_group_name             = azurerm_resource_group.aks_rg.name
  location                        = var.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  allow_nested_items_to_be_public = true
   depends_on = [ azurerm_resource_group.aks_rg ]

}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "blob"
  depends_on = [ azurerm_resource_group.aks_rg, azurerm_storage_account.tfstate ]
}

