provider "azurerm" {

  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "test-rg"
  location = "EastUS"
  tags    = {
      component = "abc"
      product = "def"
      owner = "ghi"
      jiraproject = "jkl"
  }
}

resource "azurerm_virtual_network" "networking" {
  resource_group_name = "test-rg"
  location            = "EastUS"
  name                = "testing-vnet"
  address_space       = ["10.0.0.0/16"]
  tags    = {
      component = "abc"
      product = "def"
      owner = "ghi"
      jiraproject = "jkl"
      finops-owner = "mno"
      environment = "dev"
      
  }
}

resource "azurerm_subnet" "networking" {
  resource_group_name  = "test-rg"
  virtual_network_name = "testing-vnet"
  name                 = "testing-subnet"
  address_prefixes     = ["10.0.1.0/24"]
  depends_on = [azurerm_virtual_network.networking]
}

resource "azurerm_network_security_group" "networking" {
  resource_group_name = "test-rg"
  location            = "EastUS"
  name                = "test-nsg"
  tags    = {
      component = "abc"
      product = "def"
      owner = "ghi"
      jiraproject = "jkl"
      environment = "development"
  }
}
