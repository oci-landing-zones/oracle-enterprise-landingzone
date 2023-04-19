output "vcn" {
  value = module.hub.vcn_id
}

output "drg_id" {
  value = module.hub.drg_id
}

output "subnets" {
  value = merge(module.hub.subnets, module.spoke.subnets)
}

output "spoke_web_subnet_ocid" {
  value = module.spoke.spoke_web_subnet_ocid
}

output "spoke_app_subnet_ocid" {
  value = module.spoke.spoke_app_subnet_ocid
}

output "spoke_db_subnet_ocid" {
  value = module.spoke.spoke_db_subnet_ocid
}