output "key_id" {
  value = local.create_key ? module.key[0].key_ocid : null
}