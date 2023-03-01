output "key_id" {
  value = local.create_key ? module.key[0].key_ocid : null
}

output "bastion_id" {
  value = var.enable_bastion ? module.bastion[0].bastion_ocid : null
}

output "vault_id" {
  value = var.vault_type != "NONE" ? module.vault[0].management_endpoint : null 
}