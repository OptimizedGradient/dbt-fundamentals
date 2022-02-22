SELECT {{ dbt_utils.surrogate_key(['customer_id', 'order_date']) }} AS hash_id,
       customer_id,
       order_date,
       COUNT(*)
  FROM {{ ref('stg_orders') }}
 GROUP BY 1, 2, 3