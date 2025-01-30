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
    condition     = azurerm_linux_function_app.this[0].site_config[0].ftps_state == "Disabled"
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
    condition     = azurerm_linux_function_app.this[0].site_config[0].ftps_state == "FtpsOnly"
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
    condition     = azurerm_linux_function_app.this[0].site_config[0].ftps_state == "AllAllowed"
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
    condition     = azurerm_windows_function_app.this[0].site_config[0].ftps_state == "Disabled"
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
    condition     = azurerm_windows_function_app.this[0].site_config[0].ftps_state == "FtpsOnly"
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
    condition     = azurerm_windows_function_app.this[0].site_config[0].ftps_state == "AllAllowed"
    error_message = "FTPS state is \"FtpsOnly\", or \"Disabled\"."
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
    condition     = azurerm_linux_function_app.this[0].site_config[0].http2_enabled == false
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
    condition     = azurerm_linux_function_app.this[0].site_config[0].http2_enabled == true
    error_message = "HTTP2 protocol disabled"
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
    condition     = azurerm_windows_function_app.this[0].site_config[0].http2_enabled == false
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
    condition     = azurerm_windows_function_app.this[0].site_config[0].http2_enabled == true
    error_message = "HTTP2 protocol disabled"
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
    condition     = azurerm_linux_function_app.this[0].client_certificate_mode == "Optional"
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
    condition     = azurerm_linux_function_app.this[0].client_certificate_mode == "OptionalInteractiveUser"
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
    condition     = azurerm_linux_function_app.this[0].client_certificate_mode == "Required"
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
    condition     = azurerm_linux_function_app.this[0].client_certificate_enabled == false
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
    condition     = azurerm_linux_function_app.this[0].client_certificate_enabled == true
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
    condition     = azurerm_windows_function_app.this[0].client_certificate_mode == "Optional"
    error_message = "The Client certificate mode is on \"OptionalInteractiveUser\" or \"Required\""
  }
}

run "windows_client_certificate_mode_optional_interactive_user" {
  command = plan

  variables {
    app_name                   = run.setup_tests.app_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    kind                       = "Windows"
    app_service_plan_id        = run.setup_tests.app_service_plan_id
    storage_account_id         = run.setup_tests.storage_account_id
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    client_certificate_mode = "OptionalInteractiveUser"
  }

  assert {
    condition     = azurerm_windows_function_app.this[0].client_certificate_mode == "OptionalInteractiveUser"
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
    condition     = azurerm_windows_function_app.this[0].client_certificate_mode == "Required"
    error_message = "The Client certificate mode is on \"Optional\" or \"OptionalInteractiveUser\""
  }
}

run "windows_client_certificate_disabled" {
  command = plan

  variables {
    app_name                   = run.setup_tests.app_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    kind                       = "Windows"
    app_service_plan_id        = run.setup_tests.app_service_plan_id
    storage_account_id         = run.setup_tests.storage_account_id
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    client_certificate_enabled = false
  }

  assert {
    condition     = azurerm_windows_function_app.this[0].client_certificate_enabled == false
    error_message = "Client certificate enabled for Function App"
  }
}

run "windows_client_certificate_enabled" {
  command = plan

  variables {
    app_name                   = run.setup_tests.app_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    kind                       = "Windows"
    app_service_plan_id        = run.setup_tests.app_service_plan_id
    storage_account_id         = run.setup_tests.storage_account_id
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    client_certificate_enabled = true
  }

  assert {
    condition     = azurerm_windows_function_app.this[0].client_certificate_enabled == true
    error_message = "Client certificate disable for Function App"
  }
}

run "linux_sticky_settings_empty" {
  command = plan

  variables {
    app_name                   = run.setup_tests.app_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    app_service_plan_id        = run.setup_tests.app_service_plan_id
    storage_account_id         = run.setup_tests.storage_account_id
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    sticky_settings_app_setting_names = []
    sticky_settings_connection_string_names = []
  }
}

run "linux_sticky_settings_filled" {
  command = plan

  variables {
    app_name                   = run.setup_tests.app_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    app_service_plan_id        = run.setup_tests.app_service_plan_id
    storage_account_id         = run.setup_tests.storage_account_id
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    sticky_settings_app_setting_names = [
      "APPINSIGHTS_INSTRUMENTATIONKEY",
      "APPLICATIONINSIGHTS_CONNECTION_STRING ",
      "APPINSIGHTS_PROFILERFEATURE_VERSION",
      "APPINSIGHTS_SNAPSHOTFEATURE_VERSION",
      "ApplicationInsightsAgent_EXTENSION_VERSION",
      "XDT_MicrosoftApplicationInsights_BaseExtensions",
      "DiagnosticServices_EXTENSION_VERSION",
      "InstrumentationEngine_EXTENSION_VERSION",
      "SnapshotDebugger_EXTENSION_VERSION",
      "XDT_MicrosoftApplicationInsights_Mode",
      "XDT_MicrosoftApplicationInsights_PreemptSdk",
      "APPLICATIONINSIGHTS_CONFIGURATION_CONTENT",
      "XDT_MicrosoftApplicationInsightsJava",
      "XDT_MicrosoftApplicationInsights_NodeJS",
    ]
    sticky_settings_connection_string_names = ["connection strings"]
  }
}

