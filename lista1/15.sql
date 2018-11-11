CREATE VIEW avg_amount_for_customers AS
SELECT c.customer_id, AVG(p.amount) AS avg_amount
FROM customer c JOIN payment p on c.customer_id = p.customer_id
GROUP BY c.customer_id;

CREATE VIEW avg_amount_on_2005_07_07 AS
SELECT AVG(p.amount) AS avg_0707
FROM customer c JOIN payment p on c.customer_id = p.customer_id
WHERE payment_date > '20050706' AND payment_date < '20050708';#LIKE '2005-07-07%';

drop view avg_amount_on_2005_07_07

select customer_id from avg_amount_for_customers JOIN avg_amount_on_2005_07_07 WHERE avg_amount > avg_0707
