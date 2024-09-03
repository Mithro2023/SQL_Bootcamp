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

-- AS
SELECT SUM(amount) AS total_amount
FROM payment;

SELECT customer_id, SUM(amount) AS total_amount
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 100;

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