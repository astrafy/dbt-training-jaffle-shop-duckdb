{% macro generate_schema_name(custom_schema_name=none, node=none) -%}

    {# Environments helper variables #}
    {% set is_sbx =         ('sbx' in target.name ) %}
    {% set is_prd =         ('prd' in target.name ) %}

    {% if is_sbx %}
        {% set suffix =     "sbx" %}
    {% elif is_prd %}
        {% set suffix =     "prd" %}
    {%- endif -%}

    {% set is_elementary =     ('elementary' in node.fqn[0])  %}
    {% set is_project_evaluator = ('dbt_project_evaluator' in node.fqn) %}
    {% if is_elementary %} {% set package = "_elementary" %}
    {% elif is_project_evaluator %} {% set package = "_project_evaluator" %}
    {%- endif -%}

    {%- set error_message_schema_provided -%}
        {{ node.resource_type | capitalize }} '{{ node.unique_id }}' has a schema configured. This is not allowed.
    {%- endset -%}

    {%- set error_message_no_rules -%}
        {{ node.resource_type | capitalize }} '{{ node.unique_id }}' has no rules defined for its schema.
    {%- endset -%}

    {%- if custom_schema_name is not none -%}
        {# handling test #}
        {%- if node.resource_type == 'test' -%}  {{- 'bqdts_' ~ node.tags[0] ~ '_tests_' ~ target.name -}}
        {%- else -%}
            {%- set error_message -%}
            {{ node.resource_type | capitalize }} '{{ node.unique_id }}' has a schema configured. This is not allowed.
            {%- endset -%}
            {{ exceptions.raise_compiler_error(error_message) }}
        {%- endif -%}

    {# Handling schema for dbt packages #}
    {%- elif custom_schema_name is none and node.path.split('/')[0] == 'dbt_logs' -%}
        {{- 'bqdts_dbt_logs' -}}
    {%- elif node.resource_type == 'seed' and not is_project_evaluator -%}
        {{- 'bqdts_mapping' -}}
    {%- elif custom_schema_name is none and (is_elementary or is_project_evaluator) -%}
        {{- 'bqdts_' ~ node.tags[0] ~ package -}}

    {%- elif custom_schema_name is none -%}
        {{- 'bqdts_' ~ node.tags[0] -}}
    {%- endif -%}

{%- endmacro %}

