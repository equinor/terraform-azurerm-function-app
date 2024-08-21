locals {
  is_windows   = var.kind == "Windows"
  function_app = local.is_windows ? azurerm_windows_function_app.this[0] : azurerm_linux_function_app.this[0]

  # TODO(@hknutsen): use provider function instead
  storage_account_name = split("/", var.storage_account_id)[8]

  # Auto assign Key Vault reference identity
  identity_ids = concat(compact([var.key_vault_reference_identity_id]), var.identity_ids)

  diagnostic_setting_metric_categories = ["AllMetrics"]

  dotnet_application_stack          = var.application_stack_dotnet_version != null ? [0] : []
  java_application_stack            = var.application_stack_java_version != null ? [0] : []
  node_application_stack            = var.application_stack_node_version != null ? [0] : []
  python_application_stack          = var.application_stack_python_version != null ? [0] : []
  powershell_core_application_stack = var.application_stack_powershell_core_version != null ? [0] : []
}

resource "azurerm_linux_function_app" "this" {
  count = local.is_windows ? 0 : 1

  name                = var.app_name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = var.app_service_plan_id

  storage_account_name          = local.storage_account_name
  storage_account_access_key    = null # Use managed identity instead
  storage_uses_managed_identity = true

  # Enforced by Equinor policy
  https_only = true

  # App settings should be configured during application deployment
  app_settings = null

  key_vault_reference_identity_id = var.key_vault_reference_identity_id

  virtual_network_subnet_id = var.virtual_network_subnet_id

  site_config {
    application_insights_key               = var.application_insights_key
    application_insights_connection_string = var.application_insights_connection_string
    vnet_route_all_enabled                 = var.vnet_route_all_enabled
    elastic_instance_minimum               = var.elastic_instance_minimum
    pre_warmed_instance_count              = var.pre_warmed_instance_count
    app_scale_limit                        = var.app_scale_limit
    use_32_bit_worker                      = var.use_32_bit_worker

    dynamic "application_stack" {
      for_each = local.dotnet_application_stack

      content {
        dotnet_version              = var.application_stack_dotnet_version
        use_dotnet_isolated_runtime = var.application_stack_use_dotnet_isolated_runtime
      }
    }

    dynamic "application_stack" {
      for_each = local.java_application_stack

      content {
        java_version = var.application_stack_java_version
      }
    }

    dynamic "application_stack" {
      for_each = local.node_application_stack

      content {
        node_version = var.application_stack_node_version
      }
    }

    dynamic "application_stack" {
      for_each = local.python_application_stack

      content {
        python_version = var.application_stack_python_version
      }
    }

    dynamic "application_stack" {
      for_each = local.powershell_core_application_stack

      content {
        powershell_core_version = var.application_stack_powershell_core_version
      }
    }
  }

  identity {
    type         = length(var.identity_ids) > 0 ? "SystemAssigned, UserAssigned" : "SystemAssigned"
    identity_ids = local.identity_ids
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

    # Precondition to verify only one or null application stacks are defined.
    # Multiple defined stacks creates a conflict.
    precondition {
      condition = length(compact([
        var.application_stack_dotnet_version,
        var.application_stack_java_version,
        var.application_stack_node_version,
        var.application_stack_python_version,
        var.application_stack_powershell_core_version
      ])) < 2

      error_message = "Multiple application stacks are defined. Number of application stacks defined can only be one or null."
    }
  }
}

resource "azurerm_windows_function_app" "this" {
  count = local.is_windows ? 1 : 0

  name                = var.app_name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = var.app_service_plan_id

  storage_account_name          = local.storage_account_name
  storage_account_access_key    = null # Use managed identity instead
  storage_uses_managed_identity = true

  # Enforced by Equinor policy
  https_only = true

  # App settings should be configured during application deployment
  app_settings = null

  key_vault_reference_identity_id = var.key_vault_reference_identity_id

  virtual_network_subnet_id = var.virtual_network_subnet_id

  site_config {
    application_insights_key               = var.application_insights_key
    application_insights_connection_string = var.application_insights_connection_string
    vnet_route_all_enabled                 = var.vnet_route_all_enabled
    elastic_instance_minimum               = var.elastic_instance_minimum
    pre_warmed_instance_count              = var.pre_warmed_instance_count
    app_scale_limit                        = var.app_scale_limit
    use_32_bit_worker                      = var.use_32_bit_worker

    dynamic "application_stack" {
      for_each = local.dotnet_application_stack

      content {
        dotnet_version              = var.application_stack_dotnet_version
        use_dotnet_isolated_runtime = var.application_stack_use_dotnet_isolated_runtime
      }
    }

    dynamic "application_stack" {
      for_each = local.java_application_stack

      content {
        java_version = var.application_stack_java_version
      }
    }

    dynamic "application_stack" {
      for_each = local.node_application_stack

      content {
        node_version = var.application_stack_node_version
      }
    }

    dynamic "application_stack" {
      for_each = local.powershell_core_application_stack

      content {
        powershell_core_version = var.application_stack_powershell_core_version
      }
    }
  }

  identity {
    type         = length(var.identity_ids) > 0 ? "SystemAssigned, UserAssigned" : "SystemAssigned"
    identity_ids = local.identity_ids
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

    # Precondition to verify only one or null application stacks are defined.
    # Multiple defined stacks creates a conflict.
    precondition {
      condition = length(compact([
        var.application_stack_dotnet_version,
        var.application_stack_java_version,
        var.application_stack_node_version,
        var.application_stack_powershell_core_version
      ])) < 2

      error_message = "Multiple application stacks are defined. Number of application stacks defined can only be one or null."
    }
  }
}

# Ref: https://github.com/Azure-Samples/functions-storage-managed-identity
resource "azurerm_role_assignment" "this" {
  scope                = var.storage_account_id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = local.function_app.identity[0].principal_id
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

  dynamic "metric" {
    for_each = toset(concat(local.diagnostic_setting_metric_categories, var.diagnostic_setting_enabled_metric_categories))

    content {
      # Azure expects explicit configuration of both enabled and disabled metric categories.
      category = metric.value
      enabled  = contains(var.diagnostic_setting_enabled_metric_categories, metric.value)
    }
  }
}
