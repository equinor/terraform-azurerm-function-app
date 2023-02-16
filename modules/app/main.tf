locals {
  is_windows   = var.kind == "Windows"
  function_app = local.is_windows ? azurerm_windows_function_app.this[0] : azurerm_linux_function_app.this[0]
}

resource "azurerm_storage_account" "this" {
  name                            = var.storage_account_name
  resource_group_name             = var.resource_group_name
  location                        = var.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  account_kind                    = "StorageV2"
  access_tier                     = "Hot"
  min_tls_version                 = "TLS1_2"
  enable_https_traffic_only       = true
  shared_access_key_enabled       = true
  allow_nested_items_to_be_public = false

  tags = var.tags
}

resource "azurerm_linux_function_app" "this" {
  count = local.is_windows ? 0 : 1

  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = var.app_service_plan_id

  storage_account_name       = azurerm_storage_account.this.name
  storage_account_access_key = azurerm_storage_account.this.primary_access_key

  # Enforced by Equinor policy
  https_only = true

  # App settings should be configured during application deployment
  app_settings = null

  key_vault_reference_identity_id = var.key_vault_reference_identity_id

  site_config {
    application_insights_key               = var.application_insights_key
    application_insights_connection_string = var.application_insights_connection_string

    dynamic "application_stack" {
      for_each = var.application_stack != null ? [var.application_stack] : []

      content {
        dotnet_version              = application_stack.value["dotnet_version"]
        use_dotnet_isolated_runtime = application_stack.value["use_dotnet_isolated_runtime"]
        java_version                = application_stack.value["java_version"]
        node_version                = application_stack.value["node_version"]
        python_version              = application_stack.value["python_version"]
        powershell_core_version     = application_stack.value["powershell_core_version"]
        use_custom_runtime          = application_stack.value["use_custom_runtime"]
      }
    }
  }

  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []

    content {
      type         = identity.value["type"]
      identity_ids = identity.value["identity_ids"]
    }
  }

  lifecycle {
    ignore_changes = [
      # Configure app settings during application deployment
      app_settings,

      # The following tags are managed by Azure
      tags["hidden-link: /app-insights-instrumentation-key"],
      tags["hidden-link: /app-insights-conn-string"],
      tags["hidden-link: /app-insights-resource-id"]
    ]
  }
}

resource "azurerm_windows_function_app" "this" {
  count = local.is_windows ? 1 : 0

  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = var.app_service_plan_id

  storage_account_name       = azurerm_storage_account.this.name
  storage_account_access_key = azurerm_storage_account.this.primary_access_key

  # Enforced by Equinor policy
  https_only = true

  # App settings should be configured during application deployment
  app_settings = null

  key_vault_reference_identity_id = var.key_vault_reference_identity_id

  site_config {
    application_insights_key               = var.application_insights_key
    application_insights_connection_string = var.application_insights_connection_string

    dynamic "application_stack" {
      for_each = var.application_stack != null ? [var.application_stack] : []

      content {
        dotnet_version              = application_stack.value["dotnet_version"]
        use_dotnet_isolated_runtime = application_stack.value["use_dotnet_isolated_runtime"]
        java_version                = application_stack.value["java_version"]
        node_version                = application_stack.value["node_version"]
        powershell_core_version     = application_stack.value["powershell_core_version"]
        use_custom_runtime          = application_stack.value["use_custom_runtime"]
      }
    }
  }

  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []

    content {
      type         = identity.value["type"]
      identity_ids = identity.value["identity_ids"]
    }
  }

  lifecycle {
    ignore_changes = [
      # Configure app settings during application deployment
      app_settings,

      # The following tags are managed by Azure
      tags["hidden-link: /app-insights-instrumentation-key"],
      tags["hidden-link: /app-insights-conn-string"],
      tags["hidden-link: /app-insights-resource-id"]
    ]
  }
}

resource "azurerm_monitor_diagnostic_setting" "this" {
  name                       = "audit-logs"
  target_resource_id         = local.function_app.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  enabled_log {
    category = "FunctionAppLogs"
  }

  metric {
    category = "AllMetrics"
    enabled  = true

    retention_policy {
      days    = 0
      enabled = false
    }
  }
}
