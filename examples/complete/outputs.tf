output "clients" {
  description = "Created OpenID Connect clients (id, client_id, name)."
  value       = module.keycloak_resources.clients
}

output "client_secrets" {
  description = "Client secrets for CONFIDENTIAL clients. Sensitive."
  value       = module.keycloak_resources.client_secrets
  sensitive   = true
}

output "roles" {
  description = "Created realm roles (id, name)."
  value       = module.keycloak_resources.roles
}

output "groups" {
  description = "Created realm groups (id, name)."
  value       = module.keycloak_resources.groups
}

output "users" {
  description = "Created realm users (id, username, email)."
  value       = module.keycloak_resources.users
}
