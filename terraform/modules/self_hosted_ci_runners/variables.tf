variable "runner_image_family" {
  description = "The operating system family of the image."
  default = "ubuntu-2204-lts"
}

variable "runner_image_project" {
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

variable "runner_name" {
  description = "The name of the resource"
  default = "runner"
}

variable "runner_machine_type" {
  description = "The type of machine used to create the runner"
  default = "e2-micro"
}

variable "runner_zone" {
  description = "The zone that the resource is created in"
  default = "europe-west2-a"
}

variable "runner_tags" {
  description = "The tags for the resource"
  default = ["github", "runner", "ci"]
}
