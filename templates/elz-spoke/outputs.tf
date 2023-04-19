output "spoke_web_subnet_ocid" {
  value = module.workload_spoke_subnet.subnets[var.workload_private_spoke_subnet_web_display_name]
}

output "spoke_app_subnet_ocid" {
  value = module.workload_spoke_subnet.subnets[var.workload_private_spoke_subnet_app_display_name]
}

output "spoke_db_subnet_ocid" {
  value = module.workload_spoke_subnet.subnets[var.workload_private_spoke_subnet_db_display_name]
}

output "subnets" {
  value = {
    (var.workload_private_spoke_subnet_db_display_name)  = module.workload_spoke_subnet.subnets[var.workload_private_spoke_subnet_db_display_name]
    (var.workload_private_spoke_subnet_app_display_name) = module.workload_spoke_subnet.subnets[var.workload_private_spoke_subnet_app_display_name]
    (var.workload_private_spoke_subnet_web_display_name) = module.workload_spoke_subnet.subnets[var.workload_private_spoke_subnet_web_display_name]
  }
  description = "The subnet OCID"
}