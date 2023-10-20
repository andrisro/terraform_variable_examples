# Example: Simple Way 1
module "module-simple-value" {
    source = "./module-simple-value"
    input_var_1 = "simple-value"
}

# Example: Simple Way 2
locals {
  simple_value_deploy_count = 3
}

module "module-simple-value-count" {
    count = local.simple_value_deploy_count
    source = "./module-simple-value"
    input_var_1 = "value_${count.index}"
}

# Example: Simple Way - List with Count
locals {
  list = ["one","two","three"]
}

module "module-simple-value-count-length" {
    count = len(local.list)
    source = "./module-simple-value"
    input_var_1 = "value_${count.index}"
}

# Example: Simple Way - List with ForEach
locals {
    foreach_list = ["a","b","c"]
}

module "module-simple-value-foreach" {
    for_each = local.foreach_list
    source = "./module-simple-value"
    input_var_1 = each.value
}

# Example: Simple Map: Passing multiple values by using maps
locals {
  simple_map = tomap({
    "eu-central-1" = "10"
    "eu-west-1" = "2"
  })
}

module "module-simple-map-value" {
    source = "./module-different-values"
    for_each = local.simple_map
    input_var_region = each.key
    input_var_2 = each.value
    simple_map = local.simple_map
}

# Example: Map with Objects: Passing multiple values by using maps

locals {
    complex_map = tomap({
        "eu-central-1" = {
            cpu = "1"
            memory = "2"
        }
        "eu-west-1" = {
            cpu = "3"
            memory = "12"
        }
    })
}

module "module-multiple-values" {
    source = "./module-multiple-values"
    for_each = local.complex_map
    cpu = each.value.cpu
    memory = each.value.memory
    region = each.key
    complexmap = local.complex_map
}


# Example: Reformat Variable Structures
locals {
    complex_map_new = tomap({
        "eu-central-1" = {
            cpu = "1"
            memory = "2"
        }
        "eu-west-1" = {
            cpu = "3"
            memory = "12"
        }
    })

    simple_map_region_cpu = {
        for key, value in local.complex_map_new:
            "${key}" => "${value.cpu}"
    }
}

output "simple_map_region_cpu" {
  value = local.simple_map_region_cpu
}