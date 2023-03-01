output "compartment" {
  value = module.compartment.compartments
}

output "subnets" {
  value = module.network.subnets
  description = "The subnet OCID"
}

output "vcn" {
  value = module.network.vcn
}

output "spoke_web_subnet_ocid" {
  value = module.network.spoke_web_subnet_ocid
}

output "workload_compartment_id" {
  value = module.workload.compartment_id
}

output "stream_id" {
  value = module.logging.stream_id
}

output "key_id" {
  value = module.security.key_id
}

output "bucket" {
  value = module.logging.bucket
}

output "default_group_id" {
  value = module.logging.log_group_id
}

output "vault_id" {
  value = module.security.vault_id
}

output "rpc_id" {
  value = module.network-extension.rpc_id
}

