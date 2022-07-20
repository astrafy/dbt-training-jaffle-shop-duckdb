node_pool_dbt_config = {
  name              = "dbt"
  node_count        = 1
  min_node_count    = 1
  max_node_count    = 2
  max_pods_per_node = 110
  machine_type      = "e2-standard-4"
  tags              = ["mds", "dbt"]
}
