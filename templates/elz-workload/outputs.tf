output "compartment_id" {
  value       = module.workload_compartment.compartment_id
  description = "The ocid of workload compartment"
}
output "compartment_name" {
  value = module.workload_compartment.compartment_name
  description = "The Workload Compartment Name"
}

output "subnet_cidr_blocks" {
  value = [var.workload_private_spoke_subnet_app_cidr_block, 
           var.workload_private_spoke_subnet_db_cidr_block,
           var.workload_private_spoke_subnet_web_cidr_block,
  ]
}