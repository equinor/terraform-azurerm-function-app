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

run "linux_ftps_state_disabled" {
  command = plan

  variables {
    app_name                   = run.setup_tests.app_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    app_service_plan_id        = run.setup_tests.app_service_plan_id
    storage_account_id         = run.setup_tests.storage_account_id
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    ftps_state = "Disabled"
  }

  assert {
    condition = azurerm_linux_function_app.this[0].site_config[0].ftps_state == "Disabled"
    error_message = "FTPS state is \"AllAllowed\", or \"FtpsOnly\"."
  }
}

run "linux_ftps_state_ftpsonly" {
  command = plan

  variables {
    app_name                   = run.setup_tests.app_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    app_service_plan_id        = run.setup_tests.app_service_plan_id
    storage_account_id         = run.setup_tests.storage_account_id
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    ftps_state = "FtpsOnly"
  }

  assert {
    condition = azurerm_linux_function_app.this[0].site_config[0].ftps_state == "FtpsOnly"
    error_message = "FTPS state is \"AllAllowed\", or \"Disabled\"."
  }
}

run "linux_ftps_state_allallowed" {
  command = plan

  variables {
    app_name                   = run.setup_tests.app_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    app_service_plan_id        = run.setup_tests.app_service_plan_id
    storage_account_id         = run.setup_tests.storage_account_id
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    ftps_state = "AllAllowed"
  }

  assert {
    condition = azurerm_linux_function_app.this[0].site_config[0].ftps_state == "AllAllowed"
    error_message = "FTPS state is \"FtpsOnly\", or \"Disabled\"."
  }
}

run "windows_ftps_state_disabled" {
  command = plan

  variables {
    app_name                   = run.setup_tests.app_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    kind                       = "Windows"
    app_service_plan_id        = run.setup_tests.app_service_plan_id
    storage_account_id         = run.setup_tests.storage_account_id
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    ftps_state = "Disabled"
  }

  assert {
    condition = azurerm_windows_function_app.this[0].site_config[0].ftps_state == "Disabled"
    error_message = "FTPS state is \"AllAllowed\", or \"FtpsOnly\"."
  }
}

run "windows_ftps_state_ftpsonly" {
  command = plan

  variables {
    app_name                   = run.setup_tests.app_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    kind                       = "Windows"
    app_service_plan_id        = run.setup_tests.app_service_plan_id
    storage_account_id         = run.setup_tests.storage_account_id
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    ftps_state = "FtpsOnly"
  }

  assert {
    condition = azurerm_windows_function_app.this[0].site_config[0].ftps_state == "FtpsOnly"
    error_message = "FTPS state is \"AllAllowed\", or \"Disabled\"."
  }
}

run "windows_ftps_state_allallowed" {
  command = plan

  variables {
    app_name                   = run.setup_tests.app_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    kind                       = "Windows"
    app_service_plan_id        = run.setup_tests.app_service_plan_id
    storage_account_id         = run.setup_tests.storage_account_id
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    ftps_state = "AllAllowed"
  }

  assert {
    condition = azurerm_windows_function_app.this[0].site_config[0].ftps_state == "AllAllowed"
    error_message = "FTPS state is \"FtpsOnly\", or \"Disabled\"."
  }
}