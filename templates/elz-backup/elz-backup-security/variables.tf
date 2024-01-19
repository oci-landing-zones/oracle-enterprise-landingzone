##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

variable "resource_label" {
  type        = string
  description = "Prefix used to avoid naming conflict"
}

variable "environment_prefix" {
  type        = string
  description = "the 1 character string representing the environment eg. P (prod), N (non-prod), D, T, U"
}

variable "tenancy_ocid" {
  type        = string
  description = "OCID of the home tenancy"
}

variable "vault_type" {
  type        = string
  description = "The type of vault to create. "
}

variable "create_master_encryption_key" {
  type        = bool
  description = "Option create master encryption key"
}

variable "backup_region" {
  type        = string
  description = "Name of the backup region"
}

variable "security_compartment_id" {
  type        = string
  description = "The OCID of security compartment"
}

variable "enable_replication" {
  type        = bool
  description = "Option to enable vault replication"
}

variable "replica_region" {
  type        = string
  description = "the region to be created replica to."
}

variable "home_compartment_id" {
  type        = string
  description = "the OCID of the compartment where the environment will be created. In general, this should be the Landing zone parent compartment."
}

variable "environment_compartment_id" {
  type        = string
  description = "the OCID of the environment compartment"
}

variable "bastion_target_subnet_id" {
  type        = string
  description = "The OCID of the subnet that the bastion connects to"
}

variable "bastion_client_cidr_block_allow_list" {
  type        = list(string)
  description = "A list of address ranges in CIDR notation that you want to allow to connect to sessions hosted by this bastion."
}