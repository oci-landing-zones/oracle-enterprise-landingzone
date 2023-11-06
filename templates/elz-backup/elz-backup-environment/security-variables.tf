variable "create_master_encryption_key" {
  type        = bool
  description = "Option create master encryption key"
}

variable "enable_replication" {
  type        = bool
  description = "Option to enable vault replication"
}

variable "replica_region" {
  type        = string
  description = "the region to be created replica to."
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
}