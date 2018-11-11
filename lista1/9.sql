SELECT DISTINCT C.first_name, C.last_name
FROM rental R JOIN rental RR ON R.customer_id = RR.customer_id JOIN customer C ON R.customer_id = C.customer_id
WHERE R.staff_id < RR.staff_id

