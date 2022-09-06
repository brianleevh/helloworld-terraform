variable "prefix_name" {
  type        = string
  description = "Resource Prefix"
  default     = "network"
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR Range"
  default     = "10.0.0.0/8"
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

variable "security_group_ingress" {
  type        = list(string)
  description = "Main Security Group Ingress"
}

variable "security_group_egress" {
  type        = list(string)
  description = "Main Security Group Egress"
}

variable "common_tags" {
  type        = map(any)
  description = "Common Tags for resources"
  default     = {}
}

