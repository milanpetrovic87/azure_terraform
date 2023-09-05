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
  features {}
}

resource "azurerm_resource_group" "vnet_rg" {
  name     = var.resourcegroup_name
  location = var.location
  tags     = var.tags
}

resource "azurerm_virtual_network" "vnet" {
  name                     = var.vnet_name
  location                 = azurerm_resource_group.vnet_rg.location # da li ovde mogu da pozovem var.location? Mozda zato sto smo u variables.tf definisali samo koji je to tip variable...
  resource_group_name = azurerm_resource_group.vnet_rg.name     ### Zasto ovde ne mogu da pisem samo var.name?
  address_space       = var.vnet_address_space
  tags                     = var.tags

}

resource "azurerm_subnet" "subnet" {
  for_each             = var.subnets
  name                 = each.value["name"]
  resource_group_name  = azurerm_resource_group.vnet_rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = each.value["address_prefixes"]
}

resource "azurerm_public_ip" "bastion_public_ip" {
  name                = "${var.bastionhost_name}PubIP"
  resource_group_name = azurerm_resource_group.vnet_rg.name
  location            = azurerm_resource_group.vnet_rg.location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

resource "azurerm_bastion_host" "bastion_host" {
  name                = var.bastionhost_name
  location            = var.location
  resource_group_name = azurerm_resource_group.vnet_rg.name
  tags                = var.tags

  ip_configuration {
    name                 = "bastion_host_conf"
    subnet_id            = azurerm_subnet.subnet["bastion_subnet"].id
    public_ip_address_id = azurerm_public_ip.bastion_public_ip.id
  }
}


