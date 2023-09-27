terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.71.0"
    }
  }
}

provider "azurerm" {
  skip_provider_registration = true
  features {
  }
}

module "ResourceGroup" {
  source = "./ResourceGroup"
  base_name = "AKS"
  location = var.location
}

module "Storageaccount" {
  source = "./StorageAccount"
  base_name = "STG"
  resource_group_name = module.ResourceGroup.rg_name_out
  location = var.location
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_name  = module.Storageaccount.stg_act_name_out
  container_access_type = "blob"
  depends_on = [ module.ResourceGroup, module.Storageaccount ]
}

resource "azurerm_kubernetes_cluster" "cluster" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = module.ResourceGroup.rg_name_out
  dns_prefix          = var.cluster_name


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

  # lifecycle {
  #   prevent_destroy = true
  # }
}

resource "random_integer" "ri" {
  min = 10000
  max = 99999
}

resource "azurerm_container_registry" "acr" {
  name                = "acrforimages${random_integer.ri.result}"
  resource_group_name = module.ResourceGroup.rg_name_out
  location            = var.location
  sku                 = "Standard"
  admin_enabled       = false
}

# add the role to the aks system identity 
resource "azurerm_role_assignment" "aks_to_acr" {
  scope               = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.cluster.kubelet_identity[0].object_id
 }

