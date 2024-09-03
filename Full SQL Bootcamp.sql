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

-- SECTION 2: Aggregation & Group by Statements

-- MIN | MAX
SELECT MIN(replacement_cost)
FROM film;

SELECT MAX(replacement_cost)
FROM film;

SELECT MAX(replacement_cost), MIN(replacement_cost)
FROM film;

-- ROUND | AVERAGE | SUM
SELECT AVG(amount)
FROM payment;

SELECT ROUND(AVG(amount),2)
FROM payment;

SELECT SUM(amount)
FROM payment;

-- GROUP BY
SELECT customer_id
FROM customer
GROUP BY customer_id
ORDER BY customer_id;

SELECT customer_id, SUM(amount)
FROM payment
GROUP BY customer_id
ORDER BY SUM(amount);

SELECT customer_id, payment_id, SUM(amount)
FROM payment
GROUP BY customer_id, payment_id
ORDER BY payment_id, customer_id;

-- DATE | GROUP BY DATE
SELECT DATE(payment_date), SUM(amount)
FROM payment
GROUP BY DATE(payment_date)
ORDER BY SUM(amount) desc;

SELECT customer_id, DATE(payment_date), SUM(amount)
FROM payment
GROUP BY customer_id, DATE(payment_date)
ORDER BY SUM(amount) desc;

-- GROUP BY Challenge 
-- Ch:1 How many payments did each stuff member handle and who gets the bonus?
-- Ch:2 What is the average replacement cost per MPAA rating
-- Ch:3 What are the csutomer ids of the top 5 customer by total spend?

-- Ch 1
SELECT staff_id, COUNT(payment_id)
FROM payment
GROUP BY staff_id
ORDER BY staff_id;

-- Ch 2
SELECT rating, ROUND(AVG(replacement_cost),2)
FROM film
GROUP BY rating
ORDER BY AVG(replacement_cost);

-- Ch 3
SELECT customer_id, SUM(amount)
FROM payment
GROUP BY customer_id
ORDER BY SUM(amount) DESC
LIMIT 5;

-- HAVING
SELECT customer_id, SUM(amount)
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 150;

SELECT store_id, COUNT(customer_id)
FROM customer
GROUP BY store_id
HAVING COUNT(customer_id) > 300;

-- HAVING Challenge 
-- Ch:1 Customer who had 40 or more transaction payment are eligible for platinum status; who are they?
-- Ch:2 What are the customer ids of customers who have spent more than $100 in payment transaction with our staff_id #2?

-- Ch 1
SELECT customer_id, COUNT(payment_id)
FROM payment
GROUP BY customer_id
HAVING COUNT(payment_id) >= 40;

