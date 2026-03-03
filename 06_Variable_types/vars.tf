variable "app_name" {
  type = string
}

variable "env_name" {
  type = string
}

variable "api_key" {
  type      = string
  sensitive = true
}

variable "instance_count" {
  type = number
}

variable "enabled" {
  type = bool
}

