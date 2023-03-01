# ---------------------------------------------------------------------------------------------------------------------
# Required inputs
# ---------------------------------------------------------------------------------------------------------------------
variable "compartment_ocid" {
  type        = string
  description = "The OCID of the compartment"
}
variable "ssh_public_keys" {
  type        = string
  description = "The ssh public keys"
}

variable "subnet_id" {
  type        = string
  description = "[Subnet] The subnet ID the instance should be connected to"
}

variable "image_id" {
  type = string
}

variable "availability_domain"  {
  type = string
}

variable "hostname" {
  type = string
}

variable needs_public_ip {
  type = bool
}

# ---------------------------------------------------------------------------------------------------------------------
# Test instance inputs
# ---------------------------------------------------------------------------------------------------------------------
variable "instance_shape" {
  type        = string
  description = "Bastion Instance Shape"
}

variable "instance_shape_config_ocpus" {
  type        = number
  description = "Number of OCPUs per instance"
  default     = 1 
}

variable "instance_shape_config_memory_in_gbs" {
  type        = number
  description = "Memory in GB per instance"
  default     = 8
}

variable "instance_operating_system_version" {
  description = "the version of Oracle Linux"
  type        = string
  default     = "8"
}
