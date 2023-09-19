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
  source = "github.com/equinor/terraform-azurerm-log-analytics?ref=v1.5.0"

  workspace_name      = "log-${random_id.this.hex}"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
}

resource "azurerm_service_plan" "this" {
  name                = "plan-${random_id.this.hex}"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  os_type             = "Windows"
  sku_name            = "Y1"
}

module "storage" {
  source = "github.com/equinor/terraform-azurerm-storage?ref=v12.1.0"

  account_name                 = "st${random_id.this.hex}"
  resource_group_name          = azurerm_resource_group.this.name
  location                     = azurerm_resource_group.this.location
  log_analytics_workspace_id   = module.log_analytics.workspace_id
  shared_access_key_enabled    = true
  network_rules_default_action = "Allow"
}

module "function_app" {
  # source = "github.com/equinor/terraform-azurerm-function-app"
  source = "../.."

  app_name                   = "func-${random_id.this.hex}"
  resource_group_name        = azurerm_resource_group.this.name
  location                   = azurerm_resource_group.this.location
  app_service_plan_id        = azurerm_service_plan.this.id
  storage_account_name       = module.storage.account_name
  storage_account_key        = module.storage.primary_access_key
  log_analytics_workspace_id = module.log_analytics.workspace_id
  kind                       = "Windows"
}
