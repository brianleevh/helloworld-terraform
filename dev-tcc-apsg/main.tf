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
