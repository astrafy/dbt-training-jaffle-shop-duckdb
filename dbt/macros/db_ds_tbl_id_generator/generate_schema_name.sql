{% macro generate_schema_name(custom_schema_name=none, node=none) -%}

    {% set is_elementary =     ('elementary' in node.fqn[0])  %}
    {% set is_project_evaluator = ('dbt_project_evaluator' in node.fqn) %}
    {% set is_dbt_artifact = ('dbt_artifacts' in node.package_name) | as_bool %}
    {% set is_sbx =         ('sbx' in target.name ) %}
    {% set is_prd =         ('prd' in target.name ) %}

    {% if is_sbx %}
        {% set suffix =     "sbx" %}
    {% elif is_prd %}
        {% set suffix =     "prd" %}
    {%- else -%}
      {{ exceptions.raise_compiler_error(error_unresolve_message) }}
    {%- endif -%}

    {%- if custom_schema_name is not none -%}
        {# handling test #}
        {%- if node.resource_type == 'test' -%}  {{- 'bqdts_' ~ node.tags[0] ~ '_tests_' ~ target.name -}}
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

    {# handling elementary #}
    {%- elif custom_schema_name is none and is_elementary -%}
        {{- 'bqdts_' ~ suffix ~ node.tags[0] ~ '_elementary' -}}

    {# handling dbt project evaluator #}
    {%- elif custom_schema_name is none and is_project_evaluator -%}
        {{- 'bqdts_' ~ suffix ~ node.tags[0] ~ '_project_evaluator' -}}

    {# handling dbt_artifacts package #}
    {%- elif custom_schema_name is none and is_dbt_artifact -%}
        {{- 'bqdts_' ~ target.name ~ '_artifacts' -}}

    {%- elif custom_schema_name is none -%}
        {{- 'bqdts_' ~ target.name ~ '_' ~ node.tags[0]  -}}
    {%- endif -%}

{%- endmacro %}
