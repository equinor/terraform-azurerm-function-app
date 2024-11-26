mock_provider "azurerm" {}

run "setup_tests" {
  module {
    source = "./tests/setup-unit-tests"
  }
}

run "linux_app" {
  command = plan

  variables {
    app_name                   = run.setup_tests.app_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    app_service_plan_id        = run.setup_tests.app_service_plan_id
    storage_account_id         = run.setup_tests.storage_account_id
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id
  }

  assert {
    condition     = length(azurerm_linux_function_app.this) == 1
    error_message = "Linux Function App not created"
  }

  assert {
    condition     = length(azurerm_windows_function_app.this) == 0
    error_message = "Trying to create Windows Function App"
  }

  assert {
    condition     = azurerm_linux_function_app.this[0].ftp_publish_basic_authentication_enabled == false
    error_message = "Basic authentication enabled for the FTP client."
  }

  assert {
    condition     = azurerm_linux_function_app.this[0].webdeploy_publish_basic_authentication_enabled == false
    error_message = "Basic authentication enabled for the WebDeploy client."
  }

  assert {
    condition = azurerm_linux_function_app.this[0].client_certificate_mode == "Required"
    error_message = "Client certificate mode value is \"Optional\" or \"OptionalInteractiveUser\""
  }

  assert {
    condition = azurerm_linux_function_app.this[0].client_certificate_enabled == false
    error_message = "Client certificate enabled for Function App"
    
  assert {
    condition = azurerm_linux_function_app.this[0].builtin_logging_enabled == false
    error_message = "Built in logging enabled on the configured storage setting"
  }
}

run "windows_app" {
  command = plan

  variables {
    app_name                   = run.setup_tests.app_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    kind                       = "Windows"
    app_service_plan_id        = run.setup_tests.app_service_plan_id
    storage_account_id         = run.setup_tests.storage_account_id
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id
  }

  assert {
    condition     = length(azurerm_windows_function_app.this) == 1
    error_message = "Windows Function App not created"
  }

  assert {
    condition     = length(azurerm_linux_function_app.this) == 0
    error_message = "Trying to create Linux Function App"
  }

  assert {
    condition     = azurerm_windows_function_app.this[0].ftp_publish_basic_authentication_enabled == false
    error_message = "Basic authentication enabled for the FTP client."
  }

  assert {
    condition     = azurerm_windows_function_app.this[0].webdeploy_publish_basic_authentication_enabled == false
    error_message = "Basic authentication enabled for the WebDeploy client."
  }

  assert {
    condition = azurerm_windows_function_app.this[0].client_certificate_mode == "Required"
    error_message = "Client certificate mode value is \"Optional\" or \"OptionalInteractiveUser\""
  }

  assert {
    condition = azurerm_windows_function_app.this[0].client_certificate_enabled == false
    error_message = "Client certificate enabled for Function App"

  assert {  
    condition = azurerm_windows_function_app.this[0].builtin_logging_enabled == false
    error_message = "Built in logging enabled on the configured storage setting"
  }
}
