variable "metadata" {
  type        = any
  description = "Common metadata object (environment, project, key map, etc.)."
}

variable "realm_id" {
  type        = string
  description = "The ID (slug) of the Keycloak realm in which all resources will be created."
}

variable "client_parameters" {
  type        = any
  description = "Map of OpenID Connect clients to create. Key is used as the client_id."
  default     = {}
}

variable "client_defaults" {
  type        = any
  description = "Default values merged into every entry of client_parameters via try()."
  default     = {}
}

variable "user_parameters" {
  type        = any
  description = "Map of realm users to create. Key is the username."
  default     = {}
}

variable "user_defaults" {
  type        = any
  description = "Default values merged into every entry of user_parameters via try()."
  default     = {}
}
