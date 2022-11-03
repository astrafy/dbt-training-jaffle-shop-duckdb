{% set my_metric_yml -%}

metrics:
  - name: develop_metric
    model: ref('orders')
    label: Total Discount ($)
    timestamp: order_date
    time_grains: [day, week, month]
    calculation_method: average
    expression: amount
    dimensions:
      - status
      - had_credit_card_payment

{%- endset %}

select *
from {{ metrics.develop(
        develop_yml=my_metric_yml,
        grain='month',
        metric_list=['develop_metric'],
        dimensions=['status']
        )
    }}
