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