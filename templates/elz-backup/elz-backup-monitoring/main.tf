locals {
  network_critical_topic = {
    topic_name            = "${var.environment_prefix}-Network-Backup-Critical-${var.resource_label}"
    topic_description     = "OCI Landing Zone Backup Critical Network Topic"
    subscription_protocol = "EMAIL"
  }

  network_warning_topic = {
    topic_name            = "${var.environment_prefix}-Network-Backup-Warning-${var.resource_label}"
    topic_description     = "OCI Landing Zone Backup Warning Network Topic"
    subscription_protocol = "EMAIL"
    event_rules = {
      lzNetWarning = {
        rule_condition    = <<EOT
          {
            "eventType":[
              "com.oraclecloud.virtualnetwork.changedhcpoptionscompartment",
              "com.oraclecloud.virtualnetwork.createdrg",
              "com.oraclecloud.virtualnetwork.deletedrg",
              "com.oraclecloud.virtualnetwork.updatedrg",
              "com.oraclecloud.virtualnetwork.createdrgattachment",
              "com.oraclecloud.virtualnetwork.deletedrgattachment",
              "com.oraclecloud.virtualnetwork.updatedrgattachment",
              "com.oraclecloud.virtualnetwork.changeinternetgatewaycompartment",
              "com.oraclecloud.virtualnetwork.createinternetgateway",
              "com.oraclecloud.virtualnetwork.deleteinternetgateway",
              "com.oraclecloud.virtualnetwork.updateinternetgateway",
              "com.oraclecloud.natgateway.changenatgatewaycompartment",
              "com.oraclecloud.natgateway.createnatgateway",
              "com.oraclecloud.natgateway.deletenatgateway",
              "com.oraclecloud.natgateway.updatenatgateway",
              "com.oraclecloud.virtualnetwork.changenetworksecuritygroupcompartment",
              "com.oraclecloud.virtualnetwork.createnetworksecuritygroup",
              "com.oraclecloud.virtualnetwork.deletenetworksecuritygroup",
              "com.oraclecloud.virtualnetwork.updatenetworksecuritygroup",
              "com.oraclecloud.virtualnetwork.addnetworksecuritygroupsecurityrules",
              "com.oraclecloud.virtualnetwork.updatenetworksecuritygroupsecurityrules",
              "com.oraclecloud.virtualnetwork.createprivateip",
              "com.oraclecloud.virtualnetwork.changepublicipcompartment",
              "com.oraclecloud.virtualnetwork.changeroutetablecompartment",
              "com.oraclecloud.virtualnetwork.createroutetable",
              "com.oraclecloud.virtualnetwork.deleteroutetable",
              "com.oraclecloud.virtualnetwork.updateroutetable",
              "com.oraclecloud.virtualnetwork.changesecuritylistcompartment",
              "com.oraclecloud.virtualnetwork.createsecuritylist",
              "com.oraclecloud.virtualnetwork.deletesecuritylist",
              "com.oraclecloud.virtualnetwork.updatesecuritylist",
              "com.oraclecloud.servicegateway.attachserviceid",
              "com.oraclecloud.servicegateway.changeservicegatewaycompartment",
              "com.oraclecloud.servicegateway.createservicegateway",
              "com.oraclecloud.servicegateway.deleteservicegateway.begin",
              "com.oraclecloud.servicegateway.deleteservicegateway.end",
              "com.oraclecloud.servicegateway.detachserviceid",
              "com.oraclecloud.servicegateway.updateservicegateway",
              "com.oraclecloud.virtualnetwork.createvcn",
              "com.oraclecloud.virtualnetwork.updatevcn",
              "com.oraclecloud.virtualnetwork.deletevcn"
            ]
          }
        EOT
        rule_display_name = "lzNetWarning"
        rule_is_enabled   = true
        rule_description  = "Network Problem Warning"
      }
    }
  }

  security_critical_topic = {
    topic_name            = "${var.environment_prefix}-Security-Backup-Critical-${var.resource_label}"
    topic_description     = "OCI Landing Zone Backup Critical Security Topic"
    subscription_protocol = "EMAIL"
    event_rules = {
      lzCgCritical = {
        rule_condition    = <<EOT
            {
              "eventType":[
                "com.oraclecloud.cloudguard.problemdetected"
              ]
            }
        EOT
        rule_display_name = "lzCgCritical"
        rule_is_enabled   = true
        rule_description  = "Security Problem Critical"
      }
    }
  }

  security_warning_topic = {
    topic_name            = "${var.environment_prefix}-Security-Backup-Warning-${var.resource_label}"
    topic_description     = "OCI Landing Zone Backup Warning Security Topic"
    subscription_protocol = "EMAIL"
    event_rules = {
      lzCgWarning = {
        rule_condition    = <<EOT
              {
                "eventType":[
                  "com.oraclecloud.cloudguard.problemthresholdreached",
                  "com.oraclecloud.cloudguard.announcements",
                  "com.oraclecloud.cloudguard.status",
                  "com.oraclecloud.cloudguard.problemdismissed",
                  "com.oraclecloud.cloudguard.problemremediated" 
                ]
              }
        EOT
        rule_display_name = "lzCgWarning"
        rule_is_enabled   = true
        rule_description  = "Security Problem Warning"
      }
    }
  }

  budget_warning_topic = {
    topic_name            = "${var.environment_prefix}-Budget-Backup-Warning-${var.resource_label}"
    topic_description     = "OCI Landing Zone Backup Warning Budget Topic"
    subscription_protocol = "EMAIL"
    event_rules = {
      lzBgtWarning = {
        rule_condition    = <<EOT
              {
                "eventType":[
                  "com.oraclecloud.budgets.deletealertrule",
                  "com.oraclecloud.budgets.updatealertrule",
                  "com.oraclecloud.budgets.updatebudget",
                  "com.oraclecloud.budgets.deletebudget"
                ]
              }
        EOT
        rule_display_name = "lzBgtWarning"
        rule_is_enabled   = true
        rule_description  = "Budget Problem Warning"
      }
    }
  }

  iam_warning_topic = {
    topic_name            = "${var.environment_prefix}-IAM-Backup-Warning-${var.resource_label}"
    topic_description     = "OCI Landing Zone Backup Warning IAM Topic"
    subscription_protocol = "EMAIL"
    event_rules = {
      lzIAMWarning = {
        rule_condition    = <<EOT
              {
                "eventType":[
                  "com.oraclecloud.identitycontrolplane.addusertogroup",
                  "com.oraclecloud.identitycontrolplane.creategroup",
                  "com.oraclecloud.identitycontrolplane.deletegroup",
                  "com.oraclecloud.identitycontrolplane.removeuserfromgroup",
                  "com.oraclecloud.identitycontrolplane.updategroup",
                  "com.oraclecloud.identitycontrolplane.createidentityprovider",
                  "com.oraclecloud.identitycontrolplane.deleteidentityprovider",
                  "com.oraclecloud.identitycontrolplane.updateidentityprovider",
                  "com.oraclecloud.identitycontrolplane.createidpgroupmapping",
                  "com.oraclecloud.identitycontrolplane.deleteidpgroupmapping",
                  "com.oraclecloud.identitycontrolplane.updateidpgroupmapping",
                  "com.oraclecloud.identitycontrolplane.createorresetmypasswordrequest",
                  "com.oraclecloud.identitycontrolplane.createpolicy",
                  "com.oraclecloud.identitycontrolplane.deletepolicy",
                  "com.oraclecloud.identitycontrolplane.updatepolicy",
                  "com.oraclecloud.identitycontrolplane.createuser",
                  "com.oraclecloud.identitycontrolplane.deleteuser",
                  "com.oraclecloud.identitycontrolplane.updateuser",
                  "com.oraclecloud.identitycontrolplane.updateusercapabilities",
                  "com.oraclecloud.identitycontrolplane.updateswiftpassword"
                ]
              }
        EOT
        rule_display_name = "lzIAMWarning"
        rule_is_enabled   = true
        rule_description  = "IAM Problem Warning"
      }
    }
  }

  announcement_subscription = {
    subscription_display_name = "${var.environment_prefix}-Security-Backup-Critical-Announcement-${var.resource_label}"
    filter_group_name         = "ELZ-Backup-Critical-Filter"
    filter_groups = {
      "compartment_filter" = {
        filters_type  = "COMPARTMENT_ID"
        filters_value = [var.environment_compartment_id]
      }
      "type_filter" = {
        filters_type  = "ANNOUNCEMENT_TYPE"
        filters_value = ["ACTION_REQUIRED", "EMERGENCY_MAINTENANCE", "EMERGENCY_CHANGE", "PRODUCTION_EVENT_NOTIFICATION"]
      }
    }
  }
}

