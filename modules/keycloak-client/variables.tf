# Basic client identity
variable "realm_id" {
  description = "The ID (slug) of the Keycloak realm in which the client will be created."
  type        = string
}

variable "client_id" {
  description = "The client_id of the OpenID Connect client (unique within the realm)."
  type        = string
}

variable "name" {
  description = "Human-readable name shown in the Keycloak admin console."
  type        = string
  default     = null
}

variable "enabled" {
  description = "Whether the client is enabled."
  type        = bool
  default     = true
}

variable "access_type" {
  description = "The access type of the client. Can be CONFIDENTIAL, PUBLIC, or BEARER-ONLY."
  type        = string
  default     = "CONFIDENTIAL"
  validation {
    condition     = contains(["CONFIDENTIAL", "PUBLIC", "BEARER-ONLY"], var.access_type)
    error_message = "access_type must be one of: CONFIDENTIAL, PUBLIC, BEARER-ONLY."
  }
}

# Flows
variable "standard_flow_enabled" {
  description = "Whether the standard (authorization code) flow is enabled."
  type        = bool
  default     = true
}

variable "direct_access_grants_enabled" {
  description = "Whether the direct access grants (resource owner password) flow is enabled."
  type        = bool
  default     = false
}

variable "service_accounts_enabled" {
  description = "Whether the service account (client credentials grant) is enabled. Requires access_type = CONFIDENTIAL."
  type        = bool
  default     = false
}

# Token lifespan
variable "access_token_lifespan" {
  description = <<-EOT
    Lifespan of issued access tokens for this client, in seconds. Overrides the
    realm default. When null (the default), the realm's access token lifespan
    is used. Example: 300 = 5 minutes, 3600 = 1 hour.
  EOT
  type        = number
  default     = null

  validation {
    condition     = var.access_token_lifespan == null || var.access_token_lifespan > 0
    error_message = "access_token_lifespan must be a positive number of seconds, or null to inherit the realm default."
  }
}

# Scope / least privilege
variable "full_scope_allowed" {
  description = <<-EOT
    When true, all of the client's role mappings are included in the token
    (Keycloak default). Set to false for least privilege so the token only
    carries explicitly scoped roles — this trims realm_access/resource_access
    for machine-to-machine service accounts.
  EOT
  type        = bool
  default     = true
}

variable "default_scopes" {
  description = <<-EOT
    Authoritative list of default client scopes attached to this client. When
    null (the default), the module does not manage scopes and Keycloak's
    defaults (profile, email, roles, web-origins) remain. Provide an explicit
    list to minimize claims — e.g. ["roles", "web-origins"] drops the profile
    and email user claims from service-account tokens.
  EOT
  type        = list(string)
  default     = null
}

# URIs
variable "valid_redirect_uris" {
  description = "List of valid redirect URIs for the client."
  type        = list(string)
  default     = []
}

variable "web_origins" {
  description = "List of allowed CORS web origins for the client."
  type        = list(string)
  default     = []
}

# Hardcoded claims (protocol mappers)
variable "hardcoded_claims" {
  description = <<-EOT
    Map of hardcoded claims to add to this client's tokens. The map key is used
    as the protocol mapper name. Each entry defines a claim with a fixed value.

    Example:
      hardcoded_claims = {
        randomclaim = {
          claim_value = "VALUE"
        }
      }
  EOT
  type = map(object({
    claim_name          = optional(string)           # Defaults to the map key if omitted.
    claim_value         = string                     # The hardcoded value of the claim.
    claim_value_type    = optional(string, "String") # String, JSON, long, int, or boolean.
    add_to_id_token     = optional(bool, true)
    add_to_access_token = optional(bool, true)
    add_to_userinfo     = optional(bool, true)
  }))
  default = {}
}

# Audiences (protocol mappers) — declare who the token is intended for (aud).
variable "audiences" {
  description = <<-EOT
    Map of audience mappers that add entries to the token's `aud` claim, i.e.
    the destination(s) this token is intended for. The map key is used as the
    protocol mapper name. Each entry must set exactly one of:
      - included_client_audience: the client_id of a Keycloak client, or
      - included_custom_audience: an arbitrary string for an external service.

    Example:
      audiences = {
        test-api = {
          included_custom_audience = "test-api"
        }
      }
  EOT
  type = map(object({
    included_client_audience   = optional(string) # A Keycloak client_id to target.
    included_custom_audience   = optional(string) # A custom/external audience string.
    add_to_id_token            = optional(bool, true)
    add_to_access_token        = optional(bool, true)
    add_to_token_introspection = optional(bool, true)
  }))
  default = {}

  validation {
    condition = alltrue([
      for a in values(var.audiences) :
      (a.included_client_audience != null) != (a.included_custom_audience != null)
    ])
    error_message = "Each audiences entry must set exactly one of included_client_audience or included_custom_audience."
  }
}
