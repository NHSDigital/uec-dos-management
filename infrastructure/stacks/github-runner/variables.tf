variable "github_org" {
  description = "The name of git hub organisation - eg NHSDigital"
}
variable "oidc_provider_url" {
  description = "Url of oidc provider"
}
variable "oidc_client" {
  description = "Client of oidc provider - eg aws"
}
variable "oidc_thumbprint" {
  description = "Thumbprint for oidc provider"
}

variable "int_environment" {
  description = "True only for integration environment that requires one role policy per domain repo"
  type        = bool
  default     = false
}
