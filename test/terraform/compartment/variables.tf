variable "home_compartment_name" {
  type        = string
  default     = "OCI-ELZ-CMP-HOME-TEST"
  description = "The name of the Landing Zone home compartment."
}

variable "enable_compartment_delete" {
  type        = bool
  description = "Set to true to allow the compartments to delete on terraform destroy."
  default     = true
}

#
variable "environment_prefix" {
  type        = string
  description = "the 1 character string representing the environment eg. P (prod), N (non-prod), D, T, U"
  default     = "T"
}

#
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
  default     = true
  # default     = false
}