module "network_critical_topic_backup" {
  count                 = var.is_create_alarms   ? 1 : 0

  source                = "../../../modules/notification-topic"
  compartment_id        = var.network_compartment_id
  topic_name            = local.network_critical_topic.topic_name
  topic_description     = local.network_critical_topic.topic_description
  subscription_endpoint = var.network_topic_endpoints
  subscription_protocol = local.network_critical_topic.subscription_protocol
}

module "network_warning_topic_backup" {
  count                 = var.is_create_alarms   ? 1 : 0

  source                = "../../../modules/notification-topic"
  compartment_id        = var.network_compartment_id
  topic_name            = local.network_warning_topic.topic_name
  topic_description     = local.network_warning_topic.topic_description
  subscription_endpoint = var.network_topic_endpoints
  subscription_protocol = local.network_warning_topic.subscription_protocol
  event_rules           = local.network_warning_topic.event_rules
}

module "security_critical_topic_backup" {
  count                 = var.is_create_alarms   ? 1 : 0

  source                = "../../../modules/notification-topic"
  compartment_id        = var.security_compartment_id
  topic_name            = local.security_critical_topic.topic_name
  topic_description     = local.security_critical_topic.topic_description
  subscription_endpoint = var.secops_topic_endpoints
  subscription_protocol = local.security_critical_topic.subscription_protocol
  event_rules           = local.security_critical_topic.event_rules
}

