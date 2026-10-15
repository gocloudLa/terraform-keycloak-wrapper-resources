# User basic outputs
output "id" {
  description = "The internal ID of the user."
  value       = keycloak_user.this.id
}

output "username" {
  description = "The username of the user."
  value       = keycloak_user.this.username
}

output "email" {
  description = "The email address of the user."
  value       = keycloak_user.this.email
}
