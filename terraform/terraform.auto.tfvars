node_pool_mds_config = {
  name           = "dbt"
  node_count     = 1
  min_node_count = 1
  max_node_count = 2
  machine_type   = "max_pods_per_node"
  tags           = ["mds", "dbt"]
}