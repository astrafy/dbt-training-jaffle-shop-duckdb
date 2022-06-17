{%- macro generate_alias_name(custom_alias_name=none, node=none) -%}

    {%- if target.name == 'sbx' -%}
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
