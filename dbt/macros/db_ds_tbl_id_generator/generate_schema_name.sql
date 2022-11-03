{% macro generate_schema_name(custom_schema_name=none, node=none) -%}

    {% set is_dbt_artifact = ('dbt_artifacts' in node.package_name) | as_bool %}

    {# handling the udf #}
    {%- if custom_schema_name =='bqdts_udf' -%}
        {{ custom_schema_name -}}

    {# handling snapshot #}
    {%- elif custom_schema_name=='snapshot'  -%}
        {{- 'bqdts_' ~ node.fqn[1] -}}
        {{ default_schema }}

    {%- elif custom_schema_name is not none -%}
        {# handling test #}
        {%- if node.resource_type == 'test' -%}  {{- 'bqdts_' ~ node.fqn[1] ~ '_tests_' ~ target.name -}}
        {%- elif 're_data' in node.fqn  %}
          {{- 'bqdts_' ~ target.name ~ '_re_data' -}}
        {%- else -%}
            {%- set error_message -%}
            {{ node.resource_type | capitalize }} '{{ node.unique_id }}' has a schema configured. This is not allowed.
            {%- endset -%}
            {{ exceptions.raise_compiler_error(error_message) }}
        {%- endif -%}

    {%- elif custom_schema_name is none and node.path.split('/')[0] == 'dbt_logs' -%}
        {{- 'bqdts_dbt_' ~ target.name ~ '_logs' -}}

    {%- elif node.resource_type == 'seed' -%}
        {{- 'bqdts_' ~ target.name ~ '_mapping' -}}

    {# handling dbt_artifacts package #}
    {%- elif custom_schema_name is none and is_dbt_artifact -%}
        {{- 'bqdts_' ~ target.name ~ '_artifacts' -}}

    {%- elif custom_schema_name is none -%}
        {{- 'bqdts_' ~ target.name ~ '_' ~ node.fqn[1] -}}
    {%- endif -%}

{%- endmacro %}
