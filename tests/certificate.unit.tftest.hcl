mock_provider "azurerm" {}

run "setup_tests" {
  module {
    source = "./tests/setup-unit-tests"
  }
}

run "linux_client_certificate_mode_optional" {
  command = plan

  variables {
    app_name                   = run.setup_tests.app_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    app_service_plan_id        = run.setup_tests.app_service_plan_id
    storage_account_id         = run.setup_tests.storage_account_id
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    client_certificate_mode = "Optional"
  }

  assert {
    condition = azurerm_linux_function_app.this[0].client_certificate_mode == "Optional"
    error_message = "The Client certificate mode is on \"Required\" or \"OptionalInteractiveUser\""
  }
}

run "linux_client_certificate_mode_optional_interactive_user" {
  command = plan

  variables {
    app_name                   = run.setup_tests.app_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    app_service_plan_id        = run.setup_tests.app_service_plan_id
    storage_account_id         = run.setup_tests.storage_account_id
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    client_certificate_mode = "OptionalInteractiveUser"
  }

  assert {
    condition = azurerm_linux_function_app.this[0].client_certificate_mode == "OptionalInteractiveUser"
    error_message = "The Client certificate mode is on \"Optional\" or \"Required\""
  }
}

run "linux_client_certificate_mode_required" {
  command = plan

  variables {
    app_name                   = run.setup_tests.app_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    app_service_plan_id        = run.setup_tests.app_service_plan_id
    storage_account_id         = run.setup_tests.storage_account_id
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    client_certificate_mode = "Required"
  }

  assert {
    condition = azurerm_linux_function_app.this[0].client_certificate_mode == "Required"
    error_message = "The Client certificate mode is on \"Optional\" or \"OptionalInteractiveUser\""
  }
}

run "linux_client_certificate_disabled" {
  command = plan

  variables {
    app_name                   = run.setup_tests.app_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    app_service_plan_id        = run.setup_tests.app_service_plan_id
    storage_account_id         = run.setup_tests.storage_account_id
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    client_certificate_enabled = false
  }

  assert {
    condition = azurerm_linux_function_app.this[0].client_certificate_enabled == false
    error_message = "Client certificate enabled for Function App"
  }
}

run "linux_client_certificate_enabled" {
  command = plan

  variables {
    app_name                   = run.setup_tests.app_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    app_service_plan_id        = run.setup_tests.app_service_plan_id
    storage_account_id         = run.setup_tests.storage_account_id
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    client_certificate_enabled = true
  }

  assert {
    condition = azurerm_linux_function_app.this[0].client_certificate_enabled == true
    error_message = "Client certificate disabled for Function App"
  }
}

run "windows_client_certificate_mode_optional" {
  command = plan

  variables {
    app_name                   = run.setup_tests.app_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    kind                       = "Windows"
    app_service_plan_id        = run.setup_tests.app_service_plan_id
    storage_account_id         = run.setup_tests.storage_account_id
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    client_certificate_mode = "Optional"
  }

  assert {
    condition = azurerm_windows_function_app.this[0].client_certificate_mode == "Optional"
    error_message = "The Client certificate mode is on \"OptionalInteractiveUser\" or \"Required\""
  }
}

run "windows_client_certificate_mode_optional_interactive_user" {
  command = plan

  variables {
    app_name                   = run.setup_tests.app_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    app_service_plan_id        = run.setup_tests.app_service_plan_id
    storage_account_id         = run.setup_tests.storage_account_id
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    client_certificate_mode = "OptionalInteractiveUser"
  }

  assert {
    condition = azurerm_linux_function_app.this[0].client_certificate_mode == "OptionalInteractiveUser"
    error_message = "The Client certificate mode is on \"Optional\" or \"Required\""
  }
}

run "windows_client_certificate_mode_required" {
  command = plan

  variables {
    app_name                   = run.setup_tests.app_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    kind                       = "Windows"
    app_service_plan_id        = run.setup_tests.app_service_plan_id
    storage_account_id         = run.setup_tests.storage_account_id
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    client_certificate_mode = "Required"
  }

  assert {
    condition = azurerm_windows_function_app.this[0].client_certificate_mode == "Required"
    error_message = "The Client certificate mode is on \"Optional\" or \"OptionalInteractiveUser\""
  }
}

run "windows_client_certificate_disabled" {
  command = plan

  variables {
    app_name                   = run.setup_tests.app_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    app_service_plan_id        = run.setup_tests.app_service_plan_id
    storage_account_id         = run.setup_tests.storage_account_id
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    client_certificate_enabled = false
  }

  assert {
    condition = azurerm_linux_function_app.this[0].client_certificate_enabled == false
    error_message = "Client certificate enabled for Function App"
  }
}

run "windows_client_certificate_enabled" {
  command = plan

  variables {
    app_name                   = run.setup_tests.app_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    app_service_plan_id        = run.setup_tests.app_service_plan_id
    storage_account_id         = run.setup_tests.storage_account_id
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    client_certificate_enabled = true
  }

  assert {
    condition = azurerm_linux_function_app.this[0].client_certificate_enabled == true
    error_message = "Client certificate disable for Web App"
  }
}
