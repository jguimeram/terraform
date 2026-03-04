env_name = "dev"
instance_count  = 5
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


