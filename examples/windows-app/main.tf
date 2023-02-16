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

module "log_analytics" {
  source = "github.com/equinor/terraform-azurerm-log-analytics?ref=v1.3.1"

  workspace_name      = "log-${random_id.this.hex}"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
}


module "function_app" {
  # source = "github.com/equinor/terraform-azurerm-function-app"
  source = "../.."

  app_name                   = "func-${random_id.this.hex}"
  app_service_plan_name      = "plan-func-${random_id.this.hex}"
  storage_account_name       = "stfunc${random_id.this.hex}"
  resource_group_name        = azurerm_resource_group.this.name
  location                   = azurerm_resource_group.this.location
  log_analytics_workspace_id = module.log_analytics.workspace_id
  kind                       = "Windows"
}
