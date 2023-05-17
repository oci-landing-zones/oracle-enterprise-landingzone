
output "compartment_id" {
  value       = module.workload_compartment.compartment_id
  description = "The OCID of Exadata Workload Compartment"
}
output "compartment_name" {
  value       = module.workload_compartment.compartment_name
  description = "The Exadata Workload Compartment Name"
}

output "subnet_cidr_blocks" {
  value = {
    spoke_subnet_lb_cidr     = var.workload_private_spoke_subnet_lb_cidr_block
    spoke_subnet_app_cidr    = var.workload_private_spoke_subnet_app_cidr_block
    spoke_subnet_client_cidr = var.workload_private_spoke_subnet_client_cidr_block
    spoke_subnet_backup_cidr = var.workload_private_spoke_subnet_backup_cidr_block
  }
}

output "bastion_id" {
  value = var.enable_bastion ? module.bastion[0].bastion_ocid : null
}
