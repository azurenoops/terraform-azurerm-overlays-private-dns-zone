# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

 resource "azurerm_resource_group" "dns-network-rg" {
  name     = "dns-network-rg"
  location = var.location
  tags = {
    environment = "test"
  }
}

resource "azurerm_virtual_network" "dns-vnet" {
  depends_on = [
    azurerm_resource_group.dns-network-rg
  ]
  name                = "dns-network"
  location            = var.location
  resource_group_name = azurerm_resource_group.dns-network-rg.name
  address_space       = ["10.0.0.0/16"]
  tags = {
    environment = "test"
  }
}

resource "azurerm_subnet" "dns-snet" {
  depends_on = [
    azurerm_resource_group.dns-network-rg,
    azurerm_virtual_network.dns-vnet
  ]
  name                 = "dns-subnet"
  resource_group_name  = azurerm_resource_group.dns-network-rg.name
  virtual_network_name = azurerm_virtual_network.dns-vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}