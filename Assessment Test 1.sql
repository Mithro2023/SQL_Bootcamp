-- ASSESSMENT TEST 1
-- 1. Return the customer IDs of customer who spend at least $110 with the staff member Id #2?
-- 2. How many gilms begin with the letter J?
-- 3. What customer has the highest customer ID number whose name satrts with an 'E' and has an address ID lower than 500?

-- ANS 1
SELECT customer_id, SUM(amount)
FROM payment
WHERE staff_id = 2
GROUP BY customer_id
HAVING SUM(amount) >= 110;

-- ANS 2
SELECT COUNT(film_id)
FROM film
WHERE title LIKE('J%'); 

-- ANS 3
SELECT first_name, last_name
FROM customer
WHERE first_name LIKE('E%') AND address_id < 500
ORDER BY customer_id DESC
LIMIT 1;