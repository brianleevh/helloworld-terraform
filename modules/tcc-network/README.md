# Tencent Cloud Network

## Create Resources

 - tencentcloud_vpc
 - tencentcloud_route_table
 - tencentcloud_subnet
 - tencentcloud_subnet
 - tencentcloud_eip
 - tencentcloud_nat_gateway
 - tencentcloud_route_table_entry
 - tencentcloud_security_group

## Variables

| Key                    | Description                 | Type                          | Default    |
| ---------------------- |:---------------------------:| ----------------------------- |:----------:|
| prefix_name            | Resource Prefix             | string                        | network    |
| vpc_cidr               | VPC CIDR Range              | string                        | 10.0.0.0/8 |
| subnet_pub             | Public Subnet Range         | list(object({string, string}) |            |
| subnet_priv            | Private Subnet Range        | list(object({string, string}) |            |
| security_group_ingress | Main Security Group Ingress | list(string)                  |            |
| security_group_egress  | Main Security Group Egress  | list(string)                  |            |
| common_tags            | Common Tags for resources   | map(any)                      | {}         |

## Output

| Key             | Value                                      |
| --------------- |:------------------------------------------:|
| vpc_id          | tencentcloud_vpc.vpc.id                    |
| route_table_id  | VPC tencentcloud_route_table.route_table.id|
| subnet_pub_ids  | tencentcloud_subnet.subnet_pub.*.id        |
| subnet_priv_ids | tencentcloud_subnet.subnet_priv.*.id       |
| nat_eip         | tencentcloud_eip.nat_eip.public_ip         |
