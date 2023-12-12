provider "azurerm" {
  features {}
}

resource "random_id" "this" {
  byte_length = 8
}

module "log_analytics" {
  source = "github.com/equinor/terraform-azurerm-log-analytics?ref=v1.5.0"

  workspace_name      = "log-${random_id.this.hex}"
  resource_group_name = var.resource_group_name
  location            = var.location
}

resource "azurerm_service_plan" "this" {
  name                = "plan-${random_id.this.hex}"
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = "Linux"
  sku_name            = "Y1"
}

module "storage" {
  source = "github.com/equinor/terraform-azurerm-storage?ref=v12.1.0"

  account_name                 = "st${random_id.this.hex}"
  resource_group_name          = var.resource_group_name
  location                     = var.location
  log_analytics_workspace_id   = module.log_analytics.workspace_id
  account_replication_type     = "LRS"
  shared_access_key_enabled    = true
  network_rules_default_action = "Allow"
}

module "function_app" {
  # source = "github.com/equinor/terraform-azurerm-function-app"
  source = "../.."

  app_name                   = "func-${random_id.this.hex}"
  resource_group_name        = var.resource_group_name
  location                   = var.location
  app_service_plan_id        = azurerm_service_plan.this.id
  storage_account_name       = module.storage.account_name
  storage_account_key        = module.storage.primary_access_key
  log_analytics_workspace_id = module.log_analytics.workspace_id
}
