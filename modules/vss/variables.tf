# -----------------------------------------------------------------------------
# Common Variables
# -----------------------------------------------------------------------------
variable "recipe_compartment_ocid" {
  type        = string
  description = "the compartment ocid"
}

# -----------------------------------------------------------------------------
# VSS Host Scan Recipe Variables
# -----------------------------------------------------------------------------
variable "host_scan_recipe_display_name" {
  type        = string
  description = "Vulnerability scanning service display name"
}

variable "host_scan_recipe_agent_settings_scan_level" {
  type        = string
  description = "Vulnerability scanning service agent scan level"
}

variable "host_scan_recipe_agent_settings_agent_configuration_vendor" {
  type        = string
  description = "Vulnerability scanning service agent vendor"
  default     = "OCI"
}

variable "host_scan_recipe_port_settings_scan_level" {
  type        = string
  description = "Vulnerability scanning service port scan level"
}

variable "vss_scan_schedule" {
  type        = string
  description = "Vulnerability scanning service scan schedule"
}

variable "agent_cis_benchmark_settings_scan_level" {
  type        = string
  description = "Agent benchmarking settings scan level"
}

variable "target_compartment_ocid" {
  type        = string
  description = "the compartment ocid of the vss target"
}

variable "host_scan_target_display_name" {
  type        = string
  description = "Vulnerability scanning service target display name"
}

variable "host_scan_target_description" {
  type        = string
  description = "Vulnerability scanning service target description"
  default     = "Vulnerability scanning service scan target"
}