# Hello Terraform

Se puede hacer todo en un solo archivo per por convención se divide el código tal y como se irá mostrando durante estos ejercicos.

Se pueden declarar variables sin valor:

```sh
variable "app_name" {

}
```

Al aplicar ```terraform plan``` inicia un prompt pidiendo el valor de la variable. Importante, las variables deben estar declaradas primero para que las pida por prompt. Si la variable no existe da un error:

```sh
│ Error: Value for undeclared variable
│ 
│ A variable named "hostname" was assigned on the command line, but the root module does not declare a variable of that name. To use this value, add a "variable" block to the
│ configuration.

```

```sh
$ terraform plan
var.app_name
  Enter a value: blog


Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # random_string.suffix will be created
  + resource "random_string" "suffix" {
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

Otra forma de declarar variables es 'in-line'. Una vez inicializada, ya no preguntará más por esta variable.

```$ terraform plan -var ""app_name=blog"```

```sh
Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # random_string.suffix will be created
  + resource "random_string" "suffix" {
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

───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
```

Concatenar variables desde la línea de comandos:

```$ terraform plan -var "app_name=blog" -var "env_name=dev"```