module "security_warning_topic_backup" {
  count                 = var.is_create_alarms   ? 1 : 0

  source                = "../../../modules/notification-topic"
  compartment_id        = var.security_compartment_id
  topic_name            = local.security_warning_topic.topic_name
  topic_description     = local.security_warning_topic.topic_description
  subscription_endpoint = var.secops_topic_endpoints
  subscription_protocol = local.security_warning_topic.subscription_protocol
  event_rules           = local.security_warning_topic.event_rules
}

module "budget_warning_topic_backup" {
  count                 = var.is_create_alarms   ? 1 : 0

  source                = "../../../modules/notification-topic"
  compartment_id        = var.environment_compartment_id
  topic_name            = local.budget_warning_topic.topic_name
  topic_description     = local.budget_warning_topic.topic_description
  subscription_endpoint = var.platform_topic_endpoints
  subscription_protocol = local.budget_warning_topic.subscription_protocol
  event_rules           = local.budget_warning_topic.event_rules
}

module "iam_warning_topic_backup" {
  count                 = var.is_create_alarms   ? 1 : 0

  source                = "../../../modules/notification-topic"
  compartment_id        = var.environment_compartment_id
  topic_name            = local.iam_warning_topic.topic_name
  topic_description     = local.iam_warning_topic.topic_description
  subscription_endpoint = var.identity_topic_endpoints
  subscription_protocol = local.iam_warning_topic.subscription_protocol
  event_rules           = local.iam_warning_topic.event_rules
}

module "announcement_subscription_backup" {
  count                     = var.is_create_alarms   ? 1 : 0

