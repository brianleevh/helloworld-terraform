variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR Range"
  default     = "10.0.0.0/16"
}

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