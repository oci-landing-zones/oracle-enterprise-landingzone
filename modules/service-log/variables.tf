variable "service_log_map" {
  type        = map(string)
  description = ""
}

variable "log_display_name" {
  type        = string
  description = "The display name of service log"
}

variable "log_type" {
  type        = string
  description = "The logType that the log object is for, whether custom or service."
}

variable "log_group_id" {
  type        = string
  description = "The OCID of a log group to work with."
}

variable "log_source_category" {
  type        = string
  description = "Log object category."
}

variable "log_source_service" {
  type        = string
  description = "Service generating log."
}

variable "log_source_type" {
  type        = string
  description = "The log source type."
}
