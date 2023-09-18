terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.71.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  skip_provider_registration = true # This is only required when the User, Service Principal, or Identity running Terraform lacks the permissions to register Azure Resource Providers.
  features {
    key_vault {
      purge_soft_deleted_secrets_on_destroy = true
      recover_soft_deleted_secrets          = true
    }
  }
}

resource "azurerm_resource_group" "rgmpetrovic" {
  name     = var.resourcegroup_name
  location = var.location
  tags     = var.tags
}

resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.rgmpetrovic.name
  location            = azurerm_resource_group.rgmpetrovic.location
  sku                 = "Standard"
  admin_enabled       = false
}

resource "azurerm_kubernetes_cluster" "cluster" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = azurerm_resource_group.rgmpetrovic.name
  dns_prefix          = var.cluster_name
  depends_on          = [azurerm_resource_group.rgmpetrovic]


  default_node_pool {
    name                        = "default"
    node_count                  = "2"
    vm_size                     = "standard_d2_v2"
    temporary_name_for_rotation = "exampleaks1"


    linux_os_config {
      sysctl_config {
        vm_max_map_count = 262144
      }
    }
  }

  identity {
    type = "SystemAssigned"
  }

  lifecycle {
    prevent_destroy = true
  }
}

module "Storageaccount" {
  source = "./Storageaccount"
  #base_name = "TerraformExample01"
  resource_group_name = var.resourcegroup_name
  location            = var.location
}

# add the role to the aks system identity 
resource "azurerm_role_assignment" "aks_to_acr" {
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.cluster.kubelet_identity[0].object_id
}