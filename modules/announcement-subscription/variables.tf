variable "compartment_id" {
  type        = string
  description = "The OCID of the compartment where you want to create the announcement subscription"
}

variable "subscription_display_name" {
  type        = string
  description = "The display name of the subscription"
}

variable "notification_topic_id" {
  type        = string
  description = "The OCID of the Notifications service topic"
}

variable "filter_groups" {
  type        = map(any)
  description = "A list of filter groups for the announcement subscription. "
}
