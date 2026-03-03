# REQUIRED PROVIDERS

## Definir required providers

En un archivo llamado ```version.tf```

```sh
terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = ">= 3.8.1"
    }
  }
}
```
Como es un archivo en el que normalmente se hace mucho copiar/pegar revisar cosas como que el nombre del proveedor sea el mismo tanto en 'random =', como en 'source = 'hashicorp/random'

Lanzo ```$ terraform init```

```sh

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

## Referencing Resource Outputs