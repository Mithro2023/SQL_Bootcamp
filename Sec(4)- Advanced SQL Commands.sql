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