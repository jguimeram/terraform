env_name        = "prod"
instance_count  = 5
enabled         = true
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
