# Main VPC, Subnet, NAT
module "network" {
  source = "../modules/tcc-network"

  prefix_name = local.prefix
  vpc_cidr    = var.vpc_cidr

  subnet_pub             = var.subnet_pub
  subnet_priv            = var.subnet_priv
  security_group_ingress = local.security_group_ingress
  security_group_egress  = local.security_group_egress

  common_tags = merge({
    costcenter = "it"
  }, local.common_tags)
}