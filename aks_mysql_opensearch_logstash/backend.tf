terraform {
  backend "azurerm" {
    resource_group_name  = "KubernetesRG"
    storage_account_name = "tfstatex62cp"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}