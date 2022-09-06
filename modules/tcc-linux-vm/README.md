# Tencent Cloud Instance

## Create Resources

 - tencentcloud_instance
 
 > Operating System as _Centos 7.5_

## Variables

| Key                | Description               | Type     | Default             |
| ------------------ |:-------------------------:| -------- |:-------------------:|
| name               | Resource Name             | string   | CVM                 |
| allocate_public_ip | Allocate Public IP to VM  | bool     | false               |
| key_pair_id        | CVM Key Pair Id           | string   |                     |
| prefix_name        | Resource Prefix           | string   | cvm                 |
| instance_family    | CVM Instance Family       | string   | S5                  |
| cpu_core           | CPU Core for servers      | string   | 2                   |
| memory             | Memory Spec for servers   | string   | 4                   |
| data_disk_type     | Data Disk Type            | string   | CLOUD_SSD           |
| data_disk_size     | Data Disk Size            | number   | 100                 |
| subnet_id          | VM locate Subnet Id       | string   | VM locate Subnet Id |
| common_tags        | Common Tags for resources | map(any) | {}                  |

## Output

| Key            | Value                                |
| -------------- |:------------------------------------:|
| cvm_id         | tencentcloud_instance.cvm.id         |
| cvm_private_ip | tencentcloud_instance.cvm.private_ip |
| cvm_public_ip  | tencentcloud_instance.cvm.public_ip  |
