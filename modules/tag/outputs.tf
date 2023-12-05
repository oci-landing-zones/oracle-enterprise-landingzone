##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

output "namespace_id" {
  value       = oci_identity_tag_namespace.tag_namespace.id
  description = "Tag NameSpace OCID"
}

output "tag" {
  value       = oci_identity_tag.tag
  description = "Tag Values"
}

output "tag_default" {
  value       = oci_identity_tag_default.tag_default
  description = "Tag Default Values"
}
