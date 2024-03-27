variable "CognitoUserPoolID" {}
variable "CognitoUserPoolEP" {}
variable "CognitoUserPoolClientID" {}

resource "aws_cognito_identity_pool" "main" {
  identity_pool_name               = "VijuAppIDP"
  allow_unauthenticated_identities = false
  allow_classic_flow               = false

  cognito_identity_providers {
    client_id               = var.CognitoUserPoolClientID
    provider_name           = var.CognitoUserPoolEP
    server_side_token_check = false
  }
}
