provider "google" {
  credentials = "${file("key-201231.json")}"
  project     = "trq1-161205"
  region      = "asia-northeast1-a"
}

resource "google_compute_instance" "default" {
  name         = "test-terra"
  machine_type = "g1-small"
  zone         = "asia-northeast1-a"

  tags = ["foo", "bar"]

  disk {
    image = "ubuntu-docker-xenial-1489216765"
  }

  network_interface {
    network = "docker-net"
    access_config {
      // Ephemeral IP
    }
  }
  provisioner "remote-exec" {
    inline = [
      "if ${var.swarm_init}; then docker swarm init --advertise-addr ${self.network_interface.0.address}; fi",
      "if ! ${var.swarm_init}; then docker swarm join --token ${var.swarm_manager_token} --advertise-addr ${self.network_interface.0.address} ${var.swarm_manager_ip}:2377; fi"
    ]
  }
}
