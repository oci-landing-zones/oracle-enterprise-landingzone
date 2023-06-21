variable "compartment_id" {
  type        = string
  description = "The OCID of the Compartment where domain is created"
}

# -----------------------------------------------------------------------------
# Domain Variables 
# -----------------------------------------------------------------------------
variable "domain_description" {
  type        = string
  description = "Domain entity description."
}

variable "domain_display_name" {
  type        = string
  description = "The mutable display name of the domain."
}

variable "domain_home_region" {
  type        = string
  description = "The region's name."
}

variable "domain_license_type" {
  type        = string
  description = "The license type of Domain"
}

variable "domain_admin_email" {
  type        = string
  default     = null
  description = "The admin email address."
}

variable "domain_admin_first_name" {
  type        = string
  default     = null
  description = "The admin email address."
}

variable "domain_admin_last_name" {
  type        = string
  default     = null
  description = "The admin email address."
}

variable "domain_admin_user_name" {
  type        = string
  default     = null
  description = "The admin email address."
}

variable "domain_is_hidden_on_login" {
  type        = bool
  default     = false 
  description = "Indicates whether domain is hidden on login screen or not."
}

variable "domain_is_notification_bypassed" {
  type        = bool
  default     = false
  description = "Indicates if admin user created in IDCS stripe would like to receive notification like welcome email or not."
}

variable "domain_is_primary_email_required" {
  type        = bool
  default     = true
  description = "Indicate whether users in the domain are required to have a primary email address or not."
}

variable "domain_replica_region" {
  type        = string
  default     = ""
  description = "A region for which domain replication is requested for."
}
