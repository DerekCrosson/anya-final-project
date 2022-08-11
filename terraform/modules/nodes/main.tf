resource "google_compute_attached_disk" "node_data_attachment" {
  disk     = google_compute_disk.node_data.id
  instance = google_compute_instance.node.id
}

resource "google_compute_disk" "node_data" {
  name  = "${ var.node_attached_disk_name }"
  type  = "${ var.node_attached_disk_type }"
  zone  = "${ var.node_zone }"
  labels = {
    type = "blockchain-data"
  }
  physical_block_size_bytes = 16384
}

resource "google_compute_instance" "node" {
  name         = "${ var.node_name }"
  machine_type = "${ var.node_machine_type }"
  zone         = "${ var.node_zone }"

  tags = "${ var.node_tags }"

  boot_disk {
    initialize_params {
      image = "${ var.node_image_project }/${ var.node_image_family }"
    }
  }

  network_interface {
    network    = google_compute_network.vpc_network.name
    subnetwork = google_compute_subnetwork.public.name

    access_config {
      // Ephemeral public IP
    }
  }

  lifecycle {
    ignore_changes = [attached_disk]
  }
}

resource "google_compute_network" "vpc_network" {
  project                 = "${ var.vpc_network_project_name }"
  name                    = "${ var.vpc_network_name }"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "public" {
  name          = "${ var.vpc_network_name }-public"
  region        = "${ var.vpc_network_region }"
  network       = google_compute_network.vpc_network.name
  ip_cidr_range = "${ var.vpc_public_subnet_cidr }"
}

resource "google_compute_subnetwork" "private" {
  name                     = "${ var.vpc_network_name }-private"
  region                   = "${ var.vpc_network_region }"
  private_ip_google_access = true
  network                  = google_compute_network.vpc_network.name
  ip_cidr_range            = "${ var.vpc_private_subnet_cidr }"
}

resource "google_compute_firewall" "ssh" {
  name = "allow-ssh"
  allow {
    ports    = "${ var.node_ssh_ports }"
    protocol = "tcp"
  }
  direction     = "INGRESS"
  network       = google_compute_network.vpc_network.name
  priority      = "${ var.node_ssh_firewall_rule_priority }"
  source_ranges = "${ var.ssh_firewall_source_ranges }"
  target_tags   = ["allow-ssh"]
}

resource "google_compute_firewall" "blockchain" {
  name    = "allow-relay-chain-and-parachain"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = "${ var.node_relay_chain_ports }"
  }

  allow {
    protocol = "tcp"
    ports    = "${ var.node_parachain_ports }"
  }

  source_ranges = "${ var.blockchain_firewall_source_ranges }"
  target_tags   = ["allow-relay-chain-and-parachain"]
}
