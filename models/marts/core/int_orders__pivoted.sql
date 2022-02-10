{#- Setup and order a list of our payments we want to pivot -#}
{%- set jinja_payment_methods = ['bank_transfer', 'credit_card', 'coupon', 'gift_card'] -%}

-- gets base payments
WITH payments AS (
  SELECT *
    FROM {{ ref('stg_payments') }}
),

-- pivots payments with jinja
pivot_payment_type AS (
  SELECT order_id,
         -- jinja pivot out amounts by order id and payment method
         {% for paymentmethod in jinja_payment_methods -%}
         SUM(CASE
                 WHEN paymentmethod = '{{ paymentmethod }}' THEN amount
                 ELSE 0
             END) AS {{ paymentmethod }}_sum {{- ',' if not loop.last }}
         {%- endfor %}
    FROM payments
   WHERE status = 'success'
   GROUP BY order_id
)

-- get pivoted data
SELECT *
  FROM pivot_payment_type