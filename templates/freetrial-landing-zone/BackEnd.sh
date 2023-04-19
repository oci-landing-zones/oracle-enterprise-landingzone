#! /bin/bash

cat <<EOT >> backend.tf
terraform {
    backend "http" {}
}
EOT