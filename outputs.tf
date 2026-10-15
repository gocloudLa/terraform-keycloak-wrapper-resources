output "clients" {
  description = "Map of created OpenID Connect clients keyed by client_id."
  value = {
    for k, m in module.client : k => {
      id          = m.id
      client_id   = m.client_id
      name        = m.name
      access_type = m.access_type
    }
  }
}

output "client_secrets" {
  description = "Map of client secrets keyed by client_id. Only populated for CONFIDENTIAL clients. Sensitive."
  sensitive   = true
  value = {
    for k, m in module.client : k => m.client_secret
  }
}

output "users" {
  description = "Map of created users keyed by username."
  value = {
    for k, m in module.user : k => {
      id       = m.id
      username = m.username
      email    = m.email
    }
  }
}
