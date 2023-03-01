output "bastion_ip" {
  value = module.bastion.public_ip
}

output "private_test_node_ips" {
  value = module.test_nodes[*].private_ip  
}

# used in subnet names. 
output "region_key" {
  value = local.region_key[0]
}

# used in subnet names. 
output "environmant_prefix"{
  value = var.environment_prefix
}