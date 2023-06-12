variable "group_names" {
  type        = list(string)
  description = "The list of user group names."
}

variable "identity_domain_id" {
  type        = string
  description = "the OCID of identity domain"
}

variable "tenancy_ocid" {
  type        = string
  description = "The OCID of tenancy"
}

variable "region" {
  type        = string
  description = "The OCI region"
}

variable "current_user_ocid" {
  type        = string
  description = "The OCID of the current user"
  default     = ""
}

variable "api_fingerprint" {
  type        = string
  description = "The fingerprint of API"
  default     = ""
}

variable "api_private_key_path" {
  type        = string
  description = "The local path to the API private key"
  default     = ""
}
