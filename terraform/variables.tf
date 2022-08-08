# variable "state_bucket_name" {
#   description = "The name of the GCP cloud storage bucket to use for terraform state"
#   default = "anya-final-project-terraform-state"
# }

variable "project_id" {
  description = "The GCP project ID"
  default = "anya-final-project-derek"
}

variable "region" {
  description = "The data center's geographic area"
  default = "europe-west2"
}

variable "zone" {
  description = "The data center's location within it's geographic area"
  default = "europe-west2-a"
}
