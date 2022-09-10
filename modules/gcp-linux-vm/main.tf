resource "google_compute_instance" "vm" {
  name         = "${var.game_name}-${var.environment}-${var.region}-${var.name}"
  machine_type = var.machine_type
  zone         = var.region_zone1

  tags = ["${var.environment}", "${var.region}", "${var.tag}"]
  metadata = {
    ssh-keys = "root:${var.vm_root_sshkey}"
  }
  metadata_startup_script = <<EOT
#!/bin/bash -ex
perl -pi -e 's/^#?Port 22$/Port 36000/' /etc/ssh/sshd_config
sed -i 's/PermitRootLogin no/PermitRootLogin prohibit-password/g' /etc/ssh/sshd_config
service sshd restart || service ssh restart
  EOT
  boot_disk {
    source      = google_compute_disk.vm_boot.id
    device_name = "boot"
  }
  attached_disk {
    source      = google_compute_disk.vm_data.id
    device_name = "data"
  }
  network_interface {
    subnetwork = var.subnet_id
    dynamic "access_config" {
      for_each = var.ext_ip ? [""] : []
      content {} // Ephemeral public IP
    }
  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = var.service_account
    scopes = ["cloud-platform"]
  }
  labels = {
    environment = "${var.environment}"
    region      = "${var.region}"
    module      = "${var.name}"
    managedby   = "terraform"
  }
}
resource "google_compute_disk" "vm_boot" {
  name  = "${var.environment}-${var.region}-${var.name}-boot"
  type  = "pd-balanced"
  zone  = var.region_zone1
  image = "centos-7"
  size  = var.os_disk_size_gb
  labels = {
    environment = "${var.environment}"
    region      = "${var.region}"
    module      = "${var.name}-boot"
    managedby   = "terraform"
  }
}
resource "google_compute_disk" "vm_data" {
  name = "${var.environment}-${var.region}-${var.name}-data"
  type = "pd-balanced"
  zone = var.region_zone1
  size = var.data_disk_size_gb
  labels = {
    environment = "${var.environment}"
    region      = "${var.region}"
    module      = "${var.name}-data"
    managedby   = "terraform"
  }
}