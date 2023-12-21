##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

variable "create_master_encryption_key" {
  type        = bool
  description = "Option create master encryption key"
  default     = false
}

variable "enable_replication" {
  type        = bool
  description = "Option to enable vault replication"
  default     = false
}

variable "replica_region" {
  type        = string
  description = "the region to be created replica to."
  default     = ""
}

variable "resource_label" {
  type        = string
  description = "Prefix used to avoid naming conflict"
}

variable "security_compartment_id" {
  type        = string
  description = "The OCID of security compartment"
}

variable "vault_type" {
  type        = string
  description = "The type of vault to create. "
  default     = "DEFAULT"
}

variable "home_compartment_id" {
  type        = string
  description = "the OCID of the compartment where the environment will be created. In general, this should be the Landing zone parent compartment."
}

variable "environment_compartment_id" {
  type        = string
  description = "the OCID of the environment compartment"
}

variable "bastion_client_cidr_block_allow_list" {
  type        = list(string)
  description = "A list of address ranges in CIDR notation that you want to allow to connect to sessions hosted by this bastion."
  default     = ["0.0.0.0/0"]
}