variable "drg_id" {
  type        = string
  description = "DRG OCID Value."
}

variable "vcn_id" {
  type        = string
  description = "VCN OCID Value"
}

variable "drg_attachment_type" {
  type        = string
  description = "DRG Attacment Network Type"
}

variable "drg_attachment_vcn_route_type" {
  type        = string
  description = "DRG Attacment Network VCN Route Type"
}
