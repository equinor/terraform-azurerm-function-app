locals {
  is_windows   = var.kind == "Windows"
  function_app = local.is_windows ? azurerm_windows_function_app.this[0] : azurerm_linux_function_app.this[0]

  # If system_assigned_identity_enabled is true, value is "SystemAssigned".
  # If identity_ids is non-empty, value is "UserAssigned".
  # If system_assigned_identity_enabled is true and identity_ids is non-empty, value is "SystemAssigned, UserAssigned".
  identity_type = join(", ", compact([var.system_assigned_identity_enabled ? "SystemAssigned" : "", length(var.identity_ids) > 0 ? "UserAssigned" : ""]))
}

resource "azurerm_linux_function_app" "this" {
  count = local.is_windows ? 0 : 1

  name                = var.app_name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = var.app_service_plan_id

  storage_account_name       = var.storage_account_name
  storage_account_access_key = var.storage_account_key

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
    for_each = local.identity_type != "" ? [1] : []

    content {
      type         = local.identity_type
      identity_ids = var.identity_ids
    }
  }

  tags = var.tags

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

  name                = var.app_name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = var.app_service_plan_id

  storage_account_name       = var.storage_account_name
  storage_account_access_key = var.storage_account_key

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
    for_each = local.identity_type != "" ? [1] : []

    content {
      type         = local.identity_type
      identity_ids = var.identity_ids
    }
  }

  tags = var.tags

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
  name                       = var.diagnostic_setting_name
  target_resource_id         = local.function_app.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  # Ref: https://registry.terraform.io/providers/hashicorp/azurerm/3.65.0/docs/resources/monitor_diagnostic_setting#log_analytics_destination_type
  log_analytics_destination_type = null

  dynamic "enabled_log" {
    for_each = toset(var.diagnostic_setting_enabled_log_categories)

    content {
      category = enabled_log.value
    }
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
