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
  subscription_id                 = "d7b7b790-dad8-4cbb-bc81-f19c99e4569a"
  features {

    virtual_machine {
      detach_implicit_data_disk_on_deletion = false
      delete_os_disk_on_deletion            = true
      graceful_shutdown                     = true
      skip_shutdown_and_force_delete        = false
    }
  }
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
}

resource "azurerm_subnet" "subnet1" {
  name                 = "subnet1"
  resource_group_name  = azurerm_resource_group.demorg.name
  virtual_network_name = azurerm_virtual_network.demovnet.name
  address_prefixes     = ["10.16.1.0/24"]
}

data "azurerm_virtual_network" "demovnetdata" {
  name                = azurerm_virtual_network.demovnet.name
  resource_group_name = azurerm_resource_group.demorg.name
}

output "virtual_network_id" {
  value = data.azurerm_virtual_network.demovnetdata.id
}

resource "azurerm_network_interface" "demonic" {
  name                = "demo-nic"
  location            = var.location
  resource_group_name = var.rgname
  ip_configuration {
    name                          = "demo-nic"
    subnet_id                     = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.publicIp.id
  }

}




resource "azurerm_public_ip" "publicIp" {
  name                = "Public-Ip"
  resource_group_name = azurerm_resource_group.demorg.name
  location            = var.location
  allocation_method   = "Static"
}

resource "azurerm_linux_virtual_machine" "demovm" {
  name                  = "linuxvm"
  resource_group_name   = azurerm_resource_group.demorg.name
  location              = var.location
  size                  = "Standard_D2s_v4"
  admin_username        = "adminuser"
  network_interface_ids = [azurerm_network_interface.demonic.id, ]


  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_ed25519.pub")
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

}

resource "azurerm_network_security_group" "Demonsg" {
  name                = "demo-nsg"
  location            = var.location
  resource_group_name = azurerm_resource_group.demorg.name

  security_rule {
    name                       = "Allow-SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"

  }
}

resource "azurerm_subnet_network_security_group_association" "example" {
  subnet_id                 = azurerm_subnet.subnet1.id
  network_security_group_id = azurerm_network_security_group.Demonsg.id
}
