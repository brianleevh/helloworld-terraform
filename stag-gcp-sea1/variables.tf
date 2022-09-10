variable "subnet_pub" {
  type = list(object({
    subnet_cidr       = string
    availability_zone = string
  }))
  description = "Public Subnet Range"
}

variable "subnet_priv" {
  type = list(object({
    subnet_cidr       = string
    availability_zone = string
  }))
  description = "Private Subnet Range"
}