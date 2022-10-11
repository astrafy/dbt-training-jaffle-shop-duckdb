variable "project_id_gke" {
  description = "Project ID for GKE project"
  type        = string
}

variable "terraform_organization" {
  description = "Terraform organization name"
  type        = string
}

variable "google_cloud_region" {
  description = "Region for deployment of resources"
  type        = string
}

variable "google_cloud_zone" {
  description = "Zone for deployment of resources"
  type        = string
}
