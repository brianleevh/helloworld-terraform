# Get available CVM AMI
data "tencentcloud_images" "main" {
  image_type = ["PUBLIC_IMAGE"]
  os_name    = "centos 7.5"
}

data "tencentcloud_instance_types" "main" {
  filter {
    name   = "instance-family"
    values = [var.instance_family]
  }
  filter {
    name   = "zone"
    values = [data.tencentcloud_vpc_subnets.subnet.instance_list.0.availability_zone]
  }
  filter {
    name   = "instance-charge-type"
    values = ["POSTPAID_BY_HOUR"]
  }

  cpu_core_count = var.cpu_core
  memory_size    = var.memory
}

data "tencentcloud_vpc_subnets" "subnet" {
  subnet_id = var.subnet_id
}

data "tencentcloud_key_pairs" "key_pair" {
  key_id = var.key_pair_id
}

data "tencentcloud_security_groups" "default_sg" {
  name = "${var.prefix_name}-default-sg"
}

resource "tencentcloud_instance" "cvm" {
  instance_name              = "${var.prefix_name}-${var.name}"
  image_id                   = data.tencentcloud_images.main.images.0.image_id
  instance_type              = data.tencentcloud_instance_types.main.instance_types.0.instance_type
  system_disk_type           = "CLOUD_SSD"
  system_disk_size           = "80"
  security_groups            = [data.tencentcloud_security_groups.default_sg.security_groups.0.security_group_id]
  hostname                   = "${var.prefix_name}-${var.name}"
  vpc_id                     = data.tencentcloud_vpc_subnets.subnet.instance_list.0.vpc_id
  subnet_id                  = data.tencentcloud_vpc_subnets.subnet.instance_list.0.subnet_id
  availability_zone          = data.tencentcloud_vpc_subnets.subnet.instance_list.0.availability_zone
  allocate_public_ip         = var.allocate_public_ip
  internet_max_bandwidth_out = 20
  key_name                   = data.tencentcloud_key_pairs.key_pair.key_pair_list.0.key_id
  user_data_raw              = <<EOT
#!/bin/bash -ex
sed -i 's/PermitRootLogin no/PermitRootLogin prohibit-password/g' /etc/ssh/sshd_config
service sshd restart || service ssh restart
  EOT

  data_disks {
    data_disk_type = var.data_disk_type
    data_disk_size = var.data_disk_size
  }

  tags = var.common_tags
}