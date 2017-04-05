resource "google_compute_network" "default" {
  name                    = "docker-net"
  auto_create_subnetworks = "true"
}

resource "google_compute_firewall" "docker" {
  name    = "docker"
  network = "docker-net"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443", "8080", "2377", "7946", "4789",]
  }

  source_tags = ["docker-swarm"]
}
