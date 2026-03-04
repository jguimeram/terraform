output "app_name" {
  value = var.app_name
}


output "env_name" {
  value = var.env_name
}


output "env_prefix" {
  value = local.environment_prefix /* variable declarada en main.tf */
}


output "suffix" {
  value = random_string.suffix.result /* resource "random_string" "suffix" */
}


output "api_key" {
  value     = var.api_key
  sensitive = true
}

output "primary_region" {
  value = var.regions[0]
}

output "primary_region_instance" {
  value = var.region_instance_count[var.regions[1]]
}

output "kind" {
  value = var.sku_settings.kind
}


output "module1" {
  value = module.module.random_string
}

output "module2" {
  value = module.module2.random_string
}
