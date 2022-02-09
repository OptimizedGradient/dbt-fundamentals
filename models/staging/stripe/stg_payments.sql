SELECT id AS customer_id,
       orderid AS order_id,
       paymentmethod,
       status,
       amount,
       created,
       _batched_at
  FROM raw.stripe.payment