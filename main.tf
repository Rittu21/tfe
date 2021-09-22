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
      finops-owner = "mno"
      environment = "dev"
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
      finops-owner = "mno"
  }
}

resource "azurerm_network_interface" "example" {
  name                = "test-nic"
  location            = "EastUS"
  resource_group_name = "test-rg"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.networking.id
    private_ip_address_allocation = "Dynamic"
  }
   tags    = {
      component = "abc"
      product = "def"
      owner = "ghi"
      jiraproject = "jkl"
      finops-owner = "mno"
      environment = "dev"
  }
}

resource "azurerm_windows_virtual_machine" "example" {
  name                = "test-vm"
  resource_group_name = "test-rg"
  location            = "EastUS"
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.example.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}
