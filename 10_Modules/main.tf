
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


resource "random_string" "if" {

  count = var.enabled ? 1 : 0

  length  = 6
  upper   = false
  special = false
}

module "module" {
  source  = "hashicorp/module/random"
  version = "1.0.0"
}

module "module2" {
  source  = "hashicorp/module/random"
  version = "1.0.0"
}
