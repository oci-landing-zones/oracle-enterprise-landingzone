variable "compartment_id" {
  type        = string
  description = "The OCID of the compartment where the bastion is located"
}

variable "target_subnet_id" {
  type        = string
  description = "The OCID of the subnet that the bastion connects to"
}

variable "bastion_client_cidr_block_allow_list" {
  type        = list(string)
  description = "A list of address ranges in CIDR notation that you want to allow to connect to sessions hosted by this bastion."
}

variable "bastion_name" {
  type        = string
  description = "The name of the bastion, which can't be changed after creation."
}
