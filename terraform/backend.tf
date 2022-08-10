terraform {
  backend "gcs" {
    bucket  = "anya-final-project-terraform-state"
    prefix  = "terraform/state"

    #credentials = "~/gcp_credentials.json"
  }
}
