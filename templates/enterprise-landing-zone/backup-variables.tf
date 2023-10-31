variable "backup_region" {
  type        = string
  description = "Backup region for the landing zone"
}

variable "enable_landing_zone_replication" {
  type        = bool
  default     = false
  description = "True if landing zone is to be replicated"
}

variable "backup_prod_workload_cidr" {
  type        = string
  description = "Workload cidr for backup region in prod environment"
  default     = "10.6.0.0/16"
}

variable "backup_nonprod_workload_cidr" {
  type        = string
  description = "Workload cidr for backup region in non-prod environment"
  default     = "10.7.0.0/16"
}

variable "backup_prod_additional_workload_subnets_cidr_blocks" {
  default = []
}
variable "backup_prod_enable_nat_gateway_spoke" {
  default = true
}
variable "backup_prod_enable_service_gateway_spoke" {
  default = true
}
variable "backup_prod_enable_vpn" {
  default = false
}
variable "backup_enable_vpn_or_fastconnect" {
  default = "NONE"
}
variable "backup_prod_ipsec_connection_static_routes" {
  default = [null]
}
variable "backup_prod_spoke_subnet_app_cidr_block" {
  default = "10.6.1.0/24"
}
variable "backup_prod_spoke_subnet_db_cidr_block" {
  default = "10.6.2.0/24"
}
variable "backup_prod_spoke_subnet_web_cidr_block" {
  default = "10.6.3.0/24"
}
variable "backup_prod_hub_public_subnet_cidr_block" {
  default = "10.8.1.0/24"
}
variable "backup_prod_hub_private_subnet_cidr_block" {
  default = "10.8.2.0/24"
}

variable "backup_nonprod_additional_workload_subnets_cidr_blocks" {
  default = []
}
variable "backup_nonprod_enable_nat_gateway_spoke" {
  default = true
}
variable "backup_nonprod_enable_service_gateway_spoke" {
  default = true
}
variable "backup_nonprod_enable_vpn" {
  default = false
}
variable "backup_nonprod_ipsec_connection_static_routes" {
  default = [null]
}
variable "backup_nonprod_spoke_subnet_app_cidr_block" {
  default = "10.7.1.0/24"
}
variable "backup_nonprod_spoke_subnet_db_cidr_block" {
  default = "10.7.2.0/24"
}
variable "backup_nonprod_spoke_subnet_web_cidr_block" {
  default = "10.7.3.0/24"
}
variable "backup_nonprod_hub_private_subnet_cidr_block" {
  default = "10.9.1.0/24"
}
variable "backup_nonprod_hub_public_subnet_cidr_block" {
  default = "10.9.2.0/24"
}
