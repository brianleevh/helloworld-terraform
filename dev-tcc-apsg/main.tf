# Default key-pair
resource "tencentcloud_key_pair" "main" {
  key_name   = "${local.game_name}_${local.environment}_keypair"
  public_key = local.dev_ssh_pubkey
}

# Jumpserver
module "jumpserver" {
  source      = "../modules/tcc-linux-vm"
  prefix_name = local.prefix

  name               = "${local.prefix}-jumpserver"
  key_pair_id        = tencentcloud_key_pair.main.id
  allocate_public_ip = true
  subnet_id          = module.network.subnet_pub_ids[0]
  common_tags = merge({
    costcenter = "it"
  }, local.common_tags)

  depends_on = [
    module.network,
    tencentcloud_key_pair.main
  ]
}

#module"nat_gateway"{
#source="../modules/nat_gateway"

#vpc_id=module.vpc.vpc_id
#eip_public_ip=module.eip.eip_public_ip
#route_table_id=module.vpc.route_table_id

#name_suffix=local.name_suffix
#required_tags=local.required_tags
#}

#module"key_pair"{
#source="../modules/key_pair"

#pub_key=var.pub_key

#name_suffix=local.name_suffix
#}

#module"jumpservers"{
#count=var.cvm_jumpserver_count
#source="../modules/cvm"

#os_image=var.cvm_jumpserver.os_image
#cpu_core=var.cvm_jumpserver.cpu_core
#memory=var.cvm_jumpserver.memory
#vpc_id=module.vpc.vpc_id
#subnet_id=module.public_subnets.0.subnet_id
#availability_zone=module.public_subnets.0.subnet_availability_zone

#hostname=var.cvm_jumpserver.hostname
#system_disk_type=var.cvm_jumpserver.system_disk_type
#system_disk_size=var.cvm_jumpserver.system_disk_size
#allocate_public_ip=var.cvm_jumpserver.allocate_public_ip
#data_disk_type=var.cvm_jumpserver.data_disk_type
#data_disk_size=var.cvm_jumpserver.data_disk_size
#data_disk_encrypt=var.cvm_jumpserver.data_disk_encrypt
#key_pair_id=module.key_pair.key_pair_id
#security_group_id=module.security_group.security_group_id

#name_suffix=local.name_suffix
#required_tags=local.required_tags
#}

#module"webservers"{
#count=var.cvm_webserver_count
#source="../modules/cvm"

#os_image=var.cvm_webserver.os_image
#cpu_core=var.cvm_webserver.cpu_core
#memory=var.cvm_webserver.memory
#vpc_id=module.vpc.vpc_id
#subnet_id=(
#var.cvm_jumpserver_count%2==0
#?module.private_subnets.0.subnet_id
#:module.private_subnets.1.subnet_id
#)
#availability_zone=(
#var.cvm_jumpserver_count%2==0
#?module.private_subnets.0.subnet_availability_zone
#:module.private_subnets.1.subnet_availability_zone
#)
#hostname=var.cvm_webserver.hostname
#system_disk_type=var.cvm_webserver.system_disk_type
#system_disk_size=var.cvm_webserver.system_disk_size
#allocate_public_ip=var.cvm_webserver.allocate_public_ip
#data_disk_type=var.cvm_webserver.data_disk_type
#data_disk_size=var.cvm_webserver.data_disk_size
#data_disk_encrypt=var.cvm_webserver.data_disk_encrypt
#key_pair_id=module.key_pair.key_pair_id
#security_group_id=module.security_group.security_group_id

#name_suffix=local.name_suffix
#required_tags=local.required_tags
#}

#module"mysql"{
#source="../modules/mysql"

#cpu=var.mysql_cpu
#mem_size=var.mysql_mem_size
#volume_size=var.mysql_volume_size
#root_pw=var.mysql_root_pw
#engine_version=var.mysql_engine_version
#intranet_port=var.mysql_intranet_port
#vpc_id=module.vpc.vpc_id
#subnet_id=module.private_subnets.2.subnet_id
#availability_zone=module.private_subnets.2.subnet_availability_zone
#security_group_id=module.security_group.security_group_id

#name_suffix=local.name_suffix
#required_tags=local.required_tags
#}

#module"redis"{
#source="../modules/redis"

#type_id=var.redis_type_id
#password=var.redis_password
#mem_size=var.redis_mem_size
#port=var.redis_port
#vpc_id=module.vpc.vpc_id
#subnet_id=module.private_subnets.3.subnet_id
#availability_zone=module.private_subnets.3.subnet_availability_zone
#security_group_id=module.security_group.security_group_id

#name_suffix=local.name_suffix
#required_tags=local.required_tags
#}

#module"clb"{
#source="../modules/clb"

#network_type=var.clb_network_type
#port=var.clb_port
#protocol=var.clb_protocol
#health_check_http_path=var.clb_health_check_http_path
#vpc_id=module.vpc.vpc_id
#subnet_id=module.public_subnets.0.subnet_id
#availability_zone=module.public_subnets.0.subnet_availability_zone
#security_group_id=module.security_group.security_group_id
#webserver_ids=module.webservers.*.cvm_id

#name_suffix=local.name_suffix
#required_tags=local.required_tags
#}

#module"cam"{
#source="../modules/cam"

#name_suffix=local.name_suffix
#owner=var.owner
#}

#module"cos"{
#source="../modules/cos"

#region=var.region
#appid=var.appid
#cam_uin=module.cam.cam_uin
#owner=var.owner

#name_suffix=local.name_suffix
#required_tags=local.required_tags
#}