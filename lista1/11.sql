SELECT *
FROM (
  SELECT customer.first_name AS cust_fn, customer.last_name AS cust_ln,
    COUNT(rental_id) AS num, num_peter
  FROM customer JOIN rental r on customer.customer_id = r.customer_id
  JOIN (
    SELECT COUNT(rental_id) AS num_peter
    FROM rental
    JOIN customer c ON rental.customer_id = c.customer_id
    WHERE email='PETER.MENARD@sakilacustomer.org'
  ) AS tab1
  GROUP BY r.customer_id
) AS tab
WHERE num > num_peter
