##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

output "budget" {
  value = module.budget.budget
}

output "budget_alert_rule" {
  value = module.budget.budget_alert_rule
}
