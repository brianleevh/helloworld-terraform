resource "tencentcloud_vpc" "vpc" {
  name       = "${var.prefix_name}-vpc"
  cidr_block = var.vpc_cidr

  tags = var.common_tags
}

resource "tencentcloud_route_table" "route_table" {
  vpc_id = tencentcloud_vpc.vpc.id
  name   = "${var.prefix_name}-route-table"

  tags = var.common_tags
}

resource "tencentcloud_subnet" "subnet_pub" {
  count = length(var.subnet_pub)

  name              = "${var.prefix_name}-subnet-pub-${count.index + 1}"
  vpc_id            = tencentcloud_vpc.vpc.id
  route_table_id    = tencentcloud_route_table.route_table.id
  availability_zone = var.subnet_pub[count.index].availability_zone
  cidr_block        = var.subnet_pub[count.index].subnet_cidr

  tags = var.common_tags
}

resource "tencentcloud_subnet" "subnet_priv" {
  count = length(var.subnet_priv)

  name              = "${var.prefix_name}-subnet-priv-${count.index + 1}"
  vpc_id            = tencentcloud_vpc.vpc.id
  route_table_id    = tencentcloud_route_table.route_table.id
  availability_zone = var.subnet_priv[count.index].availability_zone
  cidr_block        = var.subnet_priv[count.index].subnet_cidr

  tags = var.common_tags
}

resource "tencentcloud_eip" "nat_eip" {
  name = "${var.prefix_name}-natip"

  tags = var.common_tags
}

# Provision NAT gateway
resource "tencentcloud_nat_gateway" "nat" {
  name             = "${var.prefix_name}-nat"
  vpc_id           = tencentcloud_vpc.vpc.id
  bandwidth        = 100
  max_concurrent   = 1000000
  assigned_eip_set = [tencentcloud_eip.nat_eip.public_ip]

  tags = var.common_tags
}

resource "tencentcloud_route_table_entry" "main_router" {
  route_table_id         = tencentcloud_route_table.route_table.id
  destination_cidr_block = "0.0.0.0/0"
  next_type              = "NAT"
  next_hub               = tencentcloud_nat_gateway.nat.id
  description            = "${var.prefix_name}-nat-router"
}

resource "tencentcloud_security_group" "sg" {
  name        = "${var.prefix_name}-default-sg"
  description = "Internal NetworkAccess"

  tags = var.common_tags
}

resource "tencentcloud_security_group_lite_rule" "sg_internal_rules" {
  security_group_id = tencentcloud_security_group.sg.id

  ingress = var.security_group_ingress
  egress  = var.security_group_egress
}