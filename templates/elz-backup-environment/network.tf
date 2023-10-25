
module "backup-spoke" {

  source                  = "../elz-spoke"
  workload_spoke_vcn_cidr = var.workload_spoke_vcn_cidr
  workload_compartment_id = var.workload_compartment_id
  vcn_display_name        = var.vcn_display_name
  vcn_dns_label           = var.vcn_dns_label

}