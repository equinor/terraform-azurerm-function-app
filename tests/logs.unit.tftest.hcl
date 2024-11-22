mock_provider "azurerm" {}

run "setup_tests" {
  module {
    source = "./tests/setup-unit-tests"
  }
}

run "linux_builtin_logging_disabled" {
  command = plan

  variables {
    app_name                   = run.setup_tests.app_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    app_service_plan_id        = run.setup_tests.app_service_plan_id
    storage_account_id         = run.setup_tests.storage_account_id
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    builtin_logging_enabled = false
  }

  assert {
    condition = azurerm_linux_function_app.this[0].builtin_logging_enabled == false
    error_message = "Built in logging enabled on the configured storage setting"
  }
}

run "linux_builtin_logging_enabled" {
  command = plan

  variables {
    app_name                   = run.setup_tests.app_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    app_service_plan_id        = run.setup_tests.app_service_plan_id
    storage_account_id         = run.setup_tests.storage_account_id
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    builtin_logging_enabled = true
  }

  assert {
    condition = azurerm_linux_function_app.this[0].builtin_logging_enabled == true
    error_message = "Built in logging disable on the configured storage setting"
  }
}

run "windows_builtin_logging_disabled" {
  command = plan

  variables {
    app_name                   = run.setup_tests.app_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    kind                       = "Windows"
    app_service_plan_id        = run.setup_tests.app_service_plan_id
    storage_account_id         = run.setup_tests.storage_account_id
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    builtin_logging_enabled = false
  }

  assert {
    condition = azurerm_linux_function_app.this[0].builtin_logging_enabled == false
    error_message = "Built in logging enabled on the configured storage setting"
  }
}

run "windows_builtin_logging_enabled" {
  command = plan

  variables {
    app_name                   = run.setup_tests.app_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    kind                       = "Windows"
    app_service_plan_id        = run.setup_tests.app_service_plan_id
    storage_account_id         = run.setup_tests.storage_account_id
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    builtin_logging_enabled = true
  }

  assert {
    condition = azurerm_linux_function_app.this[0].builtin_logging_enabled == true
    error_message = "Built in logging disable on the configured storage setting"
  }
}
