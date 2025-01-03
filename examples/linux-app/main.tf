provider "azurerm" {
  storage_use_azuread = true

  features {}
}

resource "random_id" "this" {
  byte_length = 8
}

module "log_analytics" {
  source  = "equinor/log-analytics/azurerm"
  version = "2.3.0"

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
  source  = "equinor/storage/azurerm"
  version = "12.9.1"

  account_name               = "st${random_id.this.hex}"
  resource_group_name        = var.resource_group_name
  location                   = var.location
  log_analytics_workspace_id = module.log_analytics.workspace_id

  # You can't use a network-secured Storage account when your Function App is hosted in an App Service plan with the "Y1" SKU.
  # Ref: https://learn.microsoft.com/en-us/azure/azure-functions/storage-considerations?tabs=azure-cli#storage-account-requirements
  network_rules_default_action = "Allow"
}

module "function_app" {
  source = "../.."

  app_name                   = "func-${random_id.this.hex}"
  resource_group_name        = var.resource_group_name
  location                   = var.location
  app_service_plan_id        = azurerm_service_plan.this.id
  storage_account_id         = module.storage.account_id
  log_analytics_workspace_id = module.log_analytics.workspace_id
}
