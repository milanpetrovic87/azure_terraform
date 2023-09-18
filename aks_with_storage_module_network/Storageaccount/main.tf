terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.5.1"
    }
  }
}

resource "random_string" "random" {
length = 6
special = false
upper = false
  
}

resource "azurerm_storage_account" "tfstate" {
  name                     = "tfstate${random_string.random.result}"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "blob"
  depends_on = [ var.resource_group_name, azurerm_storage_account.tfstate ]
}