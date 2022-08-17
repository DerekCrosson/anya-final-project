resource "google_compute_attached_disk" "node_data_attachment" {
  for_each = google_compute_disk.node_data
    disk     = each.value.id
    instance = google_compute_instance.node[each.key].id
}

resource "google_compute_disk" "node_data" {
  for_each = var.volumes
    name  = each.value.name
    type  = each.value.type
    zone  = each.value.zone
    labels = each.value.labels
    size = each.value.size
}

resource "google_compute_instance" "node" {
  for_each = {for k, v in merge(var.boot_nodes, var.collator_nodes) : k => v}
    name         = each.value.name
    machine_type = each.value.machine_type
    zone         = each.value.zone

    tags = each.value.tags

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

    metadata_startup_script = "${ file("${path.module}/scripts/mount_persistent_disk.sh") }"

    service_account {
      email  = "${ var.service_account_email }"
      scopes = "${ var.service_account_scopes }"
    }

    metadata = {
      "ssh-keys" = <<EOT
    ${ var.ssh_user }:${ var.ssh_public_key }
    EOT
    }

    allow_stopping_for_update = true

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

resource "google_compute_firewall" "boot_node_and_collator_node" {
  name    = "allow-websocket-and-rpc"
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
  target_tags   = ["allow-websocket-and-rpc"]
}

resource "google_compute_firewall" "prometheus" {
  name    = "allow-prometheus"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = "${ var.parachain_prometheus_ports }"
  }

  allow {
    protocol = "tcp"
    ports    = "${ var.relay_chain_prometheus_ports }"
  }

  source_ranges = "${ var.blockchain_firewall_source_ranges }"
  target_tags   = ["allow-prometheus"]
}

resource "local_file" "ansible_inventory" {
  filename = "../ansible/inventory/hosts.ini"
  content = <<-EOT
[blockchain_nodes]
%{ for node in google_compute_instance.node ~}
${split("/", node.id)[5]} ansible_host=${node.network_interface[0].access_config[0].nat_ip} ansible_port=22
%{ endfor ~}
  EOT
}
