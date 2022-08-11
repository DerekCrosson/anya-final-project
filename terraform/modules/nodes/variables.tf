variable "volumes" {
  default = {
    "polkadot-boot-node-primary" = {
      name              = "primary-boot-node-data"
      type              = "pd-ssd"
      zone              = "europe-west2-a"
      labels = {
        type = "blockchain-data",
        role = "boot-node",
        tier = "primary"
      }

      physical_block_size_bytes = 4096
    },
    "polkadot-boot-node-secondary" = {
      name              = "secondary-boot-node-data"
      type              = "pd-ssd"
      zone              = "europe-west2-b"
      labels = {
        type = "blockchain-data",
        role = "boot-node",
        tier = "secondary"
      }

      physical_block_size_bytes = 4096
    },
    "polkadot-collator-node" = {
      name              = "collator-node-data"
      type              = "pd-ssd"
      zone              = "europe-west2-c"
      labels = {
        type = "blockchain-data",
        role = "collator-node"
      }

      physical_block_size_bytes = 4096
    }
  }
}

variable "boot_nodes" {
  default = {
    "polkadot-boot-node-primary" = {
      name = "polkadot-boot-node-primary"
      machine_type = "e2-medium"
      zone = "europe-west2-a",
      tags = ["polkadot", "node", "boot", "primary"]
    },
    "polkadot-boot-node-secondary" = {
      name = "polkadot-boot-node-secondary"
      machine_type = "e2-medium"
      zone = "europe-west2-b",
      tags = ["polkadot", "node", "boot", "secondary"]
    }
  }
}

variable "collator_nodes" {
  default = {
    "polkadot-collator-node" = {
      name = "polkadot-collator-node"
      machine_type = "e2-medium"
      zone = "europe-west2-c",
      tags = ["polkadot", "node", "collator"]
    }
  }
}

variable "node_image_family" {
  description = "The operating system family of the image."
  default = "ubuntu-2204-lts"
}

variable "node_image_project" {
  description = "The project which the image belongs to."
  default = "ubuntu-os-cloud"
}

variable "service_account_email" {
  description = "The email of the service account to use."
  default = "terraform@anya-fellowship-project.iam.gserviceaccount.com"
}

variable "service_account_scopes" {
  description = "The scopes for the service account"
  default = ["cloud-platform"]
}

variable "vpc_network_project_name" {
  description = "The GCP project name"
  default = "anya-fellowship-project"
}

variable "vpc_network_name" {
  description = "The GCP project name"
  default = "anya-fellowship-project-vpc-network"
}

variable "vpc_network_region" {
  description = "The region that the vpc network is created in"
  default = "europe-west2"
}

variable "vpc_public_subnet_cidr" {
  default = "10.1.0.0/24"
}

variable "vpc_private_subnet_cidr" {
  default = "10.1.1.0/24"
}

variable "node_ssh_ports" {
  default = ["22"]
}

variable "node_ssh_firewall_rule_priority" {
  default = 1000
}

variable "node_relay_chain_ports" {
  default = ["30333"]
}

variable "node_parachain_ports" {
  default = ["30334"]
}

variable "node_web_socket_ports" {
  default = ["8833"]
}

variable "node_rpc_ports" {
  default = ["8844"]
}

variable "parachain_prometheus_ports" {
  default = ["9615"]
}

variable "relay_chain_prometheus_ports" {
  default = ["9625"]
}

variable "ssh_firewall_source_ranges" {
  default = ["0.0.0.0/0"]
}

variable "blockchain_firewall_source_ranges" {
  default = ["0.0.0.0/0"]
}
