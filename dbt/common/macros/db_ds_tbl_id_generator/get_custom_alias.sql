{%- macro generate_alias_name(custom_alias_name=none, node=none) -%}

    {% set is_elementary =     ('elementary' in node.fqn[0])  %}
    {% set is_project_evaluator = ('dbt_project_evaluator' in node.fqn) %}

    {%- if target.name == 'sbx' and not env_var('NO_PREFIX', false) and not (is_elementary or is_project_evaluator) -%}
        {%- if custom_alias_name is none -%}
            {{ env_var('USER') }}_{{ node.name }}
        {%- else -%}
            {{ env_var('USER') }}_{{ custom_alias_name | trim }}
        {%- endif -%}

    {%- else -%}
        {%- if custom_alias_name is none -%}
            {{ node.name }}
        {%- else -%}
            {{ custom_alias_name | trim }}
        {%- endif -%}
    {%- endif -%}

{%- endmacro %}
