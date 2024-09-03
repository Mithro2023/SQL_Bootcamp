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
	