output "app_service_plan_id" {
  description = "The ID of this app service plan."
  value       = azurerm_service_plan.this.id
}

output "app_service_plan_name" {
  description = "The name of this app service plan."
  value       = azurerm_service_plan.this.id
}

output "app_id" {
  description = "The ID of this Function App."
  value       = module.app.id
}

output "app_name" {
  description = "The name of this Function App."
  value       = module.app.name
}

output "identity_principal_id" {
  description = "The principal ID of the system-assigned identity of this Function App."
  value       = module.app.identity_principal_id
}
