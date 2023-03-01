output "compartment_id" {
  value       = module.workload_compartment.compartment_id
  description = "The ocid of workload compartment"
}
output "compartment_name" {
  value = module.workload_compartment.compartment_name
  description = "The Workload Compartment Name"
}
