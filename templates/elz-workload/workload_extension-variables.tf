# -----------------------------------------------------------------------------
# Network Variables
# -----------------------------------------------------------------------------
variable "workload_expansion_flag" {
  type        = bool
  description = "Set to true if you want to use this as independent Workload Expansion Deployment Stack."
  default     = false
  validation {
    condition     = can(regex("^([t][r][u][e]|[f][a][l][s][e])$", var.workload_expansion_flag))
    error_message = "The workload_expansion_flag variable must be either true or false."
  }
}

variable "workload_private_spoke_subnet_web_cidr_block" {
  type        = string
  description = "Workload Enivornment Spoke VCN CIDR Block."
  validation {
    condition     = can(cidrhost(var.workload_private_spoke_subnet_web_cidr_block, 0))
    error_message = "Must be valid IPv4 CIDR."
  }
}

variable "workload_private_spoke_subnet_app_cidr_block" {
  type        = string
  description = "Workload Enivornment Spoke VCN CIDR Block."
  validation {
    condition     = can(cidrhost(var.workload_private_spoke_subnet_app_cidr_block, 0))
    error_message = "Must be valid IPv4 CIDR."
  }
}

variable "workload_private_spoke_subnet_db_cidr_block" {
  type        = string
  description = "Workload Enivornment Spoke VCN CIDR Block."
  validation {
    condition     = can(cidrhost(var.workload_private_spoke_subnet_db_cidr_block, 0))
    error_message = "Must be valid IPv4 CIDR."
  }
}

variable "workload_spoke_vcn_cidr" {
  description  = "IPv4 CIDR blocks the VCN will use."
  type         = string
}


variable "enable_nat_gateway_spoke" {
  type    = bool
  default = false
  validation {
    condition         = can(regex("^([t][r][u][e]|[f][a][l][s][e])$", var.enable_nat_gateway_spoke))
    error_message     = "The variable must be either true or false."
  }
}

variable "enable_service_gateway_spoke" {
  type    = bool
  default = false
  validation {
    condition         = can(regex("^([t][r][u][e]|[f][a][l][s][e])$", var.enable_service_gateway_spoke))
    error_message     = "The variable must be either true or false."
  }
}


variable "vcn_dns_label" {
    description = "A DNS label for the VCN, used in conjunction with the VNIC's hostname and subnet's DNS label to form a fully qualified domain name (FQDN) for each VNIC within this subnet"
    type        = string
    default     = "spokelabel"
    validation {
      condition     = length(var.vcn_dns_label) < 16
      error_message = "DNS Label : Max 15 alphanumeric characters allowed."
  }
}

variable "enable_internet_gateway_spoke" {
  type    = bool
  default = false
  validation {
    condition     = can(regex("^([t][r][u][e]|[f][a][l][s][e])$", var.enable_internet_gateway_spoke))
    error_message = "The workload_expansion_flag variable must be either true or false."
  }
}


variable "workload_private_spoke_subnet_web_dns_label" {
    description = "A DNS label for the VCN Subnet, used in conjunction with the VNIC's hostname and subnet's DNS label to form a fully qualified domain name (FQDN) for each VNIC within this subnet"
    type        = string
    default     = "webdnslabel"
    validation {
      condition     = length(var.workload_private_spoke_subnet_web_dns_label) < 16
      error_message = "DNS Label : Max 15 alphanumeric characters allowed."
    }
}

variable "workload_private_spoke_subnet_app_dns_label" {
    description = "A DNS label for the VCN Subnet, used in conjunction with the VNIC's hostname and subnet's DNS label to form a fully qualified domain name (FQDN) for each VNIC within this subnet"
    type        = string
    default     = "appdnslabel"
    validation {
      condition     = length(var.workload_private_spoke_subnet_app_dns_label) < 16
      error_message = "DNS Label : Max 15 alphanumeric characters allowed."
    }
}

variable "workload_private_spoke_subnet_db_dns_label" {
    description = "A DNS label for the VCN Subnet, used in conjunction with the VNIC's hostname and subnet's DNS label to form a fully qualified domain name (FQDN) for each VNIC within this subnet"
    type        = string
    default     = "dbdnslabel"
    validation {
      condition     = length(var.workload_private_spoke_subnet_db_dns_label) < 16
      error_message = "DNS Label : Max 15 alphanumeric characters allowed."
    }
}

variable "nat_gateway_display_name" {
  description = "(Updatable) Name of NAT Gateway. Does not have to be unique."
  type        = string
  default     = "ngw"
}

variable "service_gateway_display_name" {
  description = "(Updatable) Name of Service Gateway. Does not have to be unique."
  type        = string
  default     = "sgw"
}

variable "nat_gw_spoke_check" {
  type    = list(string)
  default = [""]
}

variable "service_gw_spoke_check" {
  type    = list(string)
  default = [""]
}

variable "workload_prefix" {
  type        = string
  description = "Atleast 4 Alphanumeric Charater to Describe the Workload : WRK1"
  default     = "WRK1"
}

variable "vcn_display_name" {
  type        = string
  description = "Workload Expansion Spoke VCN Display Name"
  default     = ""
}

variable "workload_private_spoke_subnet_web_display_name" {
  type        = string
  description = "Workload Expansion Spoke Web Subnet Display Name."
  default     = ""
}

variable "workload_private_spoke_subnet_app_display_name" {
  type        = string
  description = "Workload Expansion Spoke App Subnet Display Name."
  default     = ""
}

variable "workload_private_spoke_subnet_db_display_name" {
  type        = string
  description = "Workload Expansion Spoke Db Subnet Display Name."
  default     = ""
}

variable "route_table_display_name" {
  type        = string
  description = "Workload Expansion Spoke Route Table Name Disply Name."
  default     = ""
}

variable "security_list_display_name" {
  type        = string
  description = "Workload Expansion Spoke Security List Name Disly Name."
  default     = ""
}

variable "drg_id" {
  type    = string
  validation {
    condition     = can(regex("^drg$", split(".", var.drg_id)[1]))
    error_message = "Only Compartment OCID is allowed."
  }
}

variable "hub_public_subnet_cidr_block" {
  type    = string
  default = "10.1.1.0/24"
  validation {
    condition     = can(cidrhost(var.hub_public_subnet_cidr_block, 0))
    error_message = "Must be valid IPv4 CIDR."
  }
}

variable "hub_private_subnet_cidr_block" {
  type    = string
  default = "10.1.2.0/24"
  validation {
    condition     = can(cidrhost(var.hub_private_subnet_cidr_block, 0))
    error_message = "Must be valid IPv4 CIDR."
  }
}
