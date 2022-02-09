WITH payments AS (
    SELECT order_id,
           customer_id,
           amount
      FROM {{ ref('stg_payments')}}
)

SELECT *
  FROM payments