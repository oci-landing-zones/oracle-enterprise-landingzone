terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
    }
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# Create single test instance
# ---------------------------------------------------------------------------------------------------------------------
resource "oci_core_instance" "test_instance" {
  compartment_id                      = var.compartment_ocid
  availability_domain                 = var.availability_domain
  shape                               = var.instance_shape
  is_pv_encryption_in_transit_enabled = true
  display_name                        = var.hostname

  freeform_tags = {
    "Description" = "Network Test host"
    "Function"    = "Test Network connectivity."
  }

  create_vnic_details {
    assign_public_ip = var.needs_public_ip
    display_name     = "${var.hostname}-vnic"
    hostname_label   = var.hostname
    subnet_id        = var.subnet_id
  }

  shape_config {
    memory_in_gbs             = var.instance_shape_config_memory_in_gbs
    ocpus                     = var.instance_shape_config_ocpus
    baseline_ocpu_utilization = "BASELINE_1_1"
  }

  metadata = {
    ssh_authorized_keys = var.ssh_public_keys
  }

  source_details {
    source_type = "image"
    source_id   =  var.image_id
  }

  launch_options {
    is_pv_encryption_in_transit_enabled = true
    network_type                        = "PARAVIRTUALIZED"
  }

  timeouts {
    create = "10m"
  }
}
