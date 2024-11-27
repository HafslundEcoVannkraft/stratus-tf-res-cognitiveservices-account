output "cognitive_account_resource_id" {
  value = azapi_resource.cognitive_account.id
  description = "The resource ID of the created cognitive account"
}

output "identity" {
  value = azapi_resource.cognitive_account.identity
  description = "The system-assigned managed identity of the created cognitive account"
}