resource "azurerm_service_plan" "this" {
  name                = var.app_service_plan_name
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = var.kind
  sku_name            = var.sku_name

  tags = var.tags
}

module "app" {
  source = "./modules/app"

  name                                   = var.app_name
  app_service_plan_id                    = azurerm_service_plan.this.id
  storage_account_name                   = var.storage_account_name
  resource_group_name                    = var.resource_group_name
  location                               = var.location
  log_analytics_workspace_id             = var.log_analytics_workspace_id
  kind                                   = var.kind
  application_insights_key               = var.application_insights_key
  application_insights_connection_string = var.application_insights_connection_string
  key_vault_reference_identity_id        = var.key_vault_reference_identity_id
  application_stack                      = var.application_stack
  identity                               = var.identity

  tags = var.tags
}
