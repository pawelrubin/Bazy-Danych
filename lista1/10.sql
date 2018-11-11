SELECT country
FROM (
     SELECT country, COUNT(city) AS num
     FROM country
     JOIN city c on country.country_id = c.country_id
     GROUP BY country
     ) AS tab
     JOIN (
          SELECT COUNT(city) AS numCanada
          FROM city
          JOIN country c2 on city.country_id = c2.country_id
          WHERE c2.country="Canada"
          ) AS tab2
WHERE num >= numCanada
group by country;
