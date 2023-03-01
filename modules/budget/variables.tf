# -----------------------------------------------------------------------------
# Required inputs
# -----------------------------------------------------------------------------
variable "compartment_id" {
  type        = string
  description = "The ocid of compartment to provision resources"
}

variable "budget_amount" {
  description = "The amount of the budget expressed as a whole number in the currency of the customer's rate card."
  type        = string
}

variable "budget_reset_period" {
  description = "The reset period for the budget."
  default     = "MONTHLY"
  type        = string
}

variable "budget_description" {
  
  type        = string
}

variable "budget_display_name" {
  
  type        = string
}

variable "budget_target_type" {
  description = "The target type for the budget"
  default     = "COMPARTMENT"
  type        = string
}

variable "budget_target" {
  description = "The compartment ocid for the budget"
  type        = string
}

# -----------------------------------------------------------------------------
# Optional inputs and values to override
# -----------------------------------------------------------------------------
variable "budget_alert_rule_threshold" {
  description = "The target for the budget"
  type        = number
}

variable "budget_alert_rule_threshold_type" {
  description = "The threshold type for the budget"
  default     = "ABSOLUTE"
  type        = string
}

variable "budget_alert_rule_type" {
  description = "The type of alert for the budget"
  default     = "ACTUAL"
  type        = string
}

variable "budget_alert_rule_display_name" {
  
  type        = string
}

variable "budget_alert_rule_message" {
  description = "The alert message for budget alerts."
  type        = string
}

variable "budget_alert_rule_recipients" {
  description = "The type of alert for the budget"
  type        = string
}
