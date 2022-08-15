resource "google_compute_instance" "runner" {
  name         = "${ var.runner_name }"
  machine_type = "${ var.runner_machine_type }"
  zone         = "${ var.runner_zone }"

  tags = "${ var.runner_tags }"

  boot_disk {
    initialize_params {
      image = "${ var.runner_image_project }/${ var.runner_image_family }"
    }
  }

  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }
  
  metadata_startup_script = "${ file("../scripts/startup-script.sh") }"

  service_account {
    email  = "${ var.service_account_email }"
    scopes = "${ var.service_account_scopes }"
  }
}