run "linux_sticky_settings_app_setting_names_filled" {
  command = plan

  variables {
    app_name                   = run.setup_tests.app_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    app_service_plan_id        = run.setup_tests.app_service_plan_id
    storage_account_id         = run.setup_tests.storage_account_id
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    sticky_settings_app_setting_names = [
      "APPINSIGHTS_INSTRUMENTATIONKEY",
      "APPLICATIONINSIGHTS_CONNECTION_STRING ",
      "APPINSIGHTS_PROFILERFEATURE_VERSION",
      "APPINSIGHTS_SNAPSHOTFEATURE_VERSION",
      "ApplicationInsightsAgent_EXTENSION_VERSION",
      "XDT_MicrosoftApplicationInsights_BaseExtensions",
      "DiagnosticServices_EXTENSION_VERSION",
      "InstrumentationEngine_EXTENSION_VERSION",
      "SnapshotDebugger_EXTENSION_VERSION",
      "XDT_MicrosoftApplicationInsights_Mode",
      "XDT_MicrosoftApplicationInsights_PreemptSdk",
      "APPLICATIONINSIGHTS_CONFIGURATION_CONTENT",
      "XDT_MicrosoftApplicationInsightsJava",
      "XDT_MicrosoftApplicationInsights_NodeJS",
    ]
    sticky_settings_connection_string_names = []
  }
}

run "linux_sticky_settings_connection_string_names_filled" {
  command = plan

  variables {
    app_name                   = run.setup_tests.app_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    app_service_plan_id        = run.setup_tests.app_service_plan_id
    storage_account_id         = run.setup_tests.storage_account_id
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    sticky_settings_app_setting_names = []
    sticky_settings_connection_string_names = ["connection strings"]
  }
}

run "windows_sticky_settings_empty" {
  command = plan

  variables {
    app_name                   = run.setup_tests.app_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    kind                       = "Windows"
    app_service_plan_id        = run.setup_tests.app_service_plan_id
    storage_account_id         = run.setup_tests.storage_account_id
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    sticky_settings_app_setting_names = []
    sticky_settings_connection_string_names = []
  }
}

run "windows_sticky_settings_filled" {
  command = plan

  variables {
    app_name                   = run.setup_tests.app_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    kind                       = "Windows"
    app_service_plan_id        = run.setup_tests.app_service_plan_id
    storage_account_id         = run.setup_tests.storage_account_id
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    sticky_settings_app_setting_names = [
      "APPINSIGHTS_INSTRUMENTATIONKEY",
      "APPLICATIONINSIGHTS_CONNECTION_STRING ",
      "APPINSIGHTS_PROFILERFEATURE_VERSION",
      "APPINSIGHTS_SNAPSHOTFEATURE_VERSION",
      "ApplicationInsightsAgent_EXTENSION_VERSION",
      "XDT_MicrosoftApplicationInsights_BaseExtensions",
      "DiagnosticServices_EXTENSION_VERSION",
      "InstrumentationEngine_EXTENSION_VERSION",
      "SnapshotDebugger_EXTENSION_VERSION",
      "XDT_MicrosoftApplicationInsights_Mode",
      "XDT_MicrosoftApplicationInsights_PreemptSdk",
      "APPLICATIONINSIGHTS_CONFIGURATION_CONTENT",
      "XDT_MicrosoftApplicationInsightsJava",
      "XDT_MicrosoftApplicationInsights_NodeJS",
    ]
    sticky_settings_connection_string_names = ["connection strings"]
  }
}

run "windows_sticky_settings_app_setting_names_filled" {
  command = plan

  variables {
    app_name                   = run.setup_tests.app_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    kind                       = "Windows"
    app_service_plan_id        = run.setup_tests.app_service_plan_id
    storage_account_id         = run.setup_tests.storage_account_id
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    sticky_settings_app_setting_names = [
      "APPINSIGHTS_INSTRUMENTATIONKEY",
      "APPLICATIONINSIGHTS_CONNECTION_STRING ",
      "APPINSIGHTS_PROFILERFEATURE_VERSION",
      "APPINSIGHTS_SNAPSHOTFEATURE_VERSION",
      "ApplicationInsightsAgent_EXTENSION_VERSION",
      "XDT_MicrosoftApplicationInsights_BaseExtensions",
      "DiagnosticServices_EXTENSION_VERSION",
      "InstrumentationEngine_EXTENSION_VERSION",
      "SnapshotDebugger_EXTENSION_VERSION",
      "XDT_MicrosoftApplicationInsights_Mode",
      "XDT_MicrosoftApplicationInsights_PreemptSdk",
      "APPLICATIONINSIGHTS_CONFIGURATION_CONTENT",
      "XDT_MicrosoftApplicationInsightsJava",
      "XDT_MicrosoftApplicationInsights_NodeJS",
    ]
    sticky_settings_connection_string_names = []
  }
}

run "windows_sticky_settings_connection_string_names_filled" {
  command = plan

  variables {
    app_name                   = run.setup_tests.app_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    kind                       = "Windows"
    app_service_plan_id        = run.setup_tests.app_service_plan_id
    storage_account_id         = run.setup_tests.storage_account_id
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    sticky_settings_app_setting_names = []
    sticky_settings_connection_string_names = ["connection strings"]
  }
}