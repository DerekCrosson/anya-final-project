resource "google_project_service" "required_services" {
  project = "${ var.project_id }"

  for_each = toset( "${ var.service_list }" )
    service = each.key

  timeouts {
    create = "5m"
    update = "5m"
  }

  disable_dependent_services = true
}
