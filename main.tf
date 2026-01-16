terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.1.0"
    }
  }
}
provider "azurerm" {
  resource_provider_registrations = "none" # This is only required when the User, Service Principal, or Identity running Terraform lacks the permissions to register Azure Resource Providers.
  features {}
  subscription_id = "d7b7b790-dad8-4cbb-bc81-f19c99e4569a"

}

resource "azurerm_resource_group" "demorg" {
  name     = var.rgname
  location = var.location
}

resource "azurerm_virtual_network" "demovnet" {
  resource_group_name = azurerm_resource_group.demorg.name
  location            = var.location
  name                = "demovnet"
  address_space       = ["10.16.0.0/16"]

  subnet {
    name             = "sub1"
    address_prefixes = ["10.16.1.0/24"]
  }

  subnet {
    name             = "sub2"
    address_prefixes = ["10.16.2.0/24"]

  }
}

data "azurerm_virtual_network" "demovnetdata" {
  name                = azurerm_virtual_network.demovnet.name
  resource_group_name = azurerm_resource_group.demorg.name
}

output "virtual_network_id" {
  value = data.azurerm_virtual_network.demovnetdata.id
}

