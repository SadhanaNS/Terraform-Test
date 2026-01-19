provider "azurerm" {
  resource_provider_registrations = "none"
  subscription_id                 = "d7b7b790-dad8-4cbb-bc81-f19c99e4569a"
  features {}
}

resource "azurerm_storage_account" "demo-storage-account" {
  name                     = var.storage_account_name
  resource_group_name      = var.rgname
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

}
