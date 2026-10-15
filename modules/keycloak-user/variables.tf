# Basic user identity
variable "realm_id" {
  description = "The ID (slug) of the Keycloak realm in which the user will be created."
  type        = string
}

variable "username" {
  description = "The username of the realm user (unique within the realm)."
  type        = string
}

variable "email" {
  description = "The email address of the user."
  type        = string
  default     = null
}

variable "first_name" {
  description = "The first name of the user."
  type        = string
  default     = null
}

variable "last_name" {
  description = "The last name of the user."
  type        = string
  default     = null
}

variable "enabled" {
  description = "Whether the user is enabled."
  type        = bool
  default     = true
}

variable "initial_password" {
  description = "Optional initial password for the user. Set to null to skip."
  type = object({
    value     = string
    temporary = optional(bool, true)
  })
  default = null
}
