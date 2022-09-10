locals {
  environment  = "stage"
  region       = "asia-southeast1"
  region_short = "sea1"
  region_zone1 = "ap-singapore1-a"
  region_zone2 = "ap-singapore1-b"
  region_zone3 = "ap-singapore1-c"
  game_name    = "helloworld"
  prefix       = "${local.game_name}-${local.environment}-${local.region_short}"
  common_tags = {
    environment = local.environment
    owner       = "brianlee"
  }
  dev_ssh_pubkey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDDvApIyagfRRCq9UsdU0oluqsZpwibnxCgjI5dv3JhI6fdtuyHJdgarEu8JueTLL7nzY8F5vsSYFJ27FB7aMGpeRtPLosyIs7+CX8cX4dbhAK89alokrx8UdL/rbvhuswbkYZD5EbsZQOj14jXa2OCEy50ijJAhyIxedZ+1zCGzbJQnpax4w+UosFdd979YAeBA8+EHab8E9gg77ISvjN0qeXw9HlvSmvRHdE32AFCrVjqKB7YMITTimMB6sSD58qvL7nGl9cQPyptvm1ZNsDEwA+OnY5cFTVMC5j7w/LOz++Zr9pbGqtzIU2mAuVyZH7Gw/Fy+9iPh6613H4S+rdBfybZeXsCQYbCUStPGbkfmieDBzjodb/cM0Uz++78Gv5QOHI6qc8Adx+nIpIcEjNMkreqrjA5X/a552sAK0Y/RWhg1clGmHdeUo2+T8zryNToODcbIQT4c2K+ztt0wCqqTOf9mutL+HdxOCmXK6PKPxYjqzfUKsXYNgqa5dg7rVs= brianleevh"
  security_group_ingress = [
    "ACCEPT#0.0.0.0/32#22#TCP", # Should change as VPN
    "ACCEPT#10.0.0.0/8#ALL#ALL" # Default allow for all Internal Network
  ]
  security_group_egress = [
    "ACCEPT#0.0.0.0/0#ALL#ALL"
  ]
}