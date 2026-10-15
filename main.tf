module "client" {
  source   = "./modules/keycloak-client"
  for_each = var.client_parameters

  realm_id  = var.realm_id
  client_id = each.key

  name        = try(each.value.name, var.client_defaults.name, each.key)
  enabled     = try(each.value.enabled, var.client_defaults.enabled, true)
  access_type = try(each.value.access_type, var.client_defaults.access_type, "CONFIDENTIAL")

  standard_flow_enabled        = try(each.value.standard_flow_enabled, var.client_defaults.standard_flow_enabled, true)
  direct_access_grants_enabled = try(each.value.direct_access_grants_enabled, var.client_defaults.direct_access_grants_enabled, false)
  service_accounts_enabled     = try(each.value.service_accounts_enabled, var.client_defaults.service_accounts_enabled, false)

  full_scope_allowed    = try(each.value.full_scope_allowed, var.client_defaults.full_scope_allowed, true)
  default_scopes        = try(each.value.default_scopes, var.client_defaults.default_scopes, null)
  access_token_lifespan = try(each.value.access_token_lifespan, var.client_defaults.access_token_lifespan, null)

  valid_redirect_uris = try(each.value.valid_redirect_uris, var.client_defaults.valid_redirect_uris, [])
  web_origins         = try(each.value.web_origins, var.client_defaults.web_origins, [])

  hardcoded_claims = try(each.value.hardcoded_claims, var.client_defaults.hardcoded_claims, {})
  audiences        = try(each.value.audiences, var.client_defaults.audiences, {})
}

module "user" {
  source   = "./modules/keycloak-user"
  for_each = var.user_parameters

  realm_id = var.realm_id
  username = each.key

  email      = try(each.value.email, var.user_defaults.email, null)
  first_name = try(each.value.first_name, var.user_defaults.first_name, null)
  last_name  = try(each.value.last_name, var.user_defaults.last_name, null)
  enabled    = try(each.value.enabled, var.user_defaults.enabled, true)

  initial_password = try(each.value.initial_password, var.user_defaults.initial_password, null)
}
