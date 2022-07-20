
resource "google_container_node_pool" "dbt" {
  count      = contains(keys(module.globals.globalvar.env_mapping_project_ops), var.envvar.MYENV) ? 1 : 0
  project    = var.envvar.PROJECTS["ops_project"]
  name       = "composer"
  location   = var.envvar.GKE.zone
  cluster    = google_container_cluster.primary[0].name
  node_count = 2

  node_config {
    preemptible  = contains(["uat"], var.envvar.MYENV) ? true : false
    machine_type = var.envvar.COMPOSER.node_config_k8s_machine_type

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = var.cloud_composer_sa
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  upgrade_settings {
    max_surge       = 2
    max_unavailable = 0
  }

  autoscaling {
    max_node_count = var.envvar.GKE.max_node_count
    min_node_count = var.envvar.GKE.min_node_count
  }

  max_pods_per_node = var.envvar.GKE.max_pods_per_node
}
