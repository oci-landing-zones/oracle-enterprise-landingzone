# -----------------------------------------------------------------------------
# Common Variables
# -----------------------------------------------------------------------------
variable "tenancy_ocid" {
  type        = string
  description = "The OCID of tenancy"
}

variable "region" {
  type        = string
  description = "The OCI region"
}

variable "environment_prefix" {
  type        = string
  description = "the 1 character string representing the environment eg. P (prod), N (non-prod), D, T, U"
}

variable "home_compartment_id" {
  type        = string
  description = "Home Compartment ID"
}
# -----------------------------------------------------------------------------
# Compartment Variables
# -----------------------------------------------------------------------------
variable "enable_compartment_delete" {
  type        = bool
  description = "Set to true to allow the compartments to delete on terraform destroy."
  default     = true
}

variable "home_compartment_id" {
  type        = string
  description = "the OCID of the compartment where the environment will be created. In general, this should be the Landing zone parent compartment."
}

variable "environment_compartment_name" {
  type        = string
  description = "The name of the compartment that acts as the main compartment for the environment. Resources related to this environment will be created under this compartment. "
  default     = ""
}

variable "enable_tf_state_backup" {
  type        = bool
  description = "Set to true to enable logging compartment which contains the bucket for the log files."
  default     = false
}

variable "enable_logging" {
  type        = bool
  description = "Set to true to enable logging compartment which stores the configuration information that landing zones is setting up for the customer."
  default     = false
}
