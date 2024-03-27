resource "aws_cognito_user_pool" "pool" {
  name = "VijuAppUserPool"

  username_attributes = ["email"]
  username_configuration {
    case_sensitive = true
  }

  # alias_attributes         = ["email"]
  auto_verified_attributes = ["email"]
  deletion_protection      = "INACTIVE"

  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = "1"
    }
  }

  # ... other configuration ...
  mfa_configuration = "OFF"

  # software_token_mfa_configuration {
  #   enabled = true
  # }

  user_attribute_update_settings {
    attributes_require_verification_before_update = ["email"]
  }

  # device_configuration {
  #   challenge_required_on_new_device      = true
  #   device_only_remembered_on_user_prompt = true
  # }

  # ... Required attributes ...
  schema {
    name                     = "name"
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = false # false for "sub"
    required                 = true  # true for "sub"
  }
  schema {
    name                     = "email"
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = false # false for "sub"
    required                 = true  # true for "sub"
  }

  # email_configuration {
  #   email_sending_account = "COGNITO_DEFAULT"
  #   from_email_address    = "no-reply@verificationemail.com"
  # }

  # email_verification_subject = "Your verification code"
  # email_verification_message = "Your verification code is {####}."
  # # email_verification_subject = "Your verification link"
  # # email_verification_message = "Please click the link below to verify your email address. {##Verify Email##}"

  # admin_create_user_config {
  #   allow_admin_create_user_only = true
  #   invite_message_template {
  #     email_subject = "Your temporary password"
  #     email_message = "Your username is {username} and temporary password is {####}."
  #   }
  # }

  # sms_authentication_message = "Your authentication code is {####}."

}

resource "aws_cognito_user_pool_domain" "main" {
  domain       = "viju"
  user_pool_id = aws_cognito_user_pool.pool.id
}

resource "aws_cognito_user_pool_client" "client" {
  name         = "viju-web-app"
  user_pool_id = aws_cognito_user_pool.pool.id

  enable_token_revocation       = true
  prevent_user_existence_errors = "ENABLED"

  generate_secret     = false                                               //default is true
  explicit_auth_flows = ["ALLOW_REFRESH_TOKEN_AUTH", "ALLOW_USER_SRP_AUTH"] // default is ADMIN_NO_SRP_AUTH"

  callback_urls                        = ["http://localhost:3000"]
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows                  = ["code"]
  allowed_oauth_scopes                 = ["email", "openid", "phone"]
  supported_identity_providers         = ["COGNITO"]
}

output "CognitoUserPoolID" {
  value = aws_cognito_user_pool.pool.id
}

output "CognitoUserPoolEP" {
  value = aws_cognito_user_pool.pool.endpoint
}

output "CognitoUserPoolClientID" {
  value = aws_cognito_user_pool_client.client.id
}
