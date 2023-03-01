variable "tenancy_ocid" {
  type        = string
  description = "The OCID of tenancy"
}

variable "region" {
  type        = string
  description = "The reporting region value."
}

variable "status" {
  type        = string
  description = "Status of Cloud Guard Tenant"
}

variable "compartment_id" {
  type        = string
  description = "The OCID of the compartment in which to list resources."
}

variable "display_name" {
  type        = string
  description = "The display name of cloud guard target"
}

variable "target_resource_id" {
  type        = string
  description = "Resource ID which the target uses to monitor."
}

variable "target_resource_type" {
  type        = string
  description = "The type of targets."
}

variable "description" {
  type        = string
  description = "The target description."
}

variable "configuration_detector_recipe_display_name" {
  type        = string
  description = "The display name of configuration detector recipe."
}

variable "activity_detector_recipe_display_name" {
  type        = string
  description = "The display name of activity detector recipe."
}

variable "threat_detector_recipe_display_name" {
  type        = string
  description = "The display name of threat detector recipe."
}

variable "responder_recipe_display_name" {
  type        = string
  description = "The display name of responder recipe."
}

