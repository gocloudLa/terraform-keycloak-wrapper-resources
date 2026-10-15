provider "keycloak" {
  url       = var.keycloak_url
  client_id = var.keycloak_client_id
  username  = var.keycloak_username
  password  = var.keycloak_password
}
