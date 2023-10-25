variable "backup_region" {
  type          = string
  description   = "Backup region for the landing zone"
  default       = ""
}

variable "enable_landing_zone_replication" {
  type          = bool
  default       = false
  description   = "True if landing zone is to be replicated"
}

variable "backup_prod_workload_cidr" {
  type          = string
  description   = "Workload cidr for backup region in prod environment"
  default       = "10.6.0.0/16"
}

variable "backup_nonprod_workload_cidr" {
  type          = string
  description   = "Workload cidr for backup region in non-prod environment"
  default       = "10.7.0.0/16"
}

