
resource "random_string" "suffix" {
  length  = 6
  upper   = false
  special = false
}

/* local vars */

locals {
  environment_prefix = "${var.app_name}-${var.env_name}-${random_string.suffix.result}"
}

/* list iterator */
resource "random_string" "list" {
  count   = length(var.regions)
  length  = 6
  upper   = false
  special = false
}


resource "random_string" "map" {
  for_each = var.region_instance_count
  length   = 6
  upper    = false
  special  = false
}

