variable "security_list_ingress_security_rules_protocol" {
  type        = string
  description = "Egress: Security List Protocol"
}

variable "security_list_ingress_security_rules_source" {
  type        = string
  description = "Ingress: Security List Protocol"
}

variable "security_list_ingress_security_rules_description" {
  type        = string
  description = "Ingress: Security List Rule Description"
}

variable "security_list_ingress_security_rules_source_type" {
  type        = string
  description = "Ingress: Security List Rule Source Type"
}

variable "security_list_egress_security_rules_destination" {
  type        = string
  description = "Egress: Security List Rule Description"
}

variable "security_list_egress_security_rules_protocol" {
  type        = string
  description = "Egress: Security List Rule Protocol"
}

variable "security_list_egress_security_rules_description" {
  type        = string
  description = "Egress: Security List Rule Description"
}

variable "security_list_egress_security_rules_destination_type" {
  type        = string
  description = "Egress: Security List Rule Destination Type"
}
variable "compartment_id" {
  type        = string
  description = "Compartment OCID ID"
}
variable "vcn_id" {
  type        = string
  description = "VCN OCID ID"
}