variable "region" {
  type        = string
  description = "The OCI region"
}

variable "environment_prefix" {
  type        = string
  description = "the 1 character string representing the environment eg. P (prod), N (non-prod), D, T, U"
}

variable "security_compartment_id" {
  type        = string
  description = " The ocid of the security compartment."
}

variable "home_compartment_name" {
  type        = string
  description = " The name of the home compartment."
}

variable "home_compartment_id" {
  type        = string
  description = " The id of the home compartment."
}

variable "master_encryption_key" {
  type        = string
  description = "The ocid of master encryption key"
}

variable "logging_compartment_id" {
  type        = string
  description = " The ocid of the logging compartment."
}

variable "tenancy_ocid" {
  type        = string
  description = "The OCID of tenancy"
}

variable "resource_label" {
  type        = string
  description = "Prefix used to avoid naming conflict"
}

variable "retention_policy_duration_amount" {
  type        = string
  description = "The timeAmount is interpreted in units defined by the timeUnit parameter, and is calculated in relation to each object's Last-Modified timestamp."
}

variable "retention_policy_duration_time_unit" {
  type        = string
  description = "The unit that should be used to interpret timeAmount."
}

variable "subnets_map" {
  type        = map(string)
  description = ""
}
variable "is_service_connector_limit" {
  type        = bool
  description = "Restrict Number of Service Connector Deployment"
}