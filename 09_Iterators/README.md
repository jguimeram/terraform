# Iterators

## List and Count

```sh
resource "random_string" "list" {
  count   = 2
  length  = 6
  upper   = false
  special = false
}

```

Al lanzar el ```terraform apply``` me indica que creará dos random_string (valor de count)

```sh

Terraform will perform the following actions:

  # random_string.list[0] will be created
  + resource "random_string" "list" {
      + id          = (known after apply)
      + length      = 6
      + lower       = true
      + min_lower   = 0
      + min_numeric = 0
      + min_special = 0
      + min_upper   = 0
      + number      = true
      + numeric     = true
      + result      = (known after apply)
      + special     = false
      + upper       = false
    }

  # random_string.list[1] will be created
  + resource "random_string" "list" {
      + id          = (known after apply)
      + length      = 6
      + lower       = true
      + min_lower   = 0
      + min_numeric = 0
      + min_special = 0
      + min_upper   = 0
      + number      = true
      + numeric     = true
      + result      = (known after apply)
      + special     = false
      + upper       = false
    }

Plan: 2 to add, 0 to change, 0 to destroy.
```

El valor de count puede ser la variable ```length(var.regions)```:

```sh
resource "random_string" "list" {
  count   = length(var.regions)
  length  = 6
  upper   = false
  special = false
}
```

## Maps

```sh
resource "random_string" "map" {
  for_each = var.region_instance_count
  length   = 6
  upper    = false
  special  = false
}
```

```sh
Terraform will perform the following actions:

  # random_string.map["easteu"] will be created
  + resource "random_string" "map" {
      + id          = (known after apply)
      + length      = 6
      + lower       = true
      + min_lower   = 0
      + min_numeric = 0
      + min_special = 0
      + min_upper   = 0
      + number      = true
      + numeric     = true
      + result      = (known after apply)
      + special     = false
      + upper       = false
    }

  # random_string.map["westeu"] will be created
  + resource "random_string" "map" {
      + id          = (known after apply)
      + length      = 6
      + lower       = true
      + min_lower   = 0
      + min_numeric = 0
      + min_special = 0
      + min_upper   = 0
      + number      = true
      + numeric     = true
      + result      = (known after apply)
      + special     = false
      + upper       = false
    }

Plan: 2 to add, 0 to change, 0 to destroy.
```

# Booleans and Conditionals

Utiliza operario ternario para construir el condicional:

```sh
resource "random_string" "if" {

  count = var.enabled ? 1 : 0

  length  = 6
  upper   = false
  special = false
}

```
En el archivo ```prod.tfvars``` he modificado el valor de enabled a ```true``` y al lanzar ```terraform apply``` detecta el cambio y lo aplica gracias al if.

```sh
Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # random_string.if[0] will be created
  + resource "random_string" "if" {
      + id          = (known after apply)
      + length      = 6
      + lower       = true
      + min_lower   = 0
      + min_numeric = 0
      + min_special = 0
      + min_upper   = 0
      + number      = true
      + numeric     = true
      + result      = (known after apply)
      + special     = false
      + upper       = false
    }

Plan: 1 to add, 0 to change, 0 to destroy.
```