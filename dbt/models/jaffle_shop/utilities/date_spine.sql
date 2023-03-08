{{
    config(
        alias = 'dates_2020',
        materialized = 'table',
    )
}}



{{ dbt_utils.date_spine(
    datepart="day",
    start_date="cast('2020-01-01' as date)",
    end_date="cast('2020-12-11' as date)"
   )
}}