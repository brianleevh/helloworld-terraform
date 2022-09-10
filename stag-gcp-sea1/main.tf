resource "google_compute_firewall" "bkproxy_firewall" {
  name    = "${local.environment}-${local.region}-bkproxy-firewall"
  network = google_compute_network.stag_network.name

  allow {
    protocol = "tcp"
    ports    = ["36000", "48668", "58625", "58930", "10020", "58725"]
  }
  allow {
    protocol = "udp"
    ports    = ["10020", "10030"]
  }

  source_ranges = [
    "101.32.246.199", "101.32.167.12", "101.32.251.13", "101.32.164.157"
  ]

  target_tags = ["bkproxy"]
}

module "bkproxy" {
  count = 2

  source            = "../../../modules/gcp/vm_public"
  game_name         = local.game_name
  environment       = local.environment
  region            = local.region
  name              = "bkproxy-${format("%02d", count.index + 1)}"
  tag               = "bkproxy"
  machine_type      = "e2-standard-4"
  region_zone1      = "${count.index % 2}" == 0 ? local.region_zone1 : local.region_zone2
  subnet_id         = google_compute_subnetwork.stag_public_subnet.id
  ext_ip            = true
  service_account   = google_service_account.compute_engine_stag.email
  vm_root_sshkey    = local.nonprod_ssh_pubkey
  os_disk_size_gb   = 100
  data_disk_size_gb = 100
}

# module "bkproxy2" {
#   source          = "../../../modules/gcp/vm_public"
#   game_name       = local.game_name
#   environment     = local.environment
#   region          = local.region
#   name            = "bkproxy2"
#   machine_type    = "e2-standard-4"
#   region_zone1    = local.region_zone1
#   subnet_id       = google_compute_subnetwork.stag_public_subnet.id
#   service_account = google_service_account.compute_engine_stag.email
#   vm_root_sshkey  = local.nonprod_ssh_pubkey
# }