-- Ch 2 (there are more ways to do it but thing are the common 2
SELECT customer_id, staff_id, SUM(amount)
FROM payment
WHERE staff_id = 2
GROUP BY customer_id, staff_id
HAVING SUM(amount) > 100;

SELECT customer_id, SUM(amount)
FROM payment
WHERE staff_id = 2
GROUP BY customer_id
HAVING SUM(amount) > 100;

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

-- AS
SELECT SUM(amount) AS total_amount
FROM payment;

SELECT customer_id, SUM(amount) AS total_amount
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 100;

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

-- SECTION 4: Advanced SQL Commands

-- TIMESTAMPS
SHOW ALL;
SHOW timezone;
SELECT now();
SELECT timeofday();
SELECT current_time;
SELECT current_date;

-- EXTRACT
SELECT EXTRACT(year FROM payment_date) as payment_year
FROM payment;

SELECT EXTRACT(month FROM payment_date) as payment_month
FROM payment;

SELECT EXTRACT(quarter FROM payment_date) as payment_quarter
FROM payment;

SELECT EXTRACT(week FROM payment_date) as payment_week
FROM payment;

SELECT EXTRACT(day FROM payment_date) as payment_day
FROM payment;

-- AGE
SELECT AGE(payment_date)
FROM payment;

-- TO_CHAR
SELECT TO_CHAR(payment_date, 'month-dd-yyyy')
FROM payment;

SELECT TO_CHAR(payment_date, 'mon/yy')
FROM payment;

SELECT TO_CHAR(payment_date, 'day/MM/yy')
FROM payment;

-- TIMESTAMPS | EXTRACT Challenge
-- Ch1: During which month did payments occure and return back the full month name?
-- Ch2: How many payments occurred on a Monday?

-- Ch 1 (Both gives the right answer)
SELECT DISTINCT(EXTRACT(month FROM payment_date))
FROM payment;

SELECT DISTINCT(TO_CHAR(payment_date, 'MONTH'))
FROM payment;

-- Ch 2 (Both give the right answer)
SELECT COUNT(*)
FROM payment
WHERE EXTRACT(dow FROM payment_date) = 1; -- (1 is consider monday in SQL)

SELECT COUNT(*)
FROM payment
WHERE TO_CHAR(payment_date, 'Day') = 'Monday   '; --(The day has to be 9 charcter/spaces, so if it's not 9 make it 9)

-- MATHEMTICAL
SELECT rental_rate/replacement_cost
FROM film;

SELECT ROUND(rental_rate/replacement_cost, 2)*100 AS percent_cost
FROM film; -- (Get the answer in percentage)

SELECT 0.1 * amount as paid
FROM payment;

-- STRING
SELECT LENGTH(first_name)
FROM customer;

-- STRING (Concatenation)
SELECT first_name || last_name
FROM customer;

SELECT first_name || ' ' || last_name AS full_name
FROM customer; -- (has a space between the first and last name)

SELECT UPPER(first_name) || ' ' || UPPER(last_name) AS full_name
FROM customer; -- (Full name in all capital letter)

-- STRING | LEFT
SELECT LOWER(LEFT(first_name,1)) || LOWER(last_name) || '@gmail.com' AS customer_mail
FROM customer; --( making customer gamils)

-- SUBQUERY
SELECT title, rental_rate
FROM film
WHERE rental_rate >
	(SELECT AVG(rental_rate)
	FROM film);

SELECT title, film_id
FROM film
WHERE film_id IN
	(SELECT film_id
	FROM inventory a
	JOIN rental b
	ON a.inventory_id = b.inventory_id
	WHERE return_date BETWEEN '2005-05-29' AND '2005-05-30')
	ORDER BY film_id;

-- SUBQUERY | EXISTS | NOT EXISTS
SELECT first_name, last_name
FROM customer a
WHERE EXISTS 
	(SELECT *
	FROM payment b
	WHERE b.customer_id = a.customer_id
	AND b.amount > 11);

SELECT first_name, last_name
FROM customer a
WHERE NOT EXISTS 
	(SELECT *
	FROM payment b
	WHERE b.customer_id = a.customer_id
	AND b.amount > 11);

-- SELF JOIN
SELECT a.title, b.title, a.length
FROM film a
INNER JOIN film b
ON a.film_id != b.film_id 
AND a.length = b.length;

-- SECTION 5: Conditional Expressions and Procedures

-- CASE
SELECT customer_id, first_name || ' ' || last_name AS full_name,
CASE 
	WHEN (customer_id <= 100) THEN 'premium'
	WHEN (customer_id BETWEEN 100 AND 200) THEN 'plus'
	ELSE 'normal'
END AS customer_class
FROM customer;  -- (it's often used for conditional expressions/ checking condition)

-- CASE Expression
SELECT customer_id, first_name || ' ' || last_name AS full_name,
CASE customer_id
	WHEN 1 THEN 'Winner'
	WHEN 10 THEN 'Second Place'
	ELSE 'normal'
END AS raffle_result
FROM customer;  -- (it's often used for checking equality)

-- CASE Expression| SUM
SELECT 
SUM
(CASE rental_rate
	WHEN 0.99 THEN 1
    ELSE 0
END) AS bargains,

SUM
(CASE rental_rate
	WHEN 2.99 THEN 1
	ELSE 0
END) AS regular,

SUM
(CASE rental_rate
	WHEN 4.99 THEN 1
    ELSE 0
END) AS premium
FROM film; -- (Very useful when suming, etc from the same coulmn for multiple results)

-- CASE | CASE Expression Challenge
-- Ch1: We want to know and compare the various amount of films we have per movie rating for r, pg, and pg13 rating.

-- Ch: 1
SELECT
SUM 
(CASE rating
	WHEN 'R' THEN 1
	ELSE 0
END) AS rating_r,

SUM 
(CASE rating
	WHEN 'PG' THEN 1
	ELSE 0
END) AS rating_pg,

SUM 
(CASE rating
	WHEN 'PG-13' THEN 1
	ELSE 0
END) AS rating_pg13

FROM film;

-- CAST
SELECT CAST('5' AS INTEGER); 
SELECT '5'::INTEGER; -- (Only in postgresql)
-- SELECT CAST('five' AS INTEGER);  --(this won't work since it's not reasonable)

SELECT 
CHAR_LENGTH(CAST(inventory_id AS VARCHAR))
FROM rental;  -- (to find the number of character each row contains in a column)

-- NULLIF
CREATE TABLE depts(
	firstname VARCHAR(50),
	department VARCHAR(50)
);

INSERT INTO depts(firstname, department)
VALUES
	('Amit','A'),
	('Sarah','A'),
	('Jose','B');

SELECT * FROM depts;

-- 1st way
SELECT 
SUM(CASE department 
	WHEN 'A' THEN 1
	ELSE 0
END)/
SUM(CASE department 
	WHEN 'B' THEN 1
	ELSE 0
END) AS department_ratio
FROM depts;

-- 2nd way
SELECT (
SUM(CASE WHEN department ='A' THEN 1 ELSE 0 END)/
SUM(CASE WHEN department ='B' THEN 1 ELSE 0 END)
)AS department_ratio
FROM depts;

DELETE FROM depts
WHERE department = 'B';

SELECT (
SUM(CASE WHEN department ='A' THEN 1 ELSE 0 END)/
NULLIF(SUM(CASE WHEN department ='B' THEN 1 ELSE 0 END),0)
)AS department_ratio
FROM depts;

-- VIEW
CREATE VIEW customer_info AS
SELECT first_name, last_name, address
FROM customer a
JOIN address b
ON a.address_id = b.address_id;

SELECT *
FROM customer_info;

-- CREATE OR REPLACE VIEW (is used to update/alter the view table)
CREATE OR REPLACE VIEW customer_info AS
SELECT first_name, last_name, address, customer_id
FROM customer a
JOIN address b
ON a.address_id = b.address_id;

DROP VIEW customer_info; -- (to drop the view)
DROP VIEW IF EXISTS customer_info;
ALTER VIEW customer_info RENAME TO customer_address; -- (To change the view table name)

SELECT *
FROM customer_address;