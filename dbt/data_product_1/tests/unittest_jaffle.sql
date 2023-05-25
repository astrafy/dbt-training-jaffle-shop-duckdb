{{ config(tags=['unit-test']) }}

{% call dbt_unit_testing.test('customers', 'should sum order values to calculate customer_lifetime_value') %}

  {% call dbt_unit_testing.mock_ref('stg_customers') %}
    select 1 as customer_id, '' as first_name, '' as last_name
  {% endcall %}

  {% call dbt_unit_testing.mock_ref('stg_orders') %}
    select 1001 as order_id, 1 as customer_id, null as order_date
    UNION ALL
    select 1002 as order_id, 1 as customer_id, null as order_date
  {% endcall %}

  {% call dbt_unit_testing.mock_ref('stg_payments') %}
    select 1001 as order_id, 10 as amount
    UNION ALL
    select 1002 as order_id, 10 as amount
  {% endcall %}

  {% call dbt_unit_testing.expect() %}
    select 1 as customer_id, 20 as customer_lifetime_value
  {% endcall %}
{% endcall %}