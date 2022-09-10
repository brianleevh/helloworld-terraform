resource "google_compute_network" "network" {
  name                    = "${prefix}-vpc"
  auto_create_subnetworks = false
  lifecycle {
    prevent_destroy = false
  }
}

resource "google_compute_subnetwork" "subnet_pub" {
  name          = "${prefix}-subnet-pub"
  ip_cidr_range = var.subnet_pub
  region        = local.region
  network       = google_compute_network.network.id
  lifecycle {
    prevent_destroy = false
  }
}

resource "google_compute_subnetwork" "subnet_priv" {
  name          = "${prefix}-subnet-priv"
  ip_cidr_range = var.subnet_priv
  region        = local.region
  network       = google_compute_network.network.id
  lifecycle {
    prevent_destroy = false
  }
}

resource "google_compute_router" "router" {
  name    = "${prefix}-router"
  region  = local.region
  network = google_compute_network.network.id

  bgp {
    asn = 64514
  }
}
resource "google_compute_router_nat" "router_nat" {
  name                                = "${prefix}-nat"
  router                              = google_compute_router.router.name
  region                              = google_compute_router.router.region
  nat_ip_allocate_option              = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat  = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  enable_endpoint_independent_mapping = true
  min_ports_per_vm                    = 64
}


resource "google_compute_firewall" "allow_internal_environment" {
  name        = "${local.environment}-internal"
  description = "Allow all source tagged for environment ${local.environment}"
  network     = google_compute_network.network.name
  allow {
    protocol = "all"
  }
  source_ranges = ["${google_compute_subnetwork.stag_private_subnet.ip_cidr_range}", "${google_compute_subnetwork.stag_public_subnet.ip_cidr_range}"]
}
resource "google_compute_firewall" "allow_tencent_commons" {
  name        = "${local.environment}-tencent-commons"
  description = "Allow all commonly used for environment ${local.environment}"
  network     = google_compute_network.network.name
  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443"]
  }
  allow {
    protocol = "icmp"
  }
  source_ranges = [
    "13.250.218.176/32", # SGVPN
    "101.32.118.251/32", # Jumpserver
    "101.32.128.230/32", # Jumpserver
    "150.109.21.17/32",  # Jumpserver
    "101.32.127.248/32", # IEGG AWX
    "49.51.251.123/32",  # IEGG Grafana
  ]
}