variable "project_id" {
  description = "The GCP project ID"
  default = "anya-final-project-derek"
}

variable "service_list" {
  type = list(string)
  description = "The list of GCP APIs that need to be enabled for the infrastructure to be automated"
  default = [
    "iam.googleapis.com",
    "compute.googleapis.com",
    "storage-component.googleapis.com",
    "storage-api.googleapis.com"
  ]
}
