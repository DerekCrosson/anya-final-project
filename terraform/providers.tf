terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.31.0"
    }

    google-beta = {
      source = "hashicorp/google-beta"
      version = "4.31.0"
    }
  }
}

provider "google" {
  project     = "${ var.project_id }"
  region      = "${ var.region }"
  zone        = "${ var.zone }"
}
