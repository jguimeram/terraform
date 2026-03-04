# Validations

```sh
variable "app_name" {
  type = string
  validation {
    condition     = length(var.app_name) <= 12
    error_message = "App name must be less than or equal to 12"
  }
}
```
En este caso ```condition``` es bool que devuele true/false y ```error_message``` un string.

Si fuerzo el error, poniendo el length, por ejemplo, a 1, el output es:

```sh
│ 
│   on terraform.auto.tfvars line 1:
│    1: app_name = "blog"
│     ├────────────────
│     │ var.app_name is "blog"
│ 
│ App name must be less than or equal to 12
│ 
│ This was checked by the validation rule at vars.tf:3,3-13.
```
Otro ejemplo, utilizando valores creados como locals en ```main.tf```, en vez de hardcodearlos.

```sh
locals {
  min_nodes = 5
  max_nodes = 9
}

```
```variables.sh```:

```sh
variable "instance_count" {
  type = number
  validation {
    condition     = var.instance_count >= local.min_nodes && var.instance_count < local.max_nodes && var.instance_count % 2 != 0
    error_message = "Must be between 5 and 10"
  }
}
```

Si fuerzo el error cambiando el valor de ```instance_count``` a 1 en ```prod.tfvars``` el output es el siguiente:

```sh
$ terraform apply -var-file ./env/prod.tfvars

│   on ./env/prod.tfvars line 2:
│    2: instance_count  = 1
│     ├────────────────
│     │ local.max_nodes is 9
│     │ local.min_nodes is 5
│     │ var.instance_count is 1
│ 
│ Must be between 5 and 10
│ 
│ This was checked by the validation rule at variables.tf:20,3-13.
```

Puedo crear un fichero llamado ```validation.tf``` y pasar ahí los locals utilizados en la validación anterior y funciona correctamente:

```sh
validation.tf

locals {
  min_nodes = 5
  max_nodes = 9
}
```
