# ============ Provider variables.  
#variable "tenancy_ocid" {
#  type        = string
#  description = "the ocid of tenancy"
#}
# ===================================

variable "compartment_ocid" {
  type        = string
  description = "the ocid of the compartment instances will live in. Defaults to tenancy root."
  default = ""
}

variable "compartment_replication_delay" {
  type         = string
  description  =  "delay to allow compartments to replicate"
  default      = "90s"
}

variable "ssh_public_key_list" {
  type        = list(string)
  description = "The list of ssh public keys"
}

variable "test_instance_shape" {
  type        = string
  description = "Test Instance Shape"
  default     = "VM.Standard.E4.Flex"
}

# ====== Network Module test parameters. 
variable "environment_prefix" {
  type = string
  description = "1 char env prefix"
  default = "P"
}

variable "vcn_cidr_block" {
  type = string
  description = "Hub vcn CIDR"
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr_block" {
  type = string
  description = "Hub public subnet CIDR"
  default = "10.0.0.0/24"

}

variable "private_subnet_cidr_block" {
  type = string
  description = "Hub private subnet CIDR"
  default = "10.0.1.0/24"
}


variable "private_spoke_subnet_web_cidr_block" {
  type    = string
  default = "10.1.1.0/24"

}

variable "private_spoke_subnet_app_cidr_block" {
  type    = string
  default = "10.1.2.0/24"

}

variable "private_spoke_subnet_db_cidr_block" {
  type    = string
  default = "10.1.3.0/24"

}

variable "spoke_vcn_cidr" {
  type    = string
  default = "10.1.0.0/16"
}

variable "additional_workload_subnets_cidr_blocks" {
  type    = list(string)
  default = []
}