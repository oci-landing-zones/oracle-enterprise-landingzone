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
