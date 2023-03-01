# ---------------------------------------------------------------------------------------------------------------------
# Return the public IP address
# ---------------------------------------------------------------------------------------------------------------------
output "public_ip" {
  value =  oci_core_instance.test_instance.public_ip
}

output "private_ip" {
  value =  oci_core_instance.test_instance.private_ip
}