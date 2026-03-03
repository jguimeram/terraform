# Input variable types

Terraform tiene 3 tipos primitivos: string, number, bool

En ```vars.tf```

```sh
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
```




