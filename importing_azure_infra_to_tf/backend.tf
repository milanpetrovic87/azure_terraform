terraform {
  backend "azurerm" {
    resource_group_name = "myapp-rg"
    storage_account_name = "tfstate9sebn"
    container_name = "tfstate"
  }
}