  source                    = "../../../modules/announcement-subscription"
  compartment_id            = var.security_compartment_id 
  notification_topic_id     = var.is_create_alarms == true ? module.security_critical_topic_backup[0].topic_id : " "
  subscription_display_name = local.announcement_subscription.subscription_display_name
  filter_groups             = local.announcement_subscription.filter_groups
}

locals {
  logging_analytics_default = {
    is_onboarded                            = true
    log_group_display_name                  = "DefaultLog-Backup-${var.environment_prefix}-${var.resource_label}"
    log_group_description                   = "Logging Analytics Backup Log Group created by Landing Zone for Default_Group"
    service_connector_display_name          = "schDefaultLog_LA"
    service_connector_source_compartment_id = var.security_compartment_id
    service_connector_source_log_group_id   = var.default_log_group_id
    service_connector_source_kind           = "logging"
  }

  logging_analytics_audit = {
    log_group_display_name                  = "AuditLog-Backup-${var.environment_prefix}-${var.resource_label}"
    log_group_description                   = "Logging Analytics Backup Log Group created by Landing Zone for AuditLog"
    service_connector_display_name          = "schAuditLog_LA"
    service_connector_source_compartment_id = var.security_compartment_id
    service_connector_source_log_group_id   = "_Audit_Include_Subcompartment"
    service_connector_source_kind           = "logging"
  }
}

resource "time_sleep" "log_delay" {
  create_duration = "600s"
}

module "logging_analytics_default" {
  count                                   = var.is_create_alarms   ? 1 : 0
  source                                  = "../../../modules/log-analytics"
  tenancy_ocid                            = var.tenancy_ocid
  compartment_id                          = var.security_compartment_id
  log_group_display_name                  = local.logging_analytics_default.log_group_display_name
  log_group_description                   = local.logging_analytics_default.log_group_description
  service_connector_display_name          = local.logging_analytics_default.service_connector_display_name
  service_connector_source_compartment_id = local.logging_analytics_default.service_connector_source_compartment_id
  service_connector_source_log_group_id   = local.logging_analytics_default.service_connector_source_log_group_id
  service_connector_source_kind           = local.logging_analytics_default.service_connector_source_kind
  depends_on = [
    time_sleep.log_delay
  ]
}

module "logging_analytics_audit" {
  count                                   = var.is_create_alarms   ? 1 : 0
  source                                  = "../../../modules/log-analytics"
  tenancy_ocid                            = var.tenancy_ocid
  compartment_id                          = var.security_compartment_id
  log_group_display_name                  = local.logging_analytics_audit.log_group_display_name
  log_group_description                   = local.logging_analytics_audit.log_group_description
  service_connector_display_name          = local.logging_analytics_audit.service_connector_display_name
  service_connector_source_compartment_id = local.logging_analytics_audit.service_connector_source_compartment_id
  service_connector_source_log_group_id   = local.logging_analytics_audit.service_connector_source_log_group_id
  service_connector_source_kind           = local.logging_analytics_audit.service_connector_source_kind
}

###########################################################################
#######              MONITORING ALARMS DEFINITION                  ########
###########################################################################

