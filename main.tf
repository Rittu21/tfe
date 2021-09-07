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
