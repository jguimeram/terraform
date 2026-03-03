# FUNDAMENTALS

Resources {
    Attributes
}

```hlc
resource "random_string" "suffix" {
  length = 6
}
```

Cada vez que declaras un provider, Terraform intentará encontrarlo e instalarlo con ```terraform init```

Output:

```sh
Initializing the backend...
Initializing provider plugins...
- Finding latest version of hashicorp/random...
- Installing hashicorp/random v3.8.1...
- Installed hashicorp/random v3.8.1 (signed by HashiCorp)
Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

Backend: Dónde Terraform guarda el estado.

Terraform use the selected providers to generate the execution plan: ```terraform plan```

Output:

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
      + special     = true
      + upper       = true
    }

Plan: 1 to add, 0 to change, 0 to destroy.
```
Aplicar el plan: ```terraform apply```

```sh
Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

random_string.suffix: Creating...
random_string.suffix: Creation complete after 0s [id=T(LLI#]
```

Y crea el 'terraform.tfstate'

Como la configuración de terraform es idempotente (acciones que, al ejecutarse múltiples veces, producen el mismo resultado que si se realizaran una sola vez), si lanzo de nuevo ```terraform apply```:

```sh
random_string.suffix: Refreshing state... [id=T(LLI#] #este es el valor que ha creado con random string = 6

No changes. Your infrastructure matches the configuration.

Terraform has compared your real infrastructure against your configuration and found no differences, so no changes are needed.

Apply complete! Resources: 0 added, 0 changed, 0 destroyed.
```
Si añado un atributo más y lanzo ```terraform plan``` avisa del cambio:

```sh
Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
-/+ destroy and then create replacement

Terraform will perform the following actions:

  # random_string.suffix must be replaced
-/+ resource "random_string" "suffix" {
      ~ id          = "T(LLI#" -> (known after apply)
      ~ result      = "T(LLI#" -> (known after apply)
      ~ upper       = true -> false # forces replacement
        # (9 unchanged attributes hidden)
    }

Plan: 1 to add, 0 to change, 1 to destroy.
```

```terraform apply```

```sh
Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

random_string.suffix: Destroying... [id=T(LLI#]
random_string.suffix: Destruction complete after 0s
random_string.suffix: Creating...
random_string.suffix: Creation complete after 0s [id=+c$nmq]

Apply complete! Resources: 1 added, 0 changed, 1 destroyed.
```


Se puede comprobar el cambio en el archivo ```terraform.tfstate```:

```json
 {
          "schema_version": 2,
          "attributes": {
            "id": "+c$nmq",
            "keepers": null,
            "length": 6,
            "lower": true,
            "min_lower": 0,
            "min_numeric": 0,
            "min_special": 0,
            "min_upper": 0,
            "number": true,
            "numeric": true,
            "override_special": null,
            "result": "+c$nmq", /* El resultado es el esperado: string lowercase */
            "special": true,
            "upper": false  /* Declarado como false en el main.tf */
          }
```

Con ```terraform destroy``` elimino la configuración creada en ```terraform.tfstate``` de acuerdo a ```main.tf```

```

  # random_string.suffix will be destroyed
  - resource "random_string" "suffix" {
      - id          = "]s2)){" -> null
      - length      = 6 -> null
      - lower       = true -> null
      - min_lower   = 0 -> null
      - min_numeric = 0 -> null
      - min_special = 0 -> null
      - min_upper   = 0 -> null
      - number      = true -> null
      - numeric     = true -> null
      - result      = "]s2)){" -> null
      - special     = true -> null
      - upper       = false -> null
    }

Plan: 0 to add, 0 to change, 1 to destroy.

```