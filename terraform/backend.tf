terraform {
  backend "gcs" {
    bucket  = "anya-final-project-terraform-state"
    prefix  = "terraform/state"

    credentials = "/home/runner/work/anya-final-project/anya-final-project/gha-creds-*.json"
  }
}
