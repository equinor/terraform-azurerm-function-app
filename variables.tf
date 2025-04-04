variable "app_name" {
  description = "The name of this Function App."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group to create the resources in."
  type        = string
}

variable "location" {
  description = "The location to create the resources in."
  type        = string
}

variable "app_service_plan_id" {
  description = "The ID of the App Service plan to host this Function App on."
  type        = string
}

variable "storage_account_id" {
  description = "The ID of the Storage account to connect to this Function App."
  type        = string
}

variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics workspace to send diagnostic to."
  type        = string
}

variable "app_settings" {
  description = "A map of app settings to be configured for this Function App."
  type        = map(string)
  default     = {}
  nullable    = false

  validation {
    condition     = length(setintersection(["AzureWebJobsDashboard__accountName", "AzureWebJobsStorage", "AzureWebJobsStorage__accountName"], keys(var.app_settings))) == 0
    error_message = "Storage account must be configured using the \"storage_account_id\" variable."
  }

  validation {
    condition     = length(setintersection(["FUNCTIONS_EXTENSION_VERSION"], keys(var.app_settings))) == 0
    error_message = "Functions extension version must be configured using the \"functions_extension_version\" variable."
  }

  validation {
    condition     = length(setintersection(["APPLICATIONINSIGHTS_CONNECTION_STRING", "APPINSIGHTS_INSTRUMENTATIONKEY"], keys(var.app_settings))) == 0
    error_message = "Application insights must be configured using the \"application_insights_connection_string\" variable."
  }
}

variable "sticky_settings_app_setting_names" {
  description = "A list of names of app settings that this Function App will not swap between slots when a swap operation is triggered."
  type        = list(string)
  default     = []
}

variable "sticky_settings_connection_string_names" {
  description = "A list of names of connection strings that this Function App will not swap between slots when a swap operation is triggered."
  type        = list(string)
  default     = []
}

variable "functions_extension_version" {
  description = "Which extension version to use for this Function App."
  type        = string
  default     = "~4"
  nullable    = false
}

variable "diagnostic_setting_name" {
  description = "The name of this diagnostic setting."
  type        = string
  default     = "audit-logs"
}

variable "diagnostic_setting_enabled_log_categories" {
  description = "A list of log categories to be enabled for this diagnostic setting."
  type        = list(string)
  default     = ["FunctionAppLogs"]
}

variable "diagnostic_setting_enabled_metric_categories" {
  description = "A list of metric categories to be enabled for this diagnostic setting."
  type        = list(string)
  default     = []
}

variable "kind" {
  description = "The kind of Function App to create. Allowed values are \"Linux\" and \"Windows\"."
  type        = string
  default     = "Linux"

  validation {
    condition     = contains(["Linux", "Windows"], var.kind)
    error_message = "Kind must be \"Linux\" or \"Windows\"."
  }
}

# Ref: https://learn.microsoft.com/en-us/azure/azure-monitor/app/migrate-from-instrumentation-keys-to-connection-strings
variable "application_insights_key" {
  description = "The instrumentation key of the Application Insights component to connect to this Function App. Support for instrumentation key ingestion will end on March 31, 2025. It's recommended to use application_insights_connection_string instead."
  type        = string
  default     = null
}

variable "application_insights_connection_string" {
  description = "The connection string of the Application Insights component to connect to this Function App."
  type        = string
  default     = null
}

variable "key_vault_reference_identity_id" {
  description = "The ID of the managed identity that will be used to fetch app settings sourced from Key Vault."
  type        = string
  default     = null
}

variable "virtual_network_subnet_id" {
  description = "The ID of a virtual network subnet to integrate this Function App with."
  type        = string
  default     = null
}

variable "vnet_route_all_enabled" {
  description = "Should all outbound traffic have NAT gateways, network security groups and user-defined routes applied?"
  type        = bool
  default     = false
}

variable "elastic_instance_minimum" {
  description = "The minimum number of instances for this Function App. Only supported for Elastic Premium (e.g. \"EP1\") plans."
  type        = number
  default     = 1
}

variable "pre_warmed_instance_count" {
  description = "The number of pre-warmed instances for this Function App. Only supported for Elastic Premium (e.g. \"EP1\") plans."
  type        = number
  default     = 1
}

variable "app_scale_limit" {
  description = "The number of instanstes this Function App can scale to. Only supported for Consumption (e.g. \"Y1\") and Elastic Premium (e.g. \"EP1\") plans."
  type        = number
  default     = 1
}

variable "application_stack_dotnet_version" {
  description = "The version of .NET to use for this Function App."
  type        = string
  default     = null
}

