{% macro ut_stg_orders() %}
    (

    {% set records = [
        [58,1, "2018-03-01", "placed"],
        [59,2, "2018-03-01", "placed"]
    ] %}

    {% for record in records %}
        select {{ record[0] }} as order_id, {{ record[1] }} as customer_id, '{{ record[2] }}' as order_date, '{{ record[3] }}' as status
        {% if not loop.last %}
            union all
        {% endif %}
    {% endfor %}
    ) stg_orders

{% endmacro %}