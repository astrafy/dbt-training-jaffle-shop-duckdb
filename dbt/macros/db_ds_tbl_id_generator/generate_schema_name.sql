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
        {%- if node.resource_type == 'test' -%}  {{- 'bqdts_' ~ node.fqn[1] -}}
        {%- elif 're_data' in node.fqn  %}  {{- 'bqdts_re_data' -}}
        {%- else -%}
            {%- set error_message -%}
            {{ node.resource_type | capitalize }} '{{ node.unique_id }}' has a schema configured. This is not allowed.
            {%- endset -%}
            {{ exceptions.raise_compiler_error(error_message) }}
        {%- endif -%}

    {%- elif custom_schema_name is none and node.path.split('/')[0] == 'dbt_logs' -%}
        {{- 'bqdts_dbt_logs' -}}

    {%- elif node.resource_type == 'seed' -%}
        {{- 'bqdts_mapping' -}}

    {%- elif custom_schema_name is none and is_dbt_artifact -%}
        {{- var('dbt_artifacts_schema') | trim -}}

    {%- elif custom_schema_name is none -%}
        {{- 'bqdts_' ~ node.fqn[1] -}}
    {%- endif -%}

{%- endmacro %}
