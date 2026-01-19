provider "azurerm" {
  features {}
  subscription_id = "d7b7b790-dad8-4cbb-bc81-f19c99e4569a"
}

resource "azurerm_resource_group" "prod-rg" {
  name     = "prod-rg"
  location = "West Europe"
}
module "prod-blob-storage" {
  source               = "../../modules/storage"
  rgname               = "prod-rg"
  location             = "West Europe"
  storage_account_name = "prodstorageaccount788690"
}
