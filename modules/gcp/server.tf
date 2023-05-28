resource "google_compute_instance" "server" {
  name         = "${var.name}"
  machine_type = "${var.machine_type}"

  boot_disk {
    auto_delete = true
    initialize_params {
      image = "${var.image}"
      size = 30
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.self_link
    access_config {}
  }
}

resource "google_compute_network" "vpc_network" {
  name                    = "terraform-network"
  auto_create_subnetworks = "true"
}