variable "application_stack_use_dotnet_isolated_runtime" {
  description = "Should the .NET process for this Function App use an isolated runtime?"
  type        = bool
  default     = false
}

variable "application_stack_java_version" {
  description = "The version of Java to use for this Function App."
  type        = string
  default     = null
}

variable "application_stack_node_version" {
  description = "The version of Node.js to use for this Function App."
  type        = string
  default     = null
}

variable "application_stack_python_version" {
  description = "The version of Python to use for this Function App."
  type        = string
  default     = null
}

variable "application_stack_powershell_core_version" {
  description = "The version of PowerShell Core to use for this Function App."
  type        = string
  default     = null
}

variable "use_32_bit_worker" {
  description = "Should this Function App use a 32-bit worker process?"
  type        = bool
  default     = true
}

variable "ip_restriction_default_action" {
  description = "The default action for traffic that does not match any IP restriction rule. Value must be \"Allow\" or \"Deny\"."
  type        = string
  default     = "Deny"
  nullable    = false

  validation {
    condition     = contains(["Allow", "Deny"], var.ip_restriction_default_action)
    error_message = "IP restriction default action must be \"Allow\" or \"Deny\"."
  }
}

variable "scm_ip_restriction_default_action" {
  description = "The default action for traffic to the Source Control Manager (SCM) that does not match any IP restriction rule. Value must be \"Allow\" or \"Deny\"."
  type        = string
  default     = "Deny"
  nullable    = false

  validation {
    condition     = contains(["Allow", "Deny"], var.scm_ip_restriction_default_action)
    error_message = "SCM IP restriction default action must be \"Allow\" or \"Deny\"."
  }
}

variable "ip_restrictions" {
  description = "A list of IP restrictions to be configured for this Function App."

  type = list(object({
    action      = optional(string, "Allow")
    ip_address  = optional(string)
    name        = string
    priority    = number
    service_tag = optional(string)

    headers = optional(object({
      x_forwarded_for   = optional(list(string))
      x_forwarded_host  = optional(list(string))
      x_azure_fdid      = optional(list(string))
      x_fd_health_probe = optional(list(string))
    }))
  }))

  default = []
}

variable "identity_ids" {
  description = "A list of IDs of managed identities to be assigned to this Function App."
  type        = list(string)
  default     = []
}

variable "http2_enabled" {
  description = "Should the HTTP/2 protocol be enabled for this Function App?"
  type        = bool
  default     = false
}

variable "ftps_state" {
  description = "The state of the FTP / FTPS service for this Function App. Value must be \"AllAllowed\", \"FtpsOnly\" or \"Disabled\"."
  type        = string
  default     = "Disabled"

  validation {
    condition     = contains(["AllAllowed", "FtpsOnly", "Disabled"], var.ftps_state)
    error_message = "FTPS state must be \"AllAllowed\", \"FtpsOnly\" or \"Disabled\"."
  }
}

variable "client_certificate_mode" {
  description = "The client cerftificate mode for this Function App. Value must be \"Required\", \"Optional\" or \"OptionalInteractiveUser\"."
  type        = string
  default     = "Required"
}

variable "client_certificate_enabled" {
  description = "Should client certificate be enabled for this Function App?"
  type        = bool
  default     = false
}

variable "ftp_publish_basic_authentication_enabled" {
  description = "Should basic (username and password) authentication be enabled for the FTP client?"
  type        = bool
  default     = false
  nullable    = false
}

variable "webdeploy_publish_basic_authentication_enabled" {
  description = "Should basic (username and password) authentication be enabled for the WebDeploy client?"
  type        = bool
  default     = false
  nullable    = false
}

variable "storage_account_access_key" {
  description = "An access key which will be used to access the Storage account connected to this Function App. Required if value of \"storage_uses_managed_identity\" is false."
  type        = string
  default     = null
  nullable    = true
}

variable "storage_uses_managed_identity" {
  description = "Should this Function App use its system-assigned identity to access the connected Storage account?"
  type        = bool
  default     = true
  nullable    = false
}

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default     = {}
}

variable "zip_deploy_file" {
  description = "The path to a ZIP file to deploy to this Function App. Using this value requires either WEBSITE_RUN_FROM_PACKAGE=1 or SCM_DO_BUILD_DURING_DEPLOYMENT=true to be set in the app settings for a Linux app, or WEBSITE_RUN_FROM_ZIP=1 for a Windows app."
  type        = string
  default     = null
  validation {
    condition     = !(var.zip_deploy_file != null && var.webdeploy_publish_basic_authentication_enabled)
    error_message = "Cannot set zip_deploy_file when webdeploy_publish_basic_authentication_enabled is true."
  }
}
