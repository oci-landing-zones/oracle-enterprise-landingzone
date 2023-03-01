# -----------------------------------------------------------------------------
# Budget Output
# -----------------------------------------------------------------------------
output "budget" {
  value = oci_budget_budget.oci_budget
}

output "budget_alert_rule" {
  value = oci_budget_alert_rule.oci_budget_rule
}

output "budget_id" {
  value = oci_budget_alert_rule.oci_budget_rule.budget_id
}

output "budget_target_name" {
  value = oci_budget_budget.oci_budget.display_name
}

output "budget_amount" {
  value = oci_budget_budget.oci_budget.amount
}

output "budget_alert_rule_threshold" {
  value = oci_budget_alert_rule.oci_budget_rule.threshold
}

output "budget_alert_rule_recipients" {
  value = oci_budget_alert_rule.oci_budget_rule.recipients
}
