

variable "environment_prefix" {
  type        = string
  description = "the 1 character string representing the environment eg. P (prod), N (non-prod), D, T, U"
}

variable "workload_compartment_id" {
  type        = string
  description = "WorkLoad Compartment OCID"
}

variable "spoke_vcn_cidr" {
  type        = string
  description = "Spoke:VCN CIDR Block."
}

variable "backup_region" {
  type        = string
  description = "Name of the backup region"
}

variable "tenancy_ocid" {
  type        = string
  description = "OCID of the home tenancy"
}

variable "additional_workload_subnets_cidr_blocks" {

}
variable "customer_onprem_ip_cidr" {

}
variable "enable_nat_gateway_spoke" {

}
variable "enable_service_gateway_spoke" {

}
variable "enable_vpn_on_environment" {

}
variable "enable_vpn_or_fastconnect" {

}
variable "ipsec_connection_static_routes" {

}
variable "private_spoke_subnet_app_cidr_block" {

}
variable "private_spoke_subnet_db_cidr_block" {

}
variable "private_spoke_subnet_web_cidr_block" {

}
variable "private_subnet_cidr_block" {

}
variable "public_subnet_cidr_block" {

}