# Edit Below Amplify FrontEnd Config

variable "aws_region" { default = "eu-west-1" }

variable "app_name" { default = "vijuedutech-amplify" }

variable "git_branch" { default = "main" }

variable "amplify_framework" { default = "Javascript" }

variable "amplify_stage" { default = "PRODUCTION" }

# Git Repo Url For FrondEnd
variable "https_repo_url" { default = "https://github.com/Apporbis-Project/amplify-js" }

# Git Branch Access Token
variable "access_token" { default = "gpat" }

variable "react_api_url" { default = "https://api.example.com" }

variable "amplify_domain" { default = "suraj.gatha.info" }

# OPTIONAL
variable "domain_prefix" { default = "vijuedutech" }

# Edit Below Amplify BackEnd Config

variable "backend_env" { default = "staging" }
variable "deployment_artifacts" { default = "viju-app-deployment" }
variable "stack_name" { default = "amplify-viju-app" }

# Amplify Email Endpoint for SNS
variable "sns_endpoint" { default = "surajwaghmare35@gmail.com" }
