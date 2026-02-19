provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
  default_labels = {
    lab         = var.lab_number
    app_name    = var.app_name
    department  = var.department
    company     = var.company
    environment = var.environment
    cost_center = var.cost_center
    deployed_by = "terraform"
  }
}
