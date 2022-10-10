data "tfe_outputs" "gke" {
  organization = "astrafy"
  workspace    = "gke"
}


resource "google_container_node_pool" "dbt" {
  project    = var.project_id_gke
  name       = var.node_pool_dbt_config["name"]
  location   = var.google_cloud_zone
  cluster    = data.tfe_outputs.gke.values.gke_cluster_name
  node_count = var.node_pool_dbt_config["node_count"]

  node_config {
    preemptible  = true
    machine_type = var.node_pool_dbt_config["machine_type"]

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = data.tfe_outputs.gke.values.gke_service_account
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }

  management {
    auto_repair  = true
    auto_upgrade = false
  }

  upgrade_settings {
    max_surge       = 2
    max_unavailable = 0
  }

  autoscaling {
    min_node_count = var.node_pool_dbt_config["min_node_count"]
    max_node_count = var.node_pool_dbt_config["max_node_count"]
  }

  max_pods_per_node = var.node_pool_dbt_config["max_pods_per_node"]
}
