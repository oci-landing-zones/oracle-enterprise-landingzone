variable "tenancy_ocid" {
  type        = string
  description = "Tenancy LZ is created in."
}

variable "compartment_id" {
  type        = string
  description = "The OCID of the comparment to create the service connector in."
}

variable "source_compartment_id" {
  type        = string
  description = "The OCID of the compartment containing the log source."
}

variable "display_name" {
  type        = string
  description = "The display name of service connector created"
}

variable "source_kind" {
  type        = string
  description = "The source type discriminator."
}

variable "target_kind" {
  type        = string
  default     = "objectStorage"
  description = "The target type discriminator."
}

variable "log_group_id" {
  type        = string
  default     = ""
  description = "The OCID of the log group."
}

variable "stream_id" {
  type        = string
  default     = ""
  description = "The OCID of the stream."
}

variable "cursor_kind" {
  type        = string
  default     = ""
  description = "The cursor type discriminator."
}

variable "target_bucket" {
  type        = string
  description = "The name of the target bucket."
}

variable "target_namespace" {
  type        = string
  default     = ""
  description = "The namespace of target bucket"
}