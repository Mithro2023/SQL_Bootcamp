-- SECTION 1.1: SQL Statement Fundamentals

-- SELECT | FROM
SELECT *
FROM actor;

SELECT first_name, Last_name
FROM actor;

-- SELECT | FROM Challenge
-- Find all the customers first and last name and email address
SELECT first_name, last_name, email
FROM customer;

-- DISTINCT 
SELECT DISTINCT release_year
FROM film;

SELECT DISTINCT rental_rate
FROM film;

-- DISTINCT Challenge
-- Find the distinct rating types our films could have in our database,
SELECT DISTINCT rating
FROM film;

-- COUNT 
SELECT COUNT(amount)
FROM payment;

SELECT COUNT(DISTINCT amount)
FROM payment;

-- WHERE
SELECT *
FROM customer
WHERE first_name = 'Jared';

-- AND | OR
SELECT title
FROM film
WHERE rental_rate > 4 AND replacement_cost >= 19.99
AND rating = 'R';

SELECT COUNT (title)
FROM film
WHERE rental_rate > 4 AND replacement_cost >= 19.99
AND rating = 'R';

SELECT title
FROM film
WHERE rating = 'R' OR rating = 'PG-13';

-- WHERE | AND Challenge
-- Ch:1 what is the email for the customer with the name Nancy Thomas
-- Ch:2 Give customer the description for the movie name Outlaw Hanky
-- Ch:3 Get the phone number for the customer who lives at '259 Ipoh Drive'

--Ch 1
SELECT email
FROM customer
WHERE first_name = 'Nancy' AND last_name = 'Thomas';

--Ch 2
SELECT description
FROM film
WHERE title = 'Outlaw Hanky';

-- Ch 3
SELECT phone
FROM address
WHERE address = '259 Ipoh Drive';

-- ORDER BY 
SELECT *
FROM customer
ORDER BY first_name;

SELECT store_id, first_name, last_name
FROM customer
ORDER BY store_id desc, first_name;

-- LIMIT
SELECT *
FROM payment
WHERE amount <> 0
ORDER BY payment_date desc
LIMIT 10;

-- ORDER BY | LIMIT Challenge
-- Ch:1 What are the customers ids of the first 20 customer who created a payment
-- Ch:2 What are the titles of the 5 shortest movies
-- Ch:3 If the customer can watch any movie that is 20 mins or less, how many options does she have

-- Ch 1
SELECT customer_id
FROM payment
WHERE amount <> 0
ORDER BY payment_date
LIMIT 20;

-- Ch 2
SELECT title, length
FROM film
ORDER BY length
LIMIT 5;

-- Ch 3
SELECT COUNT(title)
FROM film
where length <= 50;

-- BETWEEN | NOT BETWEEN
SELECT *
FROM payment
WHERE amount BETWEEN 8 AND 9;

SELECT *
FROM payment
WHERE payment_date NOT BETWEEN '2007-02-01' AND '2007-02-15'; 

-- IN | NOT IN
SELECT *
FROM payment
WHERE amount IN (0.99, 1.98, 1.99);

SELECT *
FROM customer
WHERE first_name IN ('John', 'Jake', 'Mary');

SELECT *
FROM payment
WHERE amount NOT IN (0.99, 1.99, 7.99);

-- LIKE | NOT LIKE | ILIKE
SELECT *
FROM customer
WHERE first_name LIKE 'J%' AND last_name LIKE 'S%';

SELECT *
FROM customer
WHERE first_name LIKE '%th%';

SELECT *
FROM customer
WHERE first_name LIKE '__th__';

SELECT *
FROM customer
WHERE first_name LIKE '_ar%' AND last_name NOT LIKE 'A%'
ORDER BY first_name; 

SELECT *
FROM customer
WHERE first_name ILIKE 'j%' AND last_name ILIKE 'a%';

-- Overview Challenge (for so far)
-- Ch:1 How many payment transaction were greater than $5.00?
-- Ch:2 How many actors have a first name that starts with the letter p?
-- Ch:3 How many unique districts are our customers from?
-- Ch:4 Retrieve the list of names for those distinct districts from the previous question?
-- Ch:5 How many films have a rating of R and a replacement cost between $5 and $15?
-- Ch:6 How many films have the word Truman somewhere in the title?

-- Ch 1 
SELECT COUNT(payment_id)
FROM payment
WHERE amount > 5.00;

-- Ch 2
SELECT COUNT(actor_id)
FROM actor
WHERE first_name LIKE 'P%';

-- Ch 3
SELECT COUNT(DISTINCT(district))
FROM address;

-- Ch 4
SELECT DISTINCT district
FROM address;

-- Ch 5
SELECT COUNT(film_id)
FROM film
WHERE rating = 'R' AND replacement_cost BETWEEN 5 AND 15;

-- Ch 6
SELECT COUNT(film_id)
FROM film
WHERE title ILIKE '%Truman%';
