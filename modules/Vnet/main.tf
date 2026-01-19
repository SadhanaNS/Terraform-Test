provider "azurerm" {
  resource_provider_registrations = "none"
  subscription_id                 = "d7b7b790-dad8-4cbb-bc81-f19c99e4569a"
  features {}
}

resource "azurerm_virtual_network" "demo-vnet" {
  name                = var.vnet_name
  resource_group_name = var.rgname
  location            = var.location
  address_space       = var.address_space
}
