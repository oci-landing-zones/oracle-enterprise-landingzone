locals {
  budget = {
    budget_alert_rule_display_name = "${var.budget_display_name}_rule"
  }
}

module "budget" {
  source = "../../modules/budget"

  compartment_id      = var.budget_compartment_id
  budget_amount       = var.budget_amount
  budget_display_name = var.budget_display_name
  budget_description  = var.budget_description
  budget_target       = var.budget_target

  budget_alert_rule_display_name = local.budget.budget_alert_rule_display_name
  budget_alert_rule_threshold    = var.budget_alert_rule_threshold
  budget_alert_rule_message      = var.budget_alert_rule_message
  budget_alert_rule_recipients   = var.budget_alert_rule_recipients

  providers = {
    oci = oci
  }
}
