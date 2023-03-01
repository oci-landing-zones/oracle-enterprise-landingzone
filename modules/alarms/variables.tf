variable "compartment_id" {
  type        = string
  description = "The OCID of the compartment containing the alarm."
  default     = ""
}

variable "alarm_map" {
  type = map(object({
    display_name          = string,
    metric_compartment_id = string,
    namespace             = string,
    query                 = string,
    severity              = string,
  }))
  description = <<EOT
    display name: the display name for alarm;
    metric compartment id: the OCID of the compartment containing the metric being evaluated by the alarm
    namespace: the source service or application emitting the metric that is evaluated by the alarm
    query: the Monitoring Query Language (MQL) expression to evaluate for the alarm
    severity: the perceived type of response required when the alarm is in the "FIRING" state
  EOT
}

variable "metric_compartment_id_in_subtree"{
  type = bool
  description = "Only needed if metric_compartment_id = <tenancy OCID>"
  default = false
}

variable "is_enabled"{
  type = bool
  description = "Alarms enabled or disabled."
  default = false
}

variable "notification_topic_id" {
  type = string
  description = "the OCID of notification topic."
}

variable "message_format"{
  type = string
  description = "format of alarm message"
  default = "ONS_OPTIMIZED"
}

variable "pending_duration" {
  type = string
  description = "The period of time that the condition defined in the alarm must persist before the alarm state changes from 'OK' to 'FIRING'."
  default = "PT5M"
}
