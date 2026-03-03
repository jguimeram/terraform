resource "random_string" "suffix" {
  length  = 6
  upper   = false
  special = false
}

/* local vars */

locals {
  environment_prefix = "${var.app_name}-${var.env_name}"
}
