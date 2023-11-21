output "spoke_web_subnet_ocid" {
  value = module.spoke.spoke_web_subnet_ocid
  description = "Spoke Web Subnet OCID."
}
output "subnets" {
  value = merge(module.hub_backup.subnets, module.spoke.subnets)
  description = "Hub & Spoke Subnet."
}