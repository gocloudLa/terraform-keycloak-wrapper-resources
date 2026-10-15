variable "keycloak_url" {
  description = "Base URL of the Keycloak instance (e.g. https://keycloak.example.com)."
  type        = string
  default     = "http://localhost:8080"
}

variable "keycloak_client_id" {
  description = "Client ID used to authenticate against Keycloak (usually admin-cli)."
  type        = string
  default     = "admin-cli"
}

variable "keycloak_username" {
  description = "Admin username for Keycloak."
  type        = string
  default     = "admin"
}

variable "keycloak_password" {
  description = "Admin password for Keycloak."
  type        = string
  sensitive   = true
}

variable "realm_id" {
  description = "Slug of the existing realm in which resources will be created."
  type        = string
  default     = "example-realm"
}

variable "demo_user_password" {
  description = "Initial password applied to the example users. Provide via TF_VAR_demo_user_password or a tfvars file; do not hardcode real credentials."
  type        = string
  sensitive   = true
}
