resource "keycloak_user" "this" {
  realm_id   = var.realm_id
  username   = var.username
  email      = var.email
  first_name = var.first_name
  last_name  = var.last_name
  enabled    = var.enabled

  dynamic "initial_password" {
    for_each = var.initial_password != null ? [var.initial_password] : []
    content {
      value     = initial_password.value.value
      temporary = initial_password.value.temporary
    }
  }
}
