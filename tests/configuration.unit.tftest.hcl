mock_provider "azurerm" {}

run "setup_tests" {
  module {
    source = "./tests/setup-unit-tests"
  }
}

run "linux_basic_authentication_disabled" {
  command = plan

  variables {
    app_name                   = run.setup_tests.app_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    app_service_plan_id        = run.setup_tests.app_service_plan_id
    storage_account_id         = run.setup_tests.storage_account_id
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    ftp_publish_basic_authentication_enabled       = false
    webdeploy_publish_basic_authentication_enabled = false
  }

  assert {
    condition     = azurerm_linux_function_app.this[0].ftp_publish_basic_authentication_enabled == false
    error_message = "Basic authentication enabled for the FTP client."
  }

  assert {
    condition     = azurerm_linux_function_app.this[0].webdeploy_publish_basic_authentication_enabled == false
    error_message = "Basic authentication enabled for the WebDeploy client."
  }
}

run "linux_basic_authentication_enabled" {
  command = plan

  variables {
    app_name                   = run.setup_tests.app_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    app_service_plan_id        = run.setup_tests.app_service_plan_id
    storage_account_id         = run.setup_tests.storage_account_id
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    ftp_publish_basic_authentication_enabled       = true
    webdeploy_publish_basic_authentication_enabled = true
  }

  assert {
    condition     = azurerm_linux_function_app.this[0].ftp_publish_basic_authentication_enabled == true
    error_message = "Basic authentication disabled for the FTP client."
  }

  assert {
    condition     = azurerm_linux_function_app.this[0].webdeploy_publish_basic_authentication_enabled == true
    error_message = "Basic authentication disabled for the WebDeploy client."
  }
}

run "linux_http2_disabled" {
  command = plan

  variables {
    app_name                   = run.setup_tests.app_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    app_service_plan_id        = run.setup_tests.app_service_plan_id
    storage_account_id         = run.setup_tests.storage_account_id
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    http2_enabled = false
  }

    assert {
    condition = azurerm_linux_function_app.this[0].site_config[0].http2_enabled == false
    error_message = "HTTP2 protocol enabled"
  }
}

run "linux_http2_enabled" {
  command = plan

  variables {
    app_name                   = run.setup_tests.app_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    app_service_plan_id        = run.setup_tests.app_service_plan_id
    storage_account_id         = run.setup_tests.storage_account_id
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    http2_enabled = true
  }

    assert {
    condition = azurerm_linux_function_app.this[0].site_config[0].http2_enabled == true
    error_message = "HTTP2 protocol disabled"
  }
}

run "windows_basic_authentication_disabled" {
  command = plan

  variables {
    app_name                   = run.setup_tests.app_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    kind                       = "Windows"
    app_service_plan_id        = run.setup_tests.app_service_plan_id
    storage_account_id         = run.setup_tests.storage_account_id
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    ftp_publish_basic_authentication_enabled       = false
    webdeploy_publish_basic_authentication_enabled = false
  }

  assert {
    condition     = azurerm_windows_function_app.this[0].ftp_publish_basic_authentication_enabled == false
    error_message = "Basic authentication enabled for the FTP client."
  }

  assert {
    condition     = azurerm_windows_function_app.this[0].webdeploy_publish_basic_authentication_enabled == false
    error_message = "Basic authentication enabled for the WebDeploy client."
  }
}

run "windows_basic_authentication_enabled" {
  command = plan

  variables {
    app_name                   = run.setup_tests.app_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    kind                       = "Windows"
    app_service_plan_id        = run.setup_tests.app_service_plan_id
    storage_account_id         = run.setup_tests.storage_account_id
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    ftp_publish_basic_authentication_enabled       = true
    webdeploy_publish_basic_authentication_enabled = true
  }

  assert {
    condition     = azurerm_windows_function_app.this[0].ftp_publish_basic_authentication_enabled == true
    error_message = "Basic authentication disabled for the FTP client."
  }

  assert {
    condition     = azurerm_windows_function_app.this[0].webdeploy_publish_basic_authentication_enabled == true
    error_message = "Basic authentication disabled for the WebDeploy client."
  }
}

run "windows_http2_disabled" {
  command = plan

  variables {
    app_name                   = run.setup_tests.app_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    kind                       = "Windows"
    app_service_plan_id        = run.setup_tests.app_service_plan_id
    storage_account_id         = run.setup_tests.storage_account_id
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    http2_enabled = false
  }

    assert {
    condition = azurerm_windows_function_app.this[0].site_config[0].http2_enabled == false
    error_message = "HTTP2 protocol enabled"
  }
}

run "windows_http2_enabled" {
  command = plan

  variables {
    app_name                   = run.setup_tests.app_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    kind                       = "Windows"
    app_service_plan_id        = run.setup_tests.app_service_plan_id
    storage_account_id         = run.setup_tests.storage_account_id
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    http2_enabled = true
  }

    assert {
    condition = azurerm_windows_function_app.this[0].site_config[0].http2_enabled == true
    error_message = "HTTP2 protocol disabled"
  }
}
