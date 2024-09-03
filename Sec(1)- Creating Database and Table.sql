-- Creating Database and Table

-- CREATE TABLE
CREATE TABLE account(
	user_id SERIAL PRIMARY KEY,
	username VARCHAR(45) UNIQUE NOT NULL,
	password VARCHAR(45) NOT NULL,
	email VARCHAR(250) UNIQUE NOT NULL,
	created_on TIMESTAMP NOT NULL,
	last_login TIMESTAMP
);  -- (only use SERIAL for primary key)

CREATE TABLE job(
	job_id SERIAL PRIMARY KEY,
	job_name VARCHAR(250) UNIQUE NOT NULL
);

CREATE TABLE information(
	info_id SERIAL PRIMARY KEY,
	title VARCHAR(200) NOT NULL,
	person VARCHAR(200) NULL NULL UNIQUE
);

-- -- Creating Table (Foreign Key example)
CREATE TABLE account_job(
	user_id INTEGER REFERENCES account(user_id),
	job_id INTEGER REFERENCES job(job_id),
	hire_date TIMESTAMP NOT NULL
);  -- (Look here we used Interger not SERIAL because it's not Primary key here)

SELECT * FROM account;
SELECT * FROM job;
SELECT * FROM account_job;

-- INSERT 
INSERT INTO account(user_id,username,password,email,created_on)
VALUES
	(1,'Bob','king','bob@gmail.com',CURRENT_TIMESTAMP);

INSERT INTO job(job_id,job_name)
VALUES
	(1, 'Doctor'),
	(2, 'Teacher');

-- -- INSERT (make sure the value exist in the previous 2 table, because this table include foreign key)
INSERT INTO account_job(user_id, job_id, hire_date)
VALUES 
	(1,1,'2022-03-01'); (-- this means bob the doctor was hire in 2022-03-01)

-- UPDATE
UPDATE account
SET last_login = CURRENT_TIMESTAMP;

UPDATE account
SET last_login = created_on;

UPDATE account
SET last_login = '2024-09-02'
WHERE last_login IS NULL;

-- -- UPDATE (update one table value with other table)
UPDATE account_job
SET hire_date = account.created_on
FROM account
WHERE account_job.user_id = account.user_id; --(in join, we use ON here)

-- -- UPDATE (run and return value)
UPDATE account
SET last_login = CURRENT_TIMESTAMP
RETURNING email,created_on,last_login;

-- DELETE 
INSERT INTO job(job_id,job_name)
VALUES
	(3,'data analyst'),
	(4, 'engineer');

DELETE FROM job
WHERE job_name = 'data analyst'
RETURNING job_id, job_name;

-- ALTER
SELECT * FROM information;
SELECT * FROM info;

ALTER TABLE information
RENAME TO info;  -- (rename table)

ALTER TABLE info
RENAME COLUMN person to people;  -- (rename column)

ALTER TABLE info
ALTER COLUMN people DROP NOT NULL;  -- (to drop not null command from where we created the table from)

-- DROP 
ALTER TABLE info
DROP COLUMN people;

ALTER TABLE info
DROP COLUMN IF EXISTS people;

-- CHECK Constraint
CREATE table employee(
	employee_id SERIAL PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	birthdate DATE CHECK(birthdate > '1950-01-01'),
	hire_date DATE CHECK(hire_date > birthdate),
	salary INTEGER CHECK(salary > 0)
);

INSERT INTO employee(employee_id,first_name,last_name,birthdate,hire_date,salary)
VALUES
-- (1, 'Rohit', 'Kumar','1949-02-13','2001-05-15',95000); -- (this won't work because the birthdate doesn't meet the condition)
-- (1, 'Rohit', 'Kumar','1985-02-13','2001-05-15',95000), -- (this will run)
-- (2, 'John', 'Smith','1980-02-15','2009-09-18',-83000); -- (again, this won't work because the salary doesn't meet the condition)
	(2, 'John', 'Smith','1980-02-15','2001-05-15',83000); --(this will run)

SELECT * FROM employee;