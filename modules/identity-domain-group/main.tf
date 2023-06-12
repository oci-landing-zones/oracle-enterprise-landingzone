resource "null_resource" "groups" {
  count = length(var.group_names) != 0 ? 1 : 0

  triggers = {
    domain_id   = var.identity_domain_id
    group_names = "${join(",", var.group_names)}"
  }

  provisioner "local-exec" {
    working_dir = path.module
    command     = "pip3 install -r scripts/requirements.txt"
    on_failure  = continue
  }

  provisioner "local-exec" {
    working_dir = path.module
    command     = "python3 scripts/manage_identity_domain.py -u ${var.current_user_ocid} -r ${var.region} -t ${var.tenancy_ocid} -a ${var.api_fingerprint} -p ${var.api_private_key_path} -d ${var.identity_domain_id} -g ${join(" ", var.group_names)}"
    on_failure  = continue
  }
}
