terraform {
  required_providers {
    oci = {
      source                = "oracle/oci"
      configuration_aliases = [oci]
    }
  }
}

resource "oci_budget_budget" "oci_budget" {
  compartment_id = var.compartment_id
  amount         = var.budget_amount
  reset_period   = var.budget_reset_period

  description  = var.budget_description
  display_name = var.budget_display_name
  target_type  = var.budget_target_type
  targets      = [ var.budget_target ]
}

resource "oci_budget_alert_rule" "oci_budget_rule" {
  budget_id      = oci_budget_budget.oci_budget.id
  threshold      = var.budget_alert_rule_threshold
  threshold_type = var.budget_alert_rule_threshold_type
  type           = var.budget_alert_rule_type

  display_name = var.budget_alert_rule_display_name
  message       = var.budget_alert_rule_message
  recipients    = var.budget_alert_rule_recipients
}
