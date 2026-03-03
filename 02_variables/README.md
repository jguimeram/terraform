# VARIABLES

Se puede hacer todo en un solo archivo per por convención se divide el código tal y como se irá mostrando durante estos ejercicos.

## Input variales

Se pueden declarar variables sin valor. Se crean un fichero a parte (vars.tf)

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

Lanzamos ```terraform apply```

```sh
Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

random_string.suffix: Creating...
random_string.suffix: Creation complete after 0s [id=od54hq]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```

Si cambio el valor de ```env_name``` a ```prod``` desde la línea de comandos, para terraform nada cambia porque esa variable no está "conectada" a ningún resource, no necesita cambiar o mover nada para aplicar ese valor. Sin embargo, el valor de la variable se mantiene, pero sin guardarlo en el state file ```terraform.tfstate```. La variable reside en memoria hasta que se vuelve a ejecutar el ```terraform apply```

## Local variables

En el mismo main se pueden declarar variables locales:

```sh
locals {
  environment_prefix = "blog-dev"
}
```

Al ejecutar ```terraform apply```, dirá que 'no changes' a pesar de estas variables. Esto es así porque no tienen impatco en el output de la ejecución de terraform.


# Output variables

Permiten extraer las variables hacia los registros, o programas externos.

Por convención, se crea en un ```output.tf```

En las outputs var le puedo asignar las input variables:

```sh
output "app_name" {
  value = var.app_name # declarada en vars.tf"
}

```

Si ejecuto ahora ```$ terraform plan -var "app_name=blog" -var "env_name=dev"``` sí que notifica el cambio

```sh
$ terraform plan -var "app_name=blog" -var "env_name=dev"
random_string.suffix: Refreshing state... [id=od54hq]

Changes to Outputs:
  + app_name = "blog"

You can apply this plan to save these new output values to the Terraform state, without changing any real infrastructure.

───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
```
Al ejecutar ```$ terraform apply -var "app_name=blog" -var "env_name=dev"``` muestra el output:

```sh
app_name = "blog"
```

Con el siguiente comando puedo ver el valor de la variable que he declarado en vars, capturado en outputs y pasado el valor desde la línea de comandos.

```sh
$ terraform output app_name
"blog"
```

Si añadimos más variables, tenemos que ejecutar ```$ terraform apply````. De lo contrario, terraform no modifica su estado.

```sh
$ terraform output environment_name
╷
│ Error: Output "environment_name" not found
│ 
│ The output variable requested could not be found in the state file. If you recently added this to your configuration, be sure to run `terraform apply`, since the state won't be updated with new output variables until that command is run.
```

He añadido 
```sh
output "env_prefix" {
  value = local.environment_prefix /* variable declarada en main.tf */
}
```

y fijado el valor en las input vars:

```sh
variable "app_name" {
  type    = string
  default = "blog"
}

variable "env_name" {
  type    = string
  default = "prod"
}
```

```$ terraform apply```

```sh
Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes


Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

Outputs:

app_name = "blog"
env_name = "prod"
env_prefix = "blog-dev"
```
Se puede observar que el archivo ```terraform.tfstate``` se actualiza:

```json
"outputs": {
    "app_name": {
      "value": "blog",
      "type": "string"
    },
    "env_name": {
      "value": "prod",
      "type": "string"
    },
    "env_prefix": {
      "value": "blog-dev",
      "type": "string"
    }
  },
```

# String Interpolations

Con string interpolations podemos evitar hardcodear valores y pasar de esto:

```sh
locals {
  environment_prefix = "blog-dev"
}

```

a esto:

```sh
locals {
  environment_prefix = "${var.app_name}-${var.env_name}"
}

```

