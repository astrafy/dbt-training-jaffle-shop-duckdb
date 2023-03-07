{% macro generate_database_name(custom_database_name=none, node=none) -%}

    {# Environments helpers variables #}
    {% set is_sandbox =     (target.name in ['sbx']) %}
    {% set is_prd =         (target.name in ['prd']) %}

    {# Packages helpers variables #}
    {% set is_project_evaluator = ('dbt_project_evaluator' in node.fqn) %}
    {% set is_elementary =     ('elementary' in node.fqn[0])  %}
    {% set is_metrics =     ('metrics' in node.fqn[0])  %}
    {% set is_monitoring        = (is_elementary or is_dbt_artifact or is_project_evaluator or is_metrics) %}

    {# Data layers helpers variables #}
    {% set is_seeds =       (node.resource_type == 'seed') %}
    {% set is_test =        (node.resource_type == 'test') %}
    {% set is_layer_staging = ('staging' in node.fqn) and not is_monitoring %}
    {% set is_layer_intermediate = ('intermediate' in node.fqn) and not is_monitoring %}
    {% set is_layer_data_warehouse = ('data_warehouse' in node.fqn) and not is_monitoring %}
    {% set is_layer_datamart = ('datamart' in node.fqn) and not is_monitoring %}

    {% set is_on_end_hook = ('hooks' in node.fqn) %}

    {%- set error_unresolve_message -%}
        {{ node.resource_type | capitalize }} '{{ node.unique_id }}' unable to resolve database name.
    {%- endset -%}

    {# Handle dbt hooks #}
    {%- if is_on_end_hook -%}
      {{- target.database | trim -}}

    {% elif node.resource_type == 'analysis' %}
        {{- target.database | trim -}}

    {# SANDBOX (target: sbx) #}
    {% elif is_sandbox %}

      {%- if   is_layer_staging -%}         {{- env_var('GCP_PROJECT') -}}
      {%- elif is_layer_intermediate -%}    {{- env_var('GCP_PROJECT') -}}
      {%- elif is_layer_data_warehouse -%}  {{- env_var('GCP_PROJECT') -}}
      {%- elif is_layer_datamart -%}        {{- env_var('GCP_PROJECT') -}}
      {%- elif is_seeds -%}                 {{- env_var('GCP_PROJECT') -}}
      {%- elif is_test -%}                  {{- env_var('GCP_PROJECT') -}}

      {%- elif is_project_evaluator -%}     {{- env_var('GCP_PROJECT') -}}
      {%- elif is_elementary -%}            {{- env_var('GCP_PROJECT') -}}
      {%- elif is_metrics -%}               {{- env_var('GCP_PROJECT') -}}

      {%- else -%}
          {{ exceptions.raise_compiler_error(error_unresolve_message) }}
      {%- endif -%}

    {# PRD (target: prd) #}
    {% elif is_prd %}
      {%- if   is_layer_staging -%}         {{- env_var('GCP_PROJECT') -}}
      {%- elif is_layer_intermediate -%}    {{- env_var('GCP_PROJECT') -}}
      {%- elif is_layer_data_warehouse -%}  {{- env_var('GCP_PROJECT') -}}
      {%- elif is_layer_datamart -%}        {{- env_var('GCP_PROJECT') -}}
      {%- elif is_seeds -%}                 {{- env_var('GCP_PROJECT') -}}
      {%- elif is_test -%}                  {{- env_var('GCP_PROJECT') -}}

      {%- elif is_project_evaluator -%}     {{- env_var('GCP_PROJECT') -}}
      {%- elif is_elementary -%}            {{- env_var('GCP_PROJECT') -}}
      {%- elif is_metrics -%}               {{- env_var('GCP_PROJECT') -}}

      {%- else -%}
          {{ exceptions.raise_compiler_error(error_unresolve_message) }}
      {%- endif -%}

    {%- endif -%}
{%- endmacro %}
