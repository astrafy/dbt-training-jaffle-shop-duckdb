{% macro ut_stg_payments() %}
    (

    {% set records = [
        [1, 58,"coupon",2.0],
        [2, 59,"coupon",3.0]
    ] %}

    {% for record in records %}
        select {{ record[0] }} as payment_id, {{ record[1] }} as order_id, '{{ record[2] }}' as payment_method, {{ record[3] }} as amount
        {% if not loop.last %}
            union all
        {% endif %}
    {% endfor %}
    ) stg_payments

{% endmacro %}