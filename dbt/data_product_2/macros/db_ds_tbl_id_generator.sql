
{% macro generate_database_name(custom_database_name=none, node=none) -%}
    {{ jaffle_common.generate_database_name(custom_database_name, node) }}
{%- endmacro %}

{% macro generate_schema_name(custom_schema_name=none, node=none) -%}
    {{ jaffle_common.generate_schema_name(custom_schema_name, node) }}
{%- endmacro %}

{% macro generate_alias_name(custom_alias_name=none, node=none) -%}
    {{ jaffle_common.generate_alias_name(custom_alias_name, node) }}
{%- endmacro %}
