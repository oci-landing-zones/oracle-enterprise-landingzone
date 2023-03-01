locals {
  budget = {
    budget_description  = "Budget targeting ${var.environment_prefix} enviroment compartment"
    budget_display_name = "OCI-ELZ-BGT-${var.environment_prefix}"
  }
}

module "budget" {
  count              = var.enable_budget ? 1 : 0
  source             = "../../../templates/elz-budget" #MODIFIED
  tenancy_ocid       = var.tenancy_ocid
  region             = var.region
  environment_prefix = var.environment_prefix

  budget_compartment_id        = var.tenancy_ocid
  budget_description           = local.budget.budget_description
  budget_display_name          = local.budget.budget_display_name
  budget_target                = var.tenancy_ocid #MODIFIED
  budget_amount                = var.budget_amount
  budget_alert_rule_threshold  = var.budget_alert_rule_threshold
  budget_alert_rule_message    = var.budget_alert_rule_message
  budget_alert_rule_recipients = var.budget_alert_rule_recipients

  providers = {
    oci             = oci
    oci.home_region = oci.home_region
  }
}
