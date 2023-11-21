output "spoke_web_subnet_ocid" {
  value = module.backup_workload_spoke_subnet.subnets[var.workload_private_spoke_subnet_web_display_name]
  description = "Spoke Web Subnet OCID."
}

output "subnets" {
  value = {
    (var.workload_private_spoke_subnet_db_display_name)  = module.backup_workload_spoke_subnet.subnets[var.workload_private_spoke_subnet_db_display_name]
    (var.workload_private_spoke_subnet_app_display_name) = module.backup_workload_spoke_subnet.subnets[var.workload_private_spoke_subnet_app_display_name]
    (var.workload_private_spoke_subnet_web_display_name) = module.backup_workload_spoke_subnet.subnets[var.workload_private_spoke_subnet_web_display_name]
  }
  description = "The Spoke Subnet OCID"
}