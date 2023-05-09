provider "azurerm" {
  features{}
}

data "azurerm_resource_group" "rg1" {
  name                = "ankushrg"
}

data "azurerm_network_security_group" "nsg" {
  name                = "nsg1"
  resource_group_name = data.azurerm_resource_group.rg1.name
}

resource "azurerm_network_security_rule" "inbound_rule" {
  name                        = "allow-internet"
  priority                    = 200
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = data.azurerm_resource_group.rg1.name
  network_security_group_name = data.azurerm_network_security_group.nsg.name
}

terraform {
  backend "azurerm" {
    resource_group_name  = "Storagerg"
    storage_account_name = "storageaccount5591"
    container_name       = "tfstate"
    key                  = "nsg.terraform.tfstate"
    access_key = "9DcT8nW/iKr0v2t8bfFIfM24sfJRGva1oD4macMbw6UkSwUXYHJr0ErQzgv15oErzQebT6lpi4zl+ASt2Lfeeg=="
  }
}