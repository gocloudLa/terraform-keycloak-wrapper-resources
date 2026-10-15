resource "keycloak_openid_client" "this" {
  realm_id  = var.realm_id
  client_id = var.client_id

  name        = var.name
  enabled     = var.enabled
  access_type = var.access_type

  standard_flow_enabled        = var.standard_flow_enabled
  direct_access_grants_enabled = var.direct_access_grants_enabled
  service_accounts_enabled     = var.service_accounts_enabled

  full_scope_allowed    = var.full_scope_allowed
  access_token_lifespan = var.access_token_lifespan

  valid_redirect_uris = var.valid_redirect_uris
  web_origins         = var.web_origins
}

# Authoritative default client scopes. Only managed when default_scopes is set;
# use this to strip profile/email claims from least-privilege service accounts.
resource "keycloak_openid_client_default_scopes" "this" {
  count = var.default_scopes != null ? 1 : 0

  realm_id       = var.realm_id
  client_id      = keycloak_openid_client.this.id
  default_scopes = var.default_scopes
}

# Hardcoded claim protocol mappers attached to this client.
resource "keycloak_openid_hardcoded_claim_protocol_mapper" "this" {
  for_each = var.hardcoded_claims

  realm_id  = var.realm_id
  client_id = keycloak_openid_client.this.id
  name      = each.key

  claim_name       = try(each.value.claim_name, each.key)
  claim_value      = each.value.claim_value
  claim_value_type = each.value.claim_value_type

  add_to_id_token     = each.value.add_to_id_token
  add_to_access_token = each.value.add_to_access_token
  add_to_userinfo     = each.value.add_to_userinfo
}

# Audience protocol mappers — set the token's `aud` (intended destination).
resource "keycloak_openid_audience_protocol_mapper" "this" {
  for_each = var.audiences

  realm_id  = var.realm_id
  client_id = keycloak_openid_client.this.id
  name      = each.key

  included_client_audience = each.value.included_client_audience
  included_custom_audience = each.value.included_custom_audience

  add_to_id_token            = each.value.add_to_id_token
  add_to_access_token        = each.value.add_to_access_token
  add_to_token_introspection = each.value.add_to_token_introspection
}
