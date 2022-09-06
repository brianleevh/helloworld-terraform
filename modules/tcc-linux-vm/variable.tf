variable "name" {
  type        = string
  description = "Resource Name"
  default     = "CVM"
}

variable "allocate_public_ip" {
  type        = bool
  description = "Allocate Public IP to VM"
  default     = false
}

variable "key_pair_id" {
  type        = string
  description = "CVM Key Pair Id"
}

variable "prefix_name" {
  type        = string
  description = "Resource Prefix"
  default     = "cvm"
}

variable "instance_family" {
  type        = string
  description = "CVM Instance Family"
  default     = "S5"
}

variable "cpu_core" {
  type        = string
  description = "CPU Core for servers"
  default     = 2
}

variable "memory" {
  type        = string
  description = "Memory Spec for servers"
  default     = 4
}

variable "data_disk_type" {
  type        = string
  description = "Data Disk Type"
  default     = "CLOUD_SSD"
}

variable "data_disk_size" {
  type        = number
  description = "Data Disk Size"
  default     = 100
}

variable "subnet_id" {
  type        = string
  description = "VM locate Subnet Id"
}

variable "common_tags" {
  type        = map(any)
  description = "Common Tags for resources"
  default     = {}
}