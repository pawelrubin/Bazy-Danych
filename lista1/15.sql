CREATE VIEW avg_amount_for_customers AS
SELECT customer_id, AVG(amount) AS avg_amount
FROM payment
GROUP BY customer_id;

select customer_id from avg_amount_for_customers WHERE avg_amount > (SELECT AVG(amount) FROM payment WHERE payment_date LIKE '2005-07-07%');
