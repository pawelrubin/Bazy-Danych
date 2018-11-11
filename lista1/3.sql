SELECT title, name
FROM film JOIN language ON language.lang
WHERE description LIKE '%Documentary%';