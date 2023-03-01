variable "prod_retention_policy_duration_amount" {
  type        = string
  description = "The timeAmount is interpreted in units defined by the timeUnit parameter, and is calculated in relation to each object's Last-Modified timestamp."
  default     = "1"
}

variable "prod_retention_policy_duration_time_unit" {
  type        = string
  description = "The unit that should be used to interpret timeAmount."
  default     = "DAYS"
}

variable "nonprod_retention_policy_duration_amount" {
  type        = string
  description = "The timeAmount is interpreted in units defined by the timeUnit parameter, and is calculated in relation to each object's Last-Modified timestamp."
  default     = "1"
}

variable "nonprod_retention_policy_duration_time_unit" {
  type        = string
  description = "The unit that should be used to interpret timeAmount."
  default     = "DAYS"
}

variable "archive_log_retention_policy_duration_amount" {
  type        = string
  description = "The timeAmount is interpreted in units defined by the timeUnit parameter, and is calculated in relation to each object's Last-Modified timestamp."
  default     = "1"
}

variable "archive_log_retention_policy_duration_time_unit" {
  type        = string
  description = "The unit that should be used to interpret timeAmount."
  default     = "DAYS"
}