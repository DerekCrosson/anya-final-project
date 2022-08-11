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

variable "node_name" {
  description = "The name of the resource"
  default = "node"
}

variable "node_machine_type" {
  description = "The type of machine used to create the runner"
  default = "e2-medium"
}

variable "node_zone" {
  description = "The zone that the resource is created in"
  default = "europe-west2-a"
}

variable "node_tags" {
  description = "The tags for the resource"
  default = ["polkadot", "node"]
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

variable "ssh_firewall_source_ranges" {
  default = ["0.0.0.0/0"]
}

variable "blockchain_firewall_source_ranges" {
  default = ["0.0.0.0/0"]
}

variable "node_attached_disk_name" {
  default = "node-data"
}

variable "node_attached_disk_type" {
  default = "pd-ssd"
}

variable "attached_disk_type" {
  default = "pd-ssd"
}
