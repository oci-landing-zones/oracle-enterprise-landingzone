variable "workload_compartment_id" {
  type = string
}

variable "vcn_display_name" {
  type        = string
  description = "Workload Expansion Spoke VCN Display Name"
}

variable "vcn_dns_label" {
  description = "A DNS label for the VCN, used in conjunction with the VNIC's hostname and subnet's DNS label to form a fully qualified domain name (FQDN) for each VNIC within this subnet"
  type        = string
}

variable "workload_spoke_vcn_cidr" {
  description = "The list of IPv4 CIDR blocks the VCN will use."
  type        = string
}

variable "security_list_display_name" {

}

variable "route_table_display_name" {

}

variable "nat_gateway_display_name" {

}

variable "service_gateway_display_name" {

}

variable "enable_nat_gateway_spoke" {

}
variable "nat_gw_spoke_check" {
  type    = list(string)
  default = [""]
}
variable "enable_service_gateway_spoke" {

}
variable "service_gw_spoke_check" {
  type    = list(string)
  default = [""]
}
variable "enable_vpn_or_fastconnect" {

}
variable "enable_vpn_on_environment" {

}
variable "customer_onprem_ip_cidr" {

}
variable "additional_workload_subnets_cidr_blocks" {

}
variable "ipsec_connection_static_routes" {

}
variable "drg_id" {

}
variable "hub_public_subnet_cidr_block" {

}
variable "hub_private_subnet_cidr_block" {

}
variable "workload_private_spoke_subnet_web_display_name" {

}
variable "workload_private_spoke_subnet_web_dns_label" {

}
variable "workload_private_spoke_subnet_web_cidr_block" {

}
variable "workload_private_spoke_subnet_app_display_name" {

}
variable "workload_private_spoke_subnet_app_dns_label" {

}
variable "workload_private_spoke_subnet_app_cidr_block" {

}
variable "workload_private_spoke_subnet_db_display_name" {

}
variable "workload_private_spoke_subnet_db_dns_label" {

}
variable "workload_private_spoke_subnet_db_cidr_block" {

}