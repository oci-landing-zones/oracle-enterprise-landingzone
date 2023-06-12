
variable "environment_prefix" {
  type        = string
  description = "the 1 character string representing the environment eg. P (prod), N (non-prod), D, T, U"
}
variable "tenancy_ocid" {
  type        = string
  description = "The OCID of tenancy"
}

variable "region" {
  type        = string
  description = "The OCI region"
}

variable "workload_spoke_vcn_cidr" {
  description = "The list of IPv4 CIDR blocks the VCN will use."
  type        = string
}
variable "vcn_dns_label" {
  description = "A DNS label for the VCN, used in conjunction with the VNIC's hostname and subnet's DNS label to form a fully qualified domain name (FQDN) for each VNIC within this subnet"
  type        = string
}
variable "workload_private_spoke_subnet_lb_cidr_block" {
  type        = string
  description = "Workload Enivornment Spoke Load Balancer VCN CIDR Block."
}
variable "workload_private_spoke_subnet_app_cidr_block" {
  type        = string
  description = "Workload Enivornment Spoke Application VCN CIDR Block."
}
variable "workload_private_spoke_subnet_client_cidr_block" {
  type        = string
  description = "Workload Enivornment Spoke Client(Exadata) VCN CIDR Block."
}
variable "workload_private_spoke_subnet_backup_cidr_block" {
  type        = string
  description = "Workload Enivornment Spoke Backup VCN CIDR Block."
}

variable "workload_private_spoke_subnet_lb_dns_label" {
  description = "A DNS label for the Load Balancer Subnet"
  type        = string
}
variable "workload_private_spoke_subnet_app_dns_label" {
  description = "A DNS label for the App Subnet"
  type        = string
}
variable "workload_private_spoke_subnet_client_dns_label" {
  description = "A DNS label for the Client (Exadata) Subnet"
  type        = string
}
variable "workload_private_spoke_subnet_backup_dns_label" {
  description = "A DNS label for the Backup Subnet"
  type        = string
}

variable "nat_gateway_display_name" {
  description = "(Updatable) Name of NAT Gateway. Does not have to be unique."
  type        = string
}

variable "service_gateway_display_name" {
  description = "(Updatable) Name of Service Gateway. Does not have to be unique."
  type        = string
}

variable "workload_compartment_name" {
  type        = string
  description = "The name of the workload compartment by default OCI-ELZ-<Workload Name>-<Region>."
}

variable "enable_nat_gateway_spoke" {
  type = bool
}

variable "nat_gw_spoke_check" {
  type    = list(string)
  default = [""]
}

variable "service_gw_spoke_check" {
  type = list(string)
}
variable "drg_id" {
  type = string
}
variable "hub_vcn_cidr_block" {
  type = string
}
variable "hub_public_subnet_cidr_block" {
  type = string
}
variable "hub_private_subnet_cidr_block" {
  type = string
}
variable "workload_compartment_id" {
  type = string
}
variable "vcn_display_name" {
  type        = string
  description = "Workload Expansion Spoke VCN Display Name"
}
variable "workload_private_spoke_subnet_lb_display_name" {
  type        = string
  description = "Workload Expansion Spoke Load balancer Subnet Display Name."
}
variable "workload_private_spoke_subnet_app_display_name" {
  type        = string
  description = "Workload Expansion Spoke App Subnet Display Name."
}
variable "workload_private_spoke_subnet_client_display_name" {
  type        = string
  description = "Workload Expansion Spoke Client (Exadata) Subnet Display Name."
}
variable "workload_private_spoke_subnet_backup_display_name" {
  type        = string
  description = "Workload Expansion Spoke Backup Subnet Display Name."
}
variable "route_table_display_name" {
  type        = string
  description = "Workload Expansion Spoke Route Table Name Disply Name."
}
variable "security_list_display_name" {
  type        = string
  description = "Workload Expansion Spoke Security List Name Disly Name."
}
variable "enable_vpn_or_fastconnect" {}
variable "enable_vpn_on_environment" {}
variable "ipsec_connection_static_routes" {}
variable "customer_onprem_ip_cidr" {}

variable "db_port" {
  type        = number
  description = "Database Port. Default 1521."
}
variable "enable_fan_events" {
  type        = bool
  description = "Security List to be enabled for ONS FAN events"
}
