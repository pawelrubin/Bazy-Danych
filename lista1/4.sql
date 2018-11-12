SELECT title
FROM film_list
WHERE category = 'Documentary' AND description NOT LIKE '%Documentary%';
