mock_provider "azurerm" {}

run "setup_tests" {
  module {
    source = "./tests/setup-unit-tests"
  }
}

run "linux_storage_uses_managed_identity" {
  command = plan

  variables {
    app_name                   = run.setup_tests.app_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    app_service_plan_id        = run.setup_tests.app_service_plan_id
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    storage_account_id            = run.setup_tests.storage_account_id
    storage_uses_managed_identity = true
  }

  assert {
    condition     = azurerm_linux_function_app.this[0].storage_account_access_key == null
    error_message = "Storage account access key is not null"
  }

  assert {
    condition     = azurerm_linux_function_app.this[0].storage_uses_managed_identity == true
    error_message = "Storage not using managed identity"
  }

  assert {
    condition     = length(azurerm_role_assignment.this) == 1
    error_message = "Role assignment is not created at storage account"
  }
}

run "windows_storage_uses_managed_identity" {
  command = plan

  variables {
    app_name                   = run.setup_tests.app_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    kind                       = "Windows"
    app_service_plan_id        = run.setup_tests.app_service_plan_id
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    storage_account_id            = run.setup_tests.storage_account_id
    storage_uses_managed_identity = true
  }

  assert {
    condition     = azurerm_windows_function_app.this[0].storage_account_access_key == null
    error_message = "Storage account access key is not null"
  }

  assert {
    condition     = azurerm_windows_function_app.this[0].storage_uses_managed_identity == true
    error_message = "Storage not using managed identity"
  }

  assert {
    condition     = length(azurerm_role_assignment.this) == 1
    error_message = "Role assignment is not created at storage account"
  }
}

run "linux_storage_uses_managed_identity_false" {
  command = plan

  variables {
    app_name                   = run.setup_tests.app_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    app_service_plan_id        = run.setup_tests.app_service_plan_id
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    storage_account_id            = run.setup_tests.storage_account_id
    storage_uses_managed_identity = false
  }

  assert {
    condition     = azurerm_linux_function_app.this[0].storage_account_access_key == null
    error_message = "Storage account access key is not null"
  }

  assert {
    condition     = azurerm_linux_function_app.this[0].storage_uses_managed_identity == false
    error_message = "Storage uses managed identity when it should not"
  }

  assert {
    condition     = length(azurerm_role_assignment.this) == 0
    error_message = "Role assignment is created at storage account when it should not"
  }
}

run "windows_storage_uses_managed_identity_false" {
  command = plan

  variables {
    app_name                   = run.setup_tests.app_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    kind                       = "Windows"
    app_service_plan_id        = run.setup_tests.app_service_plan_id
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    storage_account_id            = run.setup_tests.storage_account_id
    storage_uses_managed_identity = false
  }

  assert {
    condition     = azurerm_windows_function_app.this[0].storage_account_access_key == null
    error_message = "Storage account access key is not null"
  }

  assert {
    condition     = azurerm_windows_function_app.this[0].storage_uses_managed_identity == false
    error_message = "Storage uses managed identity when it should not"
  }

  assert {
    condition     = length(azurerm_role_assignment.this) == 0
    error_message = "Role assignment is created at storage account when it should not"
  }
}

run "linux_storage_account_access_key" {
  command = plan

  variables {
    app_name                   = run.setup_tests.app_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    app_service_plan_id        = run.setup_tests.app_service_plan_id
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    storage_account_id            = run.setup_tests.storage_account_id
    storage_account_access_key    = run.setup_tests.storage_account_access_key
    storage_uses_managed_identity = false
  }

  assert {
    condition     = azurerm_linux_function_app.this[0].storage_account_access_key != null
    error_message = "Storage account access key is null"
  }

  assert {
    condition     = azurerm_linux_function_app.this[0].storage_uses_managed_identity == null
    error_message = "Storage uses managed identity when it should not"
  }

  assert {
    condition     = length(azurerm_role_assignment.this) == 0
    error_message = "Role assignment is created at storage account when it should not"
  }
}

run "windows_storage_account_access_key" {
  command = plan

  variables {
    app_name                   = run.setup_tests.app_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    kind                       = "Windows"
    app_service_plan_id        = run.setup_tests.app_service_plan_id
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    storage_account_id            = run.setup_tests.storage_account_id
    storage_account_access_key    = run.setup_tests.storage_account_access_key
    storage_uses_managed_identity = false
  }

  assert {
    condition     = azurerm_windows_function_app.this[0].storage_account_access_key != null
    error_message = "Storage account access key is null"
  }

  assert {
    condition     = azurerm_windows_function_app.this[0].storage_uses_managed_identity == null
    error_message = "Storage uses managed identity when it should not"
  }

  assert {
    condition     = length(azurerm_role_assignment.this) == 0
    error_message = "Role assignment is created at storage account when it should not"
  }
}
