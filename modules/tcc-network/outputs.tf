output "vpc_id" {
  value = tencentcloud_vpc.vpc.id
}

output "route_table_id" {
  value = tencentcloud_route_table.route_table.id
}

output "subnet_pub_ids" {
  value = tencentcloud_subnet.subnet_pub.*.id
}

output "subnet_priv_ids" {
  value = tencentcloud_subnet.subnet_priv.*.id
}

output "nat_eip" {
  value = tencentcloud_eip.nat_eip.public_ip
}