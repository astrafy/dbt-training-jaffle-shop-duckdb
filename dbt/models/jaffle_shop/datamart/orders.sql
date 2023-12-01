{{
  config(
    partition_by={
        "field": "order_date",
        "data_type": "date",
        "granularity": "day"
    },
    alias = "orders_global",
    cluster_by=["customer_id", "status", "customer_status"]
    )
}}

with orders as (

    select * from {{ ref('int_order_payments_pivoted') }}

)
,
customers as (

    select * from {{ ref('int_customer_order_history_joined') }}

)
,
final as (

    select
        *
    from orders
    left join customers using (customer_id)

)

select * from final
