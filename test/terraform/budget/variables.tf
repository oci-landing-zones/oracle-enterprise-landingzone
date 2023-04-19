variable "environment_prefix" {
  type        = string
  description = "the 1 character string representing the environment eg. P (prod), N (non-prod), D, T, U"
  default     = "T"
}

variable "enable_budget" {
  type    = bool
  default = true
}

variable "budget_amount" {
  description = "The amount of the budget expressed as a whole number in the currency of the customer's rate card."
  type        = string
  default     = "100000"
}

variable "budget_alert_rule_threshold" {
  description = "The threshold for the budget alert."
  type        = string
  default     = "100"
}

variable "budget_alert_rule_message" {
  description = "The alert message for budget alerts."
  type        = string
  default     = "testing prod"
}

variable "budget_alert_rule_recipients" {
  description = "The delimited list of email addresses to receive the alert when it triggers. Delimiter characters can be a comma, space, TAB, or semicolon"
  type        = string
  default     = "example@example.com"
}
