output publicIP {
    value = google_compute_instance.server.network_interface[0].access_config[0].nat_ip
}