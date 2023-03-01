output "subnets" {
  value = { for subnet in oci_core_subnet.subnet :
    subnet.display_name => subnet.id
  }
  description = "The subnet OCID"
}

