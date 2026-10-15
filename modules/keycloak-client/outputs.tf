# Client basic outputs
output "id" {
  description = "The internal ID of the client."
  value       = keycloak_openid_client.this.id
}

output "client_id" {
  description = "The client_id of the client."
  value       = keycloak_openid_client.this.client_id
}

output "name" {
  description = "The human-readable name of the client."
  value       = keycloak_openid_client.this.name
}

output "access_type" {
  description = "The access type of the client."
  value       = keycloak_openid_client.this.access_type
}

output "client_secret" {
  description = "The client secret. Only populated for CONFIDENTIAL clients."
  value       = keycloak_openid_client.this.client_secret
  sensitive   = true
}
