variable "compartment_id" {
  type        = string
  description = "The OCID of the compartment where you want to create this vault."
}

variable "display_name" {
  type        = string
  description = "The display name of the vault"
}

variable "vault_type" {
  type        = string
  description = "The type of vault to create. "
}

variable "replica_region" {
  type        = string
  description = "the region to be created replica to."
}

variable "enable_replication" {
  type        = bool
  description = "Option to enable vault replication"
}
