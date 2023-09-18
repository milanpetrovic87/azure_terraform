# Create Virtual Network
resource "azurerm_virtual_network" "aksvnet" {
  name                = "aks-network"
  location            = var.location
  resource_group_name = azurerm_resource_group.rgmpetrovic.name
  address_space       = ["10.0.0.0/8"]
  depends_on          = [azurerm_resource_group.rgmpetrovic]
}

# Create a Subnet for AKS
resource "azurerm_subnet" "aks-default" {
  name                 = "aks-default-subnet"
  virtual_network_name = azurerm_virtual_network.aksvnet.name
  resource_group_name  = var.resourcegroup_name
  address_prefixes     = ["10.240.0.0/16"]
  depends_on           = [azurerm_resource_group.rgmpetrovic, azurerm_virtual_network.aksvnet]
}