locals {
  workload_critical_topic = {
    topic_name            = "${var.environment_prefix}-Workload-Critical-${var.resource_label}"
    topic_description     = "OCI Landing Zone Critical Workload Topic"
    subscription_protocol = "EMAIL"
  }
  workload_warning_topic = {
    topic_name            = "${var.environment_prefix}-Workload-Warning-${var.resource_label}"
    topic_description     = "OCI Landing Zone Warning Workload Topic"
    subscription_protocol = "EMAIL"
  }

  alarm_policy = {
    name        = "${var.environment_prefix}-Policy-${var.resource_label}"
    description = "OCI Alarm Policy"

    statements = [
      <<EOT
        Allow group OCI-ELZ-${var.environment_prefix}-IDT/OCI-ELZ-UGP-${var.environment_prefix}-WRK-ADMIN  to read metrics in compartment id ${var.environment_compartment_id} where any {
          target.metrics.namespace='oci_vcn',
          target.metrics.namespace='oci_vpn',
          target.metrics.namespace='oci_fastconnect',
          target.metrics.namespace='oci_service_gateway',
          target.metrics.namespace='oci_nat_gateway',
          target.metrics.namespace='oci_internet_gateway',
          target.metrics.namespace='oci_lbaas',
          target.metrics.namespace='oci_network_firewall'
        }
      EOT
    ]
  }

  security_alarms = {

    metric_compartment_id_in_subtree = false
    is_enabled                       = var.enable_security_monitoring_alarms
    message_format                   = "ONS_OPTIMIZED"
    pending_duration                 = "PT5M"

    security_alarms_critical_map = {
      sch_error_alarm = {
        display_name          = "sch_error_alarm"
        metric_compartment_id = var.security_compartment_id
        namespace             = "oci_service_connector_hub"
        query                 = "ServiceConnectorHubErrors[1m].sum() > 0"
        severity              = "CRITICAL"
      }
      stream_putfault_alarm = {
        display_name          = "stream_putfault_alarm"
        metric_compartment_id = var.security_compartment_id
        namespace             = "oci_streaming"
        query                 = "PutMessagesFault.Count[1m].sum() > 0"
        severity              = "CRITICAL"
      }
      stream_getfault_alarm = {
        display_name          = "stream_getfault_alarm"
        metric_compartment_id = var.security_compartment_id
        namespace             = "oci_streaming"
        query                 = "GetMessagesFault.Count[1m].sum() > 0"
        severity              = "CRITICAL"
      }
      vss_SecurityVulnerability_alarm = {
        display_name          = "vss_SecurityVulnerability_alarm"
        metric_compartment_id = var.security_compartment_id
        namespace             = "oci_vss"
        query                 = "SecurityVulnerability[1m].sum() > 0"
        severity              = "CRITICAL"
      }
    }
    security_alarms_warning_map = {
      bastion_activesession_alarm = {
        display_name          = "bastion_activesession_alarm"
        metric_compartment_id = var.security_compartment_id
        namespace             = "oci_bastion"
        query                 = "activeSessions[1m].sum() > 0"
        severity              = "WARNING"
      }
      objectstorage_UncommittedParts_alarm = {
        display_name          = "objectstorage_UncommittedParts_alarm"
        metric_compartment_id = var.security_compartment_id
        namespace             = "oci_objectstorage"
        query                 = "UncommittedParts[1m].count() > 0"
        severity              = "WARNING"
      }
      objectstorage_ClientErrors_alarm = {
        display_name          = "objectstorage_ClientErrors_alarm"
        metric_compartment_id = var.security_compartment_id
        namespace             = "oci_objectstorage"
        query                 = "ClientErrors[1m].sum() > 0"
        severity              = "WARNING"
      }
    }
  }
  network_alarms = {
    metric_compartment_id_in_subtree = false
    is_enabled                       = var.enable_network_monitoring_alarms
    message_format                   = "ONS_OPTIMIZED"
    pending_duration                 = "PT5M"

    network_alarms_critical_map = {
      network_sgwDropsToService_alarm = {
        display_name          = "network_sgwDropsToService_alarm"
        metric_compartment_id = var.network_compartment_id
        namespace             = "oci_service_gateway"
        query                 = "sgwDropsToService[1m].mean() > 0"
        severity              = "CRITICAL"
      }
      network_sgwDropsFromService_alarm = {
        display_name          = "network_sgwDropsFromService_alarm"
        metric_compartment_id = var.network_compartment_id
        namespace             = "oci_service_gateway"
        query                 = "sgwDropsFromService[1m].mean() > 0"
        severity              = "CRITICAL"
      }
      network_oci_Internet_gateway_alarm = {
        display_name          = "network_oci_Internet_gateway_alarm"
        metric_compartment_id = var.network_compartment_id
        namespace             = "oci_internet_gateway"
        query                 = "DropsToNATgw[1m].mean() > 0"
        severity              = "CRITICAL"
      }
      network_oci_vpn_alarm = {
        display_name          = "network_oci_vpn_alarm"
        metric_compartment_id = var.network_compartment_id
        namespace             = "oci_vpn"
        query                 = "TunnelState[1m].mean() == 0"
        severity              = "CRITICAL"
      }
      network_oci_nat_gateway_alarm = {
        display_name          = "network_oci_nat_gateway_alarm"
        metric_compartment_id = var.network_compartment_id
        namespace             = "oci_vpn"
        query                 = "DropsToNATgw[1m].mean() > 0"
        severity              = "CRITICAL"
      }
      network_fast_connect_status_alarm = {
        display_name          = "network_fast_connect_status_alarm"
        metric_compartment_id = var.network_compartment_id
        namespace             = "oci_vpn"
        query                 = "ConnectionState[1m].mean() == 0"
        severity              = "CRITICAL"
      }
    }
    network_alarms_warning_map = {
      network_oci_vpn_alarm1 = {
        display_name          = "network_oci_vpn_alarm"
        metric_compartment_id = var.network_compartment_id
        namespace             = "oci_vpn"
        query                 = "PacketsError[1m].mean() > 0"
        severity              = "WARNING"
      }
      network_vcnVnicConntrackUtilPercent_alarm = {
        display_name          = "network_vcnVnicConntrackUtilPercent_alarm"
        metric_compartment_id = var.network_compartment_id
        namespace             = "oci_vpn"
        query                 = "VnicConntrackUtilPercent[1m].mean() > 80"
        severity              = "WARNING"
      }
      network_vcnVnicEgressDropThrottle_alarm = {
        display_name          = "network_vcnVnicEgressDropThrottle_alarm"
        metric_compartment_id = var.network_compartment_id
        namespace             = "oci_vpn"
        query                 = "VnicEgressDropThrottle[1m].mean() > 80"
        severity              = "WARNING"
      }
      network_vcnVnicIngressDropThrottle_alarm = {
        display_name          = "network_vcnVnicIngressDropThrottle_alarm"
        metric_compartment_id = var.network_compartment_id
        namespace             = "oci_vpn"
        query                 = "VnicIngressDropThrottle[1m].mean() > 80"
        severity              = "WARNING"
      }
    }
  }
  workload_alarms = {
    metric_compartment_id_in_subtree = false
    is_enabled                       = var.enable_workload_monitoring_alarms
    message_format                   = "ONS_OPTIMIZED"
    pending_duration                 = "PT5M"

    workload_alarms_critical_map = {
      compute_instance_status_alarm = {
        display_name          = "compute_instance_status_alarm"
        metric_compartment_id = var.workload_compartment_id
        namespace             = "oci_compute_infrastructure_health"
        query                 = "instance_status[1m].sum() > 0"
        severity              = "CRITICAL"
      }
      compute_vm_instance_status_alarm = {
        display_name          = "compute_vm_instance_status_alarm"
        metric_compartment_id = var.workload_compartment_id
        namespace             = "oci_compute_infrastructure_health"
        query                 = "maintenance_status[1m].sum() > 0"
        severity              = "CRITICAL"
      }
      compute_bare_metal_unhealthy_alarm = {
        display_name          = "compute_bare_metal_unhealthy_alarm"
        metric_compartment_id = var.workload_compartment_id
        namespace             = "oci_compute_infrastructure_health"
        query                 = "health_status[1m].count() > 0"
        severity              = "CRITICAL"
      }
      compute_high_compute_alarm = {
        display_name          = "compute_high_compute_alarm"
        metric_compartment_id = var.workload_compartment_id
        namespace             = "oci_computeagent"
        query                 = "CpuUtilization[1m].mean() > 80"
        severity              = "CRITICAL"
      }
      compute_high_memory_alarm = {
        display_name          = "compute_high_memory_alarm"
        metric_compartment_id = var.workload_compartment_id
        namespace             = "oci_computeagent"
        query                 = "MemoryUtilization[1m].mean() > 80"
        severity              = "CRITICAL"
      }
      database_adb_cpu_alarm = {
        display_name          = "database_adb_cpu_alarm"
        metric_compartment_id = var.workload_compartment_id
        namespace             = "oci_autonomous_database"
        query                 = "CpuUtilization[1m].mean() > 80"
        severity              = "CRITICAL"
      }
      database_adb_storage_alarm = {
        display_name          = "database_adb_storage_alarm"
        metric_compartment_id = var.workload_compartment_id
        namespace             = "oci_autonomous_database"
        query                 = "StorageUtilization[1m].mean() > 80"
        severity              = "CRITICAL"
      }
      network_lbUnHealthyBackendServers_alarm = {
        display_name          = "network_lbUnHealthyBackendServers_alarm"
        metric_compartment_id = var.workload_compartment_id
        namespace             = "oci_lbaas"
        query                 = "UnHealthyBackendServers[1m].mean() > 0"
        severity              = "CRITICAL"
      }
      network_lbFailedSSLClientCertVerify_alarm = {
        display_name          = "network_lbFailedSSLClientCertVerify_alarm"
        metric_compartment_id = var.workload_compartment_id
        namespace             = "oci_lbaas"
        query                 = "FailedSSLClientCertVerify[1m].mean() > 0"
        severity              = "CRITICAL"
      }
      network_lbFailedSSLHandshake_alarm = {
        display_name          = "network_lbFailedSSLHandshake_alarm"
        metric_compartment_id = var.workload_compartment_id
        namespace             = "oci_lbaas"
        query                 = "FailedSSLHandshake[1m].mean() > 0"
        severity              = "CRITICAL"
      }
      network_vcnVnicConntrackIsFull_alarm = {
        display_name          = "network_vcnVnicConntrackIsFull_alarm"
        metric_compartment_id = var.workload_compartment_id
        namespace             = "oci_vcn"
        query                 = "VnicConntrackIsFull[1m].mean() > 0"
        severity              = "CRITICAL"
      }
    }
    workload_alarms_warning_map = {
      objectstorage_UncommittedParts_alarm = {
        display_name          = "objectstorage_UncommittedParts_alarm"
        metric_compartment_id = var.workload_compartment_id
        namespace             = "oci_objectstorage"
        query                 = "UncommittedParts[1m].count() > 0"
        severity              = "WARNING"
      }
      objectstorage_ClientErrors_alarm = {
        display_name          = "objectstorage_ClientErrors_alarm"
        metric_compartment_id = var.workload_compartment_id
        namespace             = "oci_objectstorage"
        query                 = "ClientErrors[1m].sum() > 0"
        severity              = "WARNING"
      }
      network_lbPeakBandwidth_alarm = {
        display_name          = "network_lbPeakBandwidth_alarm"
        metric_compartment_id = var.workload_compartment_id
        namespace             = "oci_lbaas"
        query                 = "PeakBandwidth[1m].mean() < 8"
        severity              = "WARNING"
      }
      network_vcnVnicConntrackUtilPercent_alarm = {
        display_name          = "network_vcnVnicConntrackUtilPercent_alarm"
        metric_compartment_id = var.workload_compartment_id
        namespace             = "oci_vcn"
        query                 = "VnicConntrackUtilPercent[1m].mean() > 80"
        severity              = "WARNING"
      }
      network_vcnVnicEgressDropThrottle_alarm = {
        display_name          = "network_vcnVnicEgressDropThrottle_alarm"
        metric_compartment_id = var.workload_compartment_id
        namespace             = "oci_vcn"
        query                 = "VnicEgressDropThrottle[1m].mean() > 0"
        severity              = "WARNING"
      }
      network_vcnVnicIngressDropThrottle_alarm = {
        display_name          = "network_vcnVnicIngressDropThrottle_alarm"
        metric_compartment_id = var.workload_compartment_id
        namespace             = "oci_vcn"
        query                 = "VnicIngressDropThrottle[1m].mean() > 0"
        severity              = "WARNING"
      }
    }
  }
}

