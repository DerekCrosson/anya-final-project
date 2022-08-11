variable "project_id" {
  description = "The GCP project ID"
  default = "anya-fellowship-project"
}

variable "region" {
  description = "The data center's geographic area"
  default = "europe-west2"
}

variable "zone" {
  description = "The data center's location within it's geographic area"
  default = "europe-west2-a"
}
