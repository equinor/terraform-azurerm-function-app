output "app_name" {
  value = local.app_name
}

output "resource_group_name" {
  value = local.resource_group_name
}

output "location" {
  value = "northeurope"
}

output "app_service_plan_id" {
  value = local.app_service_plan_id
}

output "storage_account_id" {
  value = "/subscriptions/${random_uuid.subscription_id.result}/resourceGroups/${local.resource_group_name}/providers/Microsoft.Storage/storageAccounts/stfunc${local.name_suffix}"
}

output "storage_account_access_key" {
  value = "password123"
}

output "log_analytics_workspace_id" {
  value = "/subscriptions/${random_uuid.subscription_id.result}/resourceGroups/${local.resource_group_name}/providers/Microsoft.OperationalInsights/workspaces/log-${local.name_suffix}"
}
