{% macro generate_database_name(custom_database_name=none, node=none) -%}

    {%- set maison -%}
      {{ node.fqn[-2] }}
    {%- endset -%}

    {% set is_sandbox =     (target.name in ['sbx']) %}
    {% set is_uat =         (target.name in ['uat']) %}
    {% set is_prd =         (target.name in ['prd']) %}
    {% set is_seeds =       (node.resource_type == 'seed') %}
    {% set is_test =        (node.resource_type == 'test') %}

    {% set is_layer_staging = ('staging' in node.fqn) %}
    {% set is_layer_data_warehouse = ('data_warehouse' in node.fqn) %}
    {% set is_layer_datamart = ('datamart' in node.fqn) %}

    {%- set error_unresolve_message -%}
        {{ node.resource_type | capitalize }} '{{ node.unique_id }}' unable to resolve database name.
    {%- endset -%}

    {%- if custom_database_name is not none -%}
        {%- set error_message -%}
            {{ node.resource_type | capitalize }} '{{ node.unique_id }}' has a database configured. This is not allowed.
        {%- endset -%}
        {{ exceptions.raise_compiler_error(error_message) }}

    {% elif node.resource_type == 'analysis' %} {{- target.database | trim -}}

    {# SANDBOX (target: sbx) #}
    
    {% elif is_sandbox %} 
      {%- if   is_layer_staging -%}         {{- 'ric-eu-dl-sa-dev-nprd' -}}
      {%- elif is_layer_data_warehouse -%}  {{- 'ric-eu-dl-vc-dev-nprd' -}}
      {%- elif is_layer_datamart -%}        {{- 'ric-eu-dl-cl-rev-etl-dev-nprd' -}}
      {%- elif is_seeds -%}                 {{- 'ric-eu-dl-sa-dev-nprd' -}}
      {%- elif is_test -%}                  {{- target.database | trim -}}
      {%- else -%}                          {{ exceptions.raise_compiler_error(error_unresolve_message) }}
      {%- endif -%}


    {# UAT (target: uat) #}
    {% elif is_uat %}
      {%- if   is_layer_staging -%}         {{- 'ric-eu-dl-sa-dev-nprd' -}}
      {%- elif is_layer_data_warehouse -%}  {{- 'ric-eu-dl-vc-dev-nprd' -}}
      {%- elif is_layer_datamart -%}        {{- 'ric-eu-dl-cl-rev-etl-dev-nprd' -}}
      {%- elif is_seeds -%}                 {{- 'ric-eu-dl-sa-dev-nprd' -}}
      {%- elif is_test -%}                  {{- target.database | trim -}}
      {%- else -%}                          {{ exceptions.raise_compiler_error(error_unresolve_message) }}
      {%- endif -%}

    {# PRD (target: prd) #}
    {% elif is_uat %}
      {%- if   is_layer_staging -%}         {{- 'ric-eu-dl-sa-dev-nprd' -}}
      {%- elif is_layer_data_warehouse -%}  {{- 'ric-eu-dl-vc-dev-nprd' -}}
      {%- elif is_layer_datamart -%}        {{- 'ric-eu-dl-cl-rev-etl-dev-nprd' -}}
      {%- elif is_seeds -%}                 {{- 'ric-eu-dl-sa-dev-nprd' -}}
      {%- elif is_test -%}                  {{- target.database | trim -}}
      {%- else -%}                          {{ exceptions.raise_compiler_error(error_unresolve_message) }}
      {%- endif -%}

    {%- elif is_test -%}
      {{- target.database | trim -}}
    {%- else -%}
      {{ exceptions.raise_compiler_error(error_unresolve_message) }}
    {%- endif -%}
{%- endmacro %}
