env_name        = "prod"
instance_count  = 1
enabled         = false
regions         = ["westeu", "easteu"]
region_instance_count = {
    "westeu" = 4
    "easteu" = 8
}
region_set = ["westeu", "easteu"]

sku_settings = {
    kind = "P"
    tier = "Business"
}
