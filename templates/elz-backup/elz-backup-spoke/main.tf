######################################################################
#                  Create Workload VCN Spoke                         #
######################################################################
module "backup_workload_spoke_vcn" {
  source = "../../../modules/vcn"

  vcn_cidrs           = [var.workload_spoke_vcn_cidr]
  compartment_ocid_id = var.workload_compartment_id
  vcn_display_name    = var.vcn_display_name
  vcn_dns_label       = var.vcn_dns_label
  enable_ipv6         = false

}