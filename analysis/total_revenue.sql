WITH total_revenue_by_payment AS (
    SELECT -- jinja select successful transactions
        {% for paymentmethod in ['credit_card', 'coupon', 'bank_transfer', 'gift_card'] %}
           SUM(CASE
                   WHEN status = 'success' AND paymentmethod = '{{ paymentmethod }}' THEN amount
                   ELSE 0
               END) AS successful_{{ paymentmethod }}_payment_sum,
        {% endfor %}
           -- jinja select failed transactions
        {% for paymentmethod in ['credit_card', 'coupon', 'bank_transfer', 'gift_card'] %}
           SUM(CASE
                   WHEN status = 'fail' AND paymentmethod = '{{ paymentmethod }}' THEN amount
                   ELSE 0
               END) AS failed_{{ paymentmethod }}_payment_sum {{ ',' if not loop.last }}
        {% endfor %}
      FROM {{ ref('stg_payments') }}
)

SELECT *
  FROM total_revenue_by_payment