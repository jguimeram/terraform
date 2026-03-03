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


