
##############################################################################
###########                     CREATE SPOKE                        ##########
##############################################################################

locals {
  vcn_spoke = {
    name      = "OCI-ELZ-VCN-${var.environment_prefix}-SPK-BACKUP-${local.region_key[0]}001"
    dns_label = "backupspoke"
  }
}

module "spoke" {
  source                                         = "../elz-backup-spoke"
  vcn_display_name                               = local.vcn_spoke.name
  vcn_dns_label                                  = local.vcn_spoke.dns_label
  workload_compartment_id                        = var.workload_compartment_id
  workload_spoke_vcn_cidr                        = var.spoke_vcn_cidr

  providers = {
    oci.backup_region = oci.backup_region
  }
}
