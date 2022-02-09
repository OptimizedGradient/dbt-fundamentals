SELECT id AS payment_id,
       orderid AS order_id,
       paymentmethod,
       status,
       -- amount are in cents
       amount/100 AS amount,
       created AS created_at
  FROM raw.stripe.payment