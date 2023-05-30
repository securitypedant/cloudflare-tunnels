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
    network = "default"
    access_config {}
  }
}