#module "workload_critical_topic" {
#   count                 = var.is_create_alarms   ? 1 : 0
#  source                = "../../../modules/notification-topic"
#  compartment_id        = var.workload_compartment_id
#  topic_name            = local.workload_critical_topic.topic_name
#  topic_description     = local.workload_critical_topic.topic_description
#  subscription_endpoint = var.workload_topic_endpoints
#  subscription_protocol = local.workload_critical_topic.subscription_protocol
#}

#module "workload_warning_topic" {
#   count                 = var.is_create_alarms   ? 1 : 0
#  source                = "../../../modules/notification-topic"
#  compartment_id        = var.workload_compartment_id
#  topic_name            = local.workload_warning_topic.topic_name
#  topic_description     = local.workload_warning_topic.topic_description
#  subscription_endpoint = var.workload_topic_endpoints
#  subscription_protocol = local.workload_warning_topic.subscription_protocol
#}

module "security_alarms_warning" {
  count                 = var.is_create_alarms   ? 1 : 0
  source                = "../../../modules/alarms"

  compartment_id                   = var.security_compartment_id
  notification_topic_id            = var.is_create_alarms == true ? module.security_warning_topic_backup[0].topic_id : " "
  is_enabled                       = local.security_alarms.is_enabled
  message_format                   = local.security_alarms.message_format
  pending_duration                 = local.security_alarms.pending_duration
  metric_compartment_id_in_subtree = local.security_alarms.metric_compartment_id_in_subtree
  alarm_map                        = local.security_alarms.security_alarms_warning_map

}

