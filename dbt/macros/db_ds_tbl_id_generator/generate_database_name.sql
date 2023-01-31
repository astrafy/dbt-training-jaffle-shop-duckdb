{% macro generate_database_name(custom_database_name=none, node=none) -%}

    {% set is_sandbox =     (target.name in ['sbx']) %}
    {% set is_prd =         (target.name in ['prd']) %}
    {% set is_seeds =       (node.resource_type == 'seed') %}
    {% set is_test =        (node.resource_type == 'test') %}
    {% set is_project_evaluator = ('dbt_project_evaluator' in node.fqn) %}
    {% set is_elementary =     ('elementary' in node.fqn[0])  %}
    {% set is_dbt_artifact = (('dbt_artifacts' in node.package_name) or ('dbt_artifacts' in node.raw_sql)) | as_bool %}
    {% set is_metrics =     ('metrics' in node.fqn[0])  %}

    {% set is_layer_staging = ('staging' in node.fqn) %}
    {% set is_layer_intermediate = ('intermediate' in node.fqn) %}
    {% set is_layer_data_warehouse = ('data_warehouse' in node.fqn) %}
    {% set is_layer_datamart = ('datamart' in node.fqn) %}

    {%- set error_unresolve_message -%}
        {{ node.resource_type | capitalize }} '{{ node.unique_id }}' unable to resolve database name.
    {%- endset -%}

    {%- if is_test -%}
      {{- 'dbt-demo-aaa' | trim -}}

    {% elif node.resource_type == 'analysis' %} {{- target.database | trim -}}

    {# SANDBOX (target: sbx) #}
    {% elif is_sandbox %}

      {%- if   is_layer_staging -%}         {{- 'dbt-demo-aaa' -}}
      {%- elif is_layer_intermediate -%}    {{- 'dbt-demo-aaa' -}}
      {%- elif is_layer_data_warehouse -%}  {{- 'dbt-demo-aaa' -}}
      {%- elif is_layer_datamart -%}        {{- 'dbt-demo-aaa' -}}
      {%- elif is_seeds -%}                 {{- 'dbt-demo-aaa' -}}
      {%- elif is_test -%}                  {{- 'dbt-demo-aaa' -}}

      {%- elif is_project_evaluator -%}     {{- 'dbt-demo-aaa' -}}
      {%- elif is_dbt_artifact -%}          {{- 'dbt-demo-aaa' -}}
      {%- elif is_elementary -%}            {{- 'dbt-demo-aaa' -}}
      {%- elif is_metrics -%}               {{- 'dbt-demo-aaa' -}}

      {%- else -%}
      {{ log("TOTO: " ~ node) }}
      {{ exceptions.raise_compiler_error(error_unresolve_message) }}
    {%- endif -%}

    {# PRD (target: prd) #}
    {% elif is_prd %}
      {%- if   is_layer_staging -%}         {{- 'dbt-demo-aaa' -}}
      {%- elif is_layer_intermediate -%}    {{- 'dbt-demo-aaa' -}}
      {%- elif is_layer_data_warehouse -%}  {{- 'dbt-demo-aaa' -}}
      {%- elif is_layer_datamart -%}        {{- 'dbt-demo-aaa' -}}
      {%- elif is_seeds -%}                 {{- 'dbt-demo-aaa' -}}
      {%- elif is_test -%}                  {{- 'dbt-demo-aaa' -}}

      {%- elif is_project_evaluator -%}     {{- 'dbt-demo-aaa' -}}
      {%- elif is_dbt_artifact -%}          {{- 'dbt-demo-aaa' -}}
      {%- elif is_elementary -%}            {{- 'dbt-demo-aaa' -}}
      {%- elif is_metrics -%}               {{- 'dbt-demo-aaa' -}}
    {%- else -%}
        {{ exceptions.raise_compiler_error(error_unresolve_message) }}
    {%- endif -%}

    {%- endif -%}
{%- endmacro %}
