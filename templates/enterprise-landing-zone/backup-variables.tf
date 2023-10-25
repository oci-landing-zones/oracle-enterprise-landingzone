variable "backup_region" {
  type          = string
  description   = "Backup region for the landing zone"
}

variable "enable_landing_zone_replication" {
  type          = bool
  default       = false
  description   = "True if landing zone is to be replicated"
}

variable "backup_prod_workload_cidr" {

}

variable "backup_nonprod_workload_cidr" {

}

