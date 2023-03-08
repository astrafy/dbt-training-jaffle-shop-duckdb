{{
    config(
        alias = 'crypto_eth',
        materialized = 'table',
    )
}}

WITH a AS (
    SELECT *
    FROM {{ source('crypto', 'balances') }}
    WHERE eth_balance BETWEEN 1 AND 50
)

SELECT *
FROM a
LEFT JOIN {{ source('crypto', 'contracts') }}
USING(address)