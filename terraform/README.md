# dbt Astrafy Terraform

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | 4.11.0 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | 4.11.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.11.0 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_container_node_pool.dbt](https://registry.terraform.io/providers/hashicorp/google/4.11.0/docs/resources/container_node_pool) | resource |
| [terraform_remote_state.gke_internal](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_google_cloud_region"></a> [google\_cloud\_region](#input\_google\_cloud\_region) | Region for deployment of resources | `string` | n/a | yes |
| <a name="input_google_cloud_zone"></a> [google\_cloud\_zone](#input\_google\_cloud\_zone) | Zone for deployment of resources | `string` | n/a | yes |
| <a name="input_node_pool_dbt_config"></a> [node\_pool\_dbt\_config](#input\_node\_pool\_dbt\_config) | Configuration variables for the Modern Data Stack node pool | <pre>object({<br>    name              = string<br>    machine_type      = string<br>    node_count        = number<br>    min_node_count    = number<br>    max_node_count    = number<br>    max_pods_per_node = number<br>    tags              = list(string)<br>  })</pre> | n/a | yes |
| <a name="input_project_id_gke"></a> [project\_id\_gke](#input\_project\_id\_gke) | Project ID for GKE project | `string` | n/a | yes |
| <a name="input_terraform_organization"></a> [terraform\_organization](#input\_terraform\_organization) | Terraform organization name | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
