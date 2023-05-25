select *
from {{ ref('jaffle_dp_1', 'customers') }}