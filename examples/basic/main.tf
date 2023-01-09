provider "azurerm" {
  features {}
}

resource "random_id" "this" {
  byte_length = 8
}

resource "azurerm_resource_group" "this" {
  name     = "rg-${random_id.this.hex}"
  location = var.location
}

module "foobar" {
  # source = "github.com/equinor/terraform-azurerm-foobar?ref=v0.0.0"
  source = "../.."

  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
}
