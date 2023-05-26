###########################################################################
#######          WORKLOAD MONITORING ALARMS DEFINITION             ########
###########################################################################
locals {
  workload_critical_topic = {
    topic_name            = "${var.environment_prefix}-${var.workload_name}-Critical"
    topic_description     = "OCI Landing Zone Critical Workload Topic"
    subscription_protocol = "EMAIL"
  }
  workload_warning_topic = {
    topic_name            = "${var.environment_prefix}-${var.workload_name}-Warning"
    topic_description     = "OCI Landing Zone Warning Workload Topic"
    subscription_protocol = "EMAIL"
  }
  # alarm_policy = {
  #   name        = "${var.environment_prefix}-Policy"
  #   description = "OCI Alarm Policy"

  #   statements = [
  #     <<EOT
  #       Allow group OCI-ELZ-${var.environment_prefix}-IDT/OCI-ELZ-UGP-${var.environment_prefix}-NET-ADMIN  to read metrics in compartment id ${var.environment_compartment_id} where any {
  #         target.metrics.namespace='oci_vcn',
  #         target.metrics.namespace='oci_vpn',
  #         target.metrics.namespace='oci_fastconnect',
  #         target.metrics.namespace='oci_service_gateway',
  #         target.metrics.namespace='oci_nat_gateway',
  #         target.metrics.namespace='oci_internet_gateway',
  #         target.metrics.namespace='oci_lbaas',
  #         target.metrics.namespace='oci_network_firewall'
  #       }
  #     EOT
  #   ]
  # }

  workload_alarms = {
    metric_compartment_id_in_subtree = false
    is_enabled                       = var.enable_workload_monitoring_alarms
    message_format                   = "ONS_OPTIMIZED"
    pending_duration                 = "PT5M"

    workload_alarms_critical_map = {
      compute_instance_status_alarm = {
        display_name          = "compute_instance_status_alarm"
        metric_compartment_id = module.workload_compartment.compartment_id
        namespace             = "oci_compute_infrastructure_health"
        query                 = "instance_status[1m].sum() > 0"
        severity              = "CRITICAL"
      }
      compute_vm_instance_status_alarm = {
        display_name          = "compute_vm_instance_status_alarm"
        metric_compartment_id = module.workload_compartment.compartment_id
        namespace             = "oci_compute_infrastructure_health"
        query                 = "maintenance_status[1m].sum() > 0"
        severity              = "CRITICAL"
      }
      compute_bare_metal_unhealthy_alarm = {
        display_name          = "compute_bare_metal_unhealthy_alarm"
        metric_compartment_id = module.workload_compartment.compartment_id
        namespace             = "oci_compute_infrastructure_health"
        query                 = "health_status[1m].count() > 0"
        severity              = "CRITICAL"
      }
      compute_high_compute_alarm = {
        display_name          = "compute_high_compute_alarm"
        metric_compartment_id = module.workload_compartment.compartment_id
        namespace             = "oci_computeagent"
        query                 = "CpuUtilization[1m].mean() > 80"
        severity              = "CRITICAL"
      }
      compute_high_memory_alarm = {
        display_name          = "compute_high_memory_alarm"
        metric_compartment_id = module.workload_compartment.compartment_id
        namespace             = "oci_computeagent"
        query                 = "MemoryUtilization[1m].mean() > 80"
        severity              = "CRITICAL"
      }
      database_adb_cpu_alarm = {
        display_name          = "database_cluster_cpu_alarm"
        metric_compartment_id = module.workload_compartment.compartment_id
        namespace             = "oci_database_cluster"
        query                 = "CpuUtilization[1m].mean() > 80"
        severity              = "CRITICAL"
      }
      database_adb_cpu_alarm = {
        display_name          = "database_cluster_memory_alarm"
        metric_compartment_id = module.workload_compartment.compartment_id
        namespace             = "oci_database_cluster"
        query                 = "MemoryUtilization[1m].mean() > 80"
        severity              = "CRITICAL"
      }
      database_adb_cpu_alarm = {
        display_name          = "database_adb_cpu_alarm"
        metric_compartment_id = module.workload_compartment.compartment_id
        namespace             = "oci_autonomous_database"
        query                 = "CpuUtilization[1m].mean() > 80"
        severity              = "CRITICAL"
      }
      database_adb_cpu_alarm = {
        display_name          = "database_adb_storage_alarm"
        metric_compartment_id = module.workload_compartment.compartment_id
        namespace             = "oci_autonomous_database"
        query                 = "StorageUtilization[1m].mean() > 80"
        severity              = "CRITICAL"
      }
      database_adb_storage_alarm = {
        display_name          = "database_adb_availability_alarm"
        metric_compartment_id = module.workload_compartment.compartment_id
        namespace             = "oci_autonomous_database"
        query                 = "DatabaseAvailability[1m].mean() = 0"
        severity              = "CRITICAL"
      }
      network_lbUnHealthyBackendServers_alarm = {
        display_name          = "network_lbUnHealthyBackendServers_alarm"
        metric_compartment_id = module.workload_compartment.compartment_id
        namespace             = "oci_lbaas"
        query                 = "UnHealthyBackendServers[1m].mean() > 0"
        severity              = "CRITICAL"
      }
      network_lbFailedSSLClientCertVerify_alarm = {
        display_name          = "network_lbFailedSSLClientCertVerify_alarm"
        metric_compartment_id = module.workload_compartment.compartment_id
        namespace             = "oci_lbaas"
        query                 = "FailedSSLClientCertVerify[1m].mean() > 0"
        severity              = "CRITICAL"
      }
      network_lbFailedSSLHandshake_alarm = {
        display_name          = "network_lbFailedSSLHandshake_alarm"
        metric_compartment_id = module.workload_compartment.compartment_id
        namespace             = "oci_lbaas"
        query                 = "FailedSSLHandshake[1m].mean() > 0"
        severity              = "CRITICAL"
      }
      network_vcnVnicConntrackIsFull_alarm = {
        display_name          = "network_vcnVnicConntrackIsFull_alarm"
        metric_compartment_id = module.workload_compartment.compartment_id
        namespace             = "oci_vcn"
        query                 = "VnicConntrackIsFull[1m].mean() > 0"
        severity              = "CRITICAL"
      }
    }

    workload_alarms_warning_map = {
      objectstorage_UncommittedParts_alarm = {
        display_name          = "objectstorage_UncommittedParts_alarm"
        metric_compartment_id = module.workload_compartment.compartment_id
        namespace             = "oci_objectstorage"
        query                 = "UncommittedParts[1m].count() > 0"
        severity              = "WARNING"
      }
      objectstorage_ClientErrors_alarm = {
        display_name          = "objectstorage_ClientErrors_alarm"
        metric_compartment_id = module.workload_compartment.compartment_id
        namespace             = "oci_objectstorage"
        query                 = "ClientErrors[1m].sum() > 0"
        severity              = "WARNING"
      }
      network_lbPeakBandwidth_alarm = {
        display_name          = "network_lbPeakBandwidth_alarm"
        metric_compartment_id = module.workload_compartment.compartment_id
        namespace             = "oci_lbaas"
        query                 = "PeakBandwidth[1m].mean() < 8"
        severity              = "WARNING"
      }
      network_vcnVnicConntrackUtilPercent_alarm = {
        display_name          = "network_vcnVnicConntrackUtilPercent_alarm"
        metric_compartment_id = module.workload_compartment.compartment_id
        namespace             = "oci_vcn"
        query                 = "VnicConntrackUtilPercent[1m].mean() > 80"
        severity              = "WARNING"
      }
      network_vcnVnicEgressDropThrottle_alarm = {
        display_name          = "network_vcnVnicEgressDropThrottle_alarm"
        metric_compartment_id = module.workload_compartment.compartment_id
        namespace             = "oci_vcn"
        query                 = "VnicEgressDropThrottle[1m].mean() > 0"
        severity              = "WARNING"
      }
      network_vcnVnicIngressDropThrottle_alarm = {
        display_name          = "network_vcnVnicIngressDropThrottle_alarm"
        metric_compartment_id = module.workload_compartment.compartment_id
        namespace             = "oci_vcn"
        query                 = "VnicIngressDropThrottle[1m].mean() > 0"
        severity              = "WARNING"
      }
    }
  }
}

