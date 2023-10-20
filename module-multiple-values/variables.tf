variable "cpu" {
    type = string
}

variable "memory" {
    type = string  
}

variable "region" {
    type = string
}

variable "complexmap" {
    type = map(object({
        cpu = string
        memory = string
    }))
}