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

variable "node_pool_dbt_config" {
  description = "Configuration variables for the Modern Data Stack node pool"
  type = object({
    name              = string
    machine_type      = string
    node_count        = number
    min_node_count    = number
    max_node_count    = number
    max_pods_per_node = number
    tags              = list(string)
  })
}
