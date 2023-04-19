#variable "compartment_id" {
#  type        = string
#  description = "The OCID of the compartment to contain the VCN."
#}

#variable "vcn_cidr_block" {
#  type        = string
#  description = "The CIDR block of VCN"
#}

#variable "vcn_display_name" {
#  type        = string
#  description = "The display name of VCN"
#}

#variable "vcn_dns_label" {
#  type        = string
#  description = "The DNS label of VCN"
#}

variable "enable_ipv6" {
  type        = bool
  default     = false
  description = "Option to enable ipv6"
}

variable "vcn_id" {
  type        = string
  description = "VCN OCID Value"
}

variable "compartment_id" {
  type        = string
  description = "the OCID of the compartment where the environment will be created. In general, this should be the Landing zone parent compartment."
}

variable "subnet_map" {
  type = map(object({
    name                       = string,
    description                = string,
    dns_label                  = string,
    cidr_block                 = string,
    prohibit_public_ip_on_vnic = bool
  }))
  description = "The map of subnets including subnet name, description, dns label, subnet cidr block."
}
variable "subnet_security_list_id" {
  type        = list(string)
  description = "Security List OCID Value."
}
variable "subnet_route_table_id" {
  type        = string
  description = "Security List OCID Value."
}