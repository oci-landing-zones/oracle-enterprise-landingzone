variable "retention_policy_duration_amount" {
  type        = string
  description = "The timeAmount is interpreted in units defined by the timeUnit parameter, and is calculated in relation to each object's Last-Modified timestamp."
}

variable "retention_policy_duration_time_unit" {
  type        = string
  description = "The unit that should be used to interpret timeAmount."
}

variable "logging_compartment_id" {
  type        = string
  description = "the ocid of logging compartment"
}
variable "home_compartment_name" {
  type        = string
  description = "The name of the Landing Zone home compartment."
}