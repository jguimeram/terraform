# Sensitive information

Para marcar una variable como información sensible, tenemos el parámetro ```sensitive```

En ```vars.tf```

```sh
variable "api_key" {
  sensitive = true
}
```

En ```outputs.tf```

```sh
output "api_key" {
  value     = var.api_key
  sensitive = true
}
```

De esta manera,  cuando salte el prompt pidiendo la api_key, la introduciremos pero no se verá qué se escribe. De todos modos, en el terraform.tfstate sí se puede ver el valor de la variable o con el comando ```$ terraform output api_key```. 

Sin indicar ```sensitive = true``` en el fichero ```vars.tf``` también funciona. 





