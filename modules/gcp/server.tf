resource "google_compute_instance" "server" {
  name         = "${var.name}"
  machine_type = "${var.machine_type}"

  boot_disk {
    auto_delete = true
    initialize_params {
      image = "${var.image}"
      size = 10
    }
  }

  metadata_startup_script = templatefile("${var.startup_script}",{
        cloudflare_tunnel_token = "${var.cloudflare_tunnel_token}",
      }
    )

  network_interface {
    network = google_compute_network.vpc_network.self_link
    access_config {}
  }
}

resource "google_compute_network" "vpc_network" {
  name                    = "terraform-network"
  auto_create_subnetworks = "true"
}

resource "google_compute_firewall" "ssh-rule" {
  name = "allow-ssh"
  network = google_compute_network.vpc_network.name
  allow {
    protocol = "tcp"
    ports = ["22"]
  }
  source_ranges = ["0.0.0.0/0"]
}