module "security_alarms_critical" {
  count                 = var.is_create_alarms   ? 1 : 0
  source                = "../../../modules/alarms"

  compartment_id                   = var.security_compartment_id
  notification_topic_id            = var.is_create_alarms == true ? module.security_critical_topic_backup[0].topic_id : " "
  is_enabled                       = local.security_alarms.is_enabled
  message_format                   = local.security_alarms.message_format
  pending_duration                 = local.security_alarms.pending_duration
  metric_compartment_id_in_subtree = local.security_alarms.metric_compartment_id_in_subtree
  alarm_map                        = local.security_alarms.security_alarms_critical_map

}

module "network_alarms_warning" {
  count                 = var.is_create_alarms   ? 1 : 0
  source                = "../../../modules/alarms"

  compartment_id                   = var.network_compartment_id
  notification_topic_id            = var.is_create_alarms == true ? module.network_warning_topic_backup[0].topic_id : " "
  is_enabled                       = local.network_alarms.is_enabled
  message_format                   = local.network_alarms.message_format
  pending_duration                 = local.network_alarms.pending_duration
  metric_compartment_id_in_subtree = local.network_alarms.metric_compartment_id_in_subtree
  alarm_map                        = local.network_alarms.network_alarms_warning_map
}

module "network_alarms_critical" {
  count                 = var.is_create_alarms   ? 1 : 0
  source                = "../../../modules/alarms"

  compartment_id                   = var.network_compartment_id
  notification_topic_id            = var.is_create_alarms == true ? module.network_critical_topic_backup[0].topic_id : " "
  is_enabled                       = local.network_alarms.is_enabled
  message_format                   = local.network_alarms.message_format
  pending_duration                 = local.network_alarms.pending_duration
  metric_compartment_id_in_subtree = local.network_alarms.metric_compartment_id_in_subtree
  alarm_map                        = local.network_alarms.network_alarms_critical_map
}

module "alarm_policy" {
  count                 = var.is_create_alarms   ? 1 : 0
  source                = "../../../modules/policies"

  compartment_ocid = var.environment_compartment_id
  policy_name      = local.alarm_policy.name
  description      = local.alarm_policy.description
  statements       = local.alarm_policy.statements
}
