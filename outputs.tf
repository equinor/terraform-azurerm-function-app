output "app_id" {
  description = "The ID of this Function App."
  value       = local.function_app.id
}

output "app_name" {
  description = "The name of this Function App."
  value       = local.function_app.name
}

output "identity_principal_id" {
  description = "The principal ID of the system-assigned identity of this Function App."
  value       = local.function_app.identity[0].principal_id
}

output "identity_tenant_id" {
  description = "The tenant ID of the system-assigned identity of this Function App."
  value       = local.function_app.identity[0].tenant_id
}
