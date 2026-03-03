# Input variable types

## Terraform tiene 3 tipos primitivos: string, number, bool

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


## Collection types:

```sh
variable "regions" {
  type = list(string)
}

variable "region_instance_count" {
  type = map(string)
}

variable "region_set" {
  type = set(string)
}
```
Lista: Es ordenada (index 0,1,2). Permite duplicaods. Se puede acceder por el índice var.list[0]
Set: Desordenado. No admite duplicados. Se debe iterar para acceder a los items.


```prod.tfvars```

```sh
env_name        = "prod"
instance_count  = 5
enabled         = false
regions         = ["westeu", "easteu"]
region_instance_count = {
    "westeu" = 4
    "easteu" = 8
}

```
```outputs.tf```

```sh
output "primary_region" {
  value = var.regions[0]
}

output "primary_region_instance" {
  value = var.region_instance_count["easteu"]
}
```

```sh
$ terraform apply -var-file ./env/prod.tfvars
var.api_key
  Enter a value: 

random_string.suffix: Refreshing state... [id=od54hq]

Changes to Outputs:
  + primary_region          = "westeu"
  + primary_region_instance = "8"
```

También se le puede pasar el índice como variable, siempre que exista.

```sh
output "primary_region_instance" {
  value = var.region_instance_count[var.regions[0]]
}
```

Si cambio el valor a ```var.region_instance_count[var.regions[0]]``` 
```sh
Changes to Outputs:
  ~ primary_region_instance = "4" -> "8"
```
It works!

## Complex types


```prod.tfvars```

```sh
env_name        = "prod"
instance_count  = 5
enabled         = false
regions         = ["westeu", "easteu"]
region_instance_count = {
    "westeu" = 4
    "easteu" = 8
}

```
```outputs.tf```

```sh
output "primary_region" {
  value = var.regions[0]
}

output "primary_region_instance" {
  value = var.region_instance_count["easteu"]
}
```