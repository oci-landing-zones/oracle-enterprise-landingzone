
variable "create_nat_gateway" {
  type        = bool
}
variable "create_service_gateway" {
  type        = bool
}
variable "nat_network_compartment_id" {
  type        = string
}
variable "nat_vcn_id" {
  type        = string
}
variable "nat_gateway_display_name" {
  type        = string
}
variable "sgw_network_compartment_id" {
  type        = string
}
variable "sgw_vcn_id" {
  type        = string
}
variable "service_gateway_display_name" {
  type        = string
}

