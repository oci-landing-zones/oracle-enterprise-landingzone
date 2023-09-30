variable "enable_network_firewall" {
  type        = bool
  description = "Enable Network Firewall in Enviornment."
}
variable "enable_traffic_threat_log" {
  type        = bool
  description = "Enable Network Firewall Threat and Traffic Logs in Enviornment."
}
variable "nfw_subnet_type" {
  type        = string
  description = "Network Firewall Subnet Type."
}
variable "nfw_instance_name" {
  type        = string
  description = "Network Firewall Instance Name."
}
variable "nfw_instance_policy" {
  type        = string
  description = "Network Firewall Instance Policy Name."
}
variable "nfw_use_existing_network" {
  type        = bool
  description = "Use Existing VCN in place Network Firewall."
}