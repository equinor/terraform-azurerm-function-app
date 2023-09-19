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

variable "storage_account_name" {
  description = "The name of the Storage account to use for this Function App."
  type        = string
}

variable "storage_account_key" {
  description = "The shared key of the Storage account to use for this Function App."
  type        = string
  sensitive   = true
}

variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics workspace to send diagnostic to."
  type        = string
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

variable "kind" {
  description = "The kind of Function App to create."
  type        = string
  default     = "Linux"

  validation {
    condition     = contains(["Linux", "Windows"], var.kind)
    error_message = "Kind must be \"Linux\" or \"Windows\"."
  }
}

variable "application_insights_key" {
  description = "The instrumentation key of the Application Insights component to configure for this Function App."
  type        = string
  default     = null
}

variable "application_insights_connection_string" {
  description = "The connection string of the Application Insights component to configure for this Function App."
  type        = string
  default     = null
}

variable "key_vault_reference_identity_id" {
  description = "The ID of the Managed Identity that will be used to fetch app settings sourced from Key Vault."
  type        = string
  default     = null
}

variable "virtual_network_subnet_id" {
  description = "The ID of the virtual network subnet to use for vNet integration."
  type        = string
  default     = null
}

variable "vnet_route_all_enabled" {
  description = "Should all outbound traffic have NAT Gateways, Network Security Groups and User Defined Routes applied?"
  type        = bool
  default     = false
}

variable "elastic_instance_minimum" {
  description = "The minimum number of instances for this Function App. Only supported for Elastic Premium plans."
  type        = number
  default     = 1
}

variable "application_stack" {
  description = "The application stack to configure for this Function App."

  type = object({
    dotnet_version              = optional(string)
    use_dotnet_isolated_runtime = optional(bool)
    java_version                = optional(string)
    node_version                = optional(string)
    python_version              = optional(string)
    powershell_core_version     = optional(string)
    use_custom_runtime          = optional(bool)
  })

  default = null
}

variable "system_assigned_identity_enabled" {
  description = "Should the system-assigned identity be enabled for this Web App?"
  type        = bool
  default     = false
}

variable "identity_ids" {
  description = "A list of IDs of managed identities to be assigned to this Web App."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default     = {}
}
