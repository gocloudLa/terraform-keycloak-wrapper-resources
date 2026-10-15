module "keycloak_resources" {
  source = "../../"

  metadata = local.metadata
  realm_id = var.realm_id

  client_defaults = {
    enabled                      = true
    access_type                  = "CONFIDENTIAL"
    standard_flow_enabled        = true
    direct_access_grants_enabled = false
  }

  client_parameters = {
    "example-web-app" = {
      name                = "Example Web Application"
      access_type         = "PUBLIC"
      valid_redirect_uris = ["http://localhost:3000/*"]
      web_origins         = ["http://localhost:3000"]
    }

    "example-api" = {
      name        = "Example API Service"
      access_type = "BEARER-ONLY"
    }
  }

  user_defaults = {
    enabled = true
    initial_password = {
      value     = var.demo_user_password
      temporary = true
    }
  }

  user_parameters = {
    "dev-jane" = {
      email      = "jane@example.com"
      first_name = "Jane"
      last_name  = "Developer"
    }

    "admin-john" = {
      email      = "john@example.com"
      first_name = "John"
      last_name  = "Admin"
      initial_password = {
        value     = var.demo_user_password
        temporary = true
      }
    }
  }
}
