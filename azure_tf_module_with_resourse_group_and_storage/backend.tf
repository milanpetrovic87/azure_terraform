terraform {
  backend "azurerm" {
    resource_group_name  = "AKSRG"
    storage_account_name = "stg2f4n6m"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}


