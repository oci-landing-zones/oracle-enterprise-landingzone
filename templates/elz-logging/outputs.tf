##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

output "log_group_id" {
  value = module.default_log_group.log_group_id
}

output "stream_id" {
  value = module.service_event_stream.stream_id
}

locals {
  standard_buckets_map = {
    "audit" : module.audit_log_bucket
    "default": module.default_log_bucket
    "service_event": module.service_event_log_bucket
  }
}

output "bucket" {
  value = local.standard_buckets_map
}
