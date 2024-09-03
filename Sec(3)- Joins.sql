-- SECTION 3: Joins

-- INNER JOIN
SELECT *
FROM payment 
INNER JOIN customer
ON payment.customer_id = customer.customer_id;

SELECT payment_id, a.customer_id, first_name, amount
FROM payment a
INNER JOIN customer b
ON a.customer_id = b.customer_id;

-- FULL OUTER JOIN
SELECT * 
FROM customer a
FULL OUTER JOIN payment b
ON a.customer_id = b.customer_id;

-- -- FULL OUTER JOIN (to find the unique rows in both table)
SELECT * 
FROM customer a
FULL OUTER JOIN payment b
ON a.customer_id = b.customer_id
WHERE a.customer_id IS null OR b.payment_id IS null;

-- -- To confirm the previous function is correct or not
SELECT COUNT(DISTINCT customer_id)
FROM payment;
SELECT COUNT(DISTINCT customer_id)
FROM customer;  -- both has same customer count, so no unique

-- LEFT JOIN
SELECT a.film_id, title, inventory_id
FROM film a
LEFT JOIN inventory b
ON a.film_id = b.film_id;

-- LEFT JOIN (unique to left table ot table(A))
-- Only the rows from table(A), not even the matching once from table(B)
SELECT a.film_id, title, inventory_id
FROM film a
LEFT JOIN inventory b
ON a.film_id = b.film_id
WHERE b.film_id IS null;

-- RIGHT JOIN
SELECT a.film_id, title, inventory_id
FROM film a
RIGHT JOIN inventory b
ON a.film_id = b.film_id;

-- RIGHT JOIN (unique to right table ot table(B))
-- Only the rows from table(B), not even the matching once from table(A)
SELECT a.film_id, title, inventory_id
FROM film a
RIGHT JOIN inventory b
ON a.film_id = b.film_id
WHERE a.film_id IS null;

-- JOIN challenge
-- Ch1: What are the email of the customers who live in California
-- Ch2: Get a list of al the movies "Nick Wahlberg" has been in?

-- Ch 1
SELECT customer_id, email, district
FROM customer a
INNER JOIN address b
ON a.address_id = b.address_id
WHERE b.district = 'California';

-- Ch 2 
SELECT title, first_name, last_name
FROM actor a
INNER JOIN film_actor b
ON a.actor_id = b.actor_id
INNER JOIN film c
ON b.film_id = c.film_id
WHERE first_name = 'Nick' AND last_name = 'Wahlberg';