module "workload_critical_topic" {
  source = "../../modules/notification-topic"
  count  = var.is_create_alarms ? 1 : 0

  compartment_id        = module.workload_compartment.compartment_id
  topic_name            = local.workload_critical_topic.topic_name
  topic_description     = local.workload_critical_topic.topic_description
  subscription_endpoint = var.workload_topic_endpoints
  subscription_protocol = local.workload_critical_topic.subscription_protocol
}

module "workload_warning_topic" {
  source = "../../modules/notification-topic"
  count  = var.is_create_alarms ? 1 : 0

  compartment_id        = module.workload_compartment.compartment_id
  topic_name            = local.workload_warning_topic.topic_name
  topic_description     = local.workload_warning_topic.topic_description
  subscription_endpoint = var.workload_topic_endpoints
  subscription_protocol = local.workload_warning_topic.subscription_protocol
}

# module "workload_alarms_warning" {
#   source = "../../modules/alarms"
#   count  = var.is_create_alarms ? 1 : 0

#   compartment_id                   = module.workload_compartment.compartment_id
#   notification_topic_id            = module.workload_warning_topic[0].topic_id
#   is_enabled                       = local.workload_alarms.is_enabled
#   message_format                   = local.workload_alarms.message_format
#   pending_duration                 = local.workload_alarms.pending_duration
#   metric_compartment_id_in_subtree = local.workload_alarms.metric_compartment_id_in_subtree
#   alarm_map                        = local.workload_alarms.workload_alarms_warning_map

# }

# module "workload_alarms_critical" {
#   source = "../../modules/alarms"

#   count                            = var.is_create_alarms ? 1 : 0
#   compartment_id                   = module.workload_compartment.compartment_id
#   notification_topic_id            = module.workload_critical_topic[0].topic_id
#   is_enabled                       = local.workload_alarms.is_enabled
#   message_format                   = local.workload_alarms.message_format
#   pending_duration                 = local.workload_alarms.pending_duration
#   metric_compartment_id_in_subtree = local.workload_alarms.metric_compartment_id_in_subtree
#   alarm_map                        = local.workload_alarms.workload_alarms_critical_map

# }
