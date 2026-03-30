-- 1. CREATE DATABASE
SHOW DATABASES;
CREATE DATABASE dbms3;
USE dbms3;

-- 2. CREATE TABLE
SHOW TABLES;
CREATE TABLE team (
    roll_no INT(3),
    name VARCHAR(10),
    division VARCHAR(10),
    branch VARCHAR(10),
    city VARCHAR(10),
    marks INT(2)
);

DESC team;

INSERT INTO team VALUES
(1, 'Sahil',   'SE', 'Computer', 'Pune',   82),
(2, 'Sneha',   'TE', 'Computer', 'Mumbai', 76),
(3, 'Amit',	'SE', 'IT',   	'Pune',   58),
(4, 'Suman',   'BE', 'Computer', 'Pune',   91),
(5, 'Rohit',   'TE', 'ENTC', 	'Nagpur', 65),
(6, 'Sagar',   'SE', 'Computer', 'Pune',   55),
(7, 'Neha',	'BE', 'IT',   	'Mumbai', 49),
(8, 'Sunil',   'TE', 'Computer', 'Pune',   60),
(9, 'Shreya',  'SE', 'ENTC', 	'Pune',   78),
(10,'Amit',	'TE', 'Mechanical','Nashik',72);


-- 3. SELECT ALL
SELECT * FROM team;

-- 4. SELECT SPECIFIC COLUMNS
SELECT name, city FROM team;

-- 5. SELECT DISTINCT
SELECT distinct name FROM team;

-- 6. WHERE CLAUSE
SELECT name, marks FROM team WHERE marks > 75;

-- 7. LIKE OPERATOR
SELECT name FROM team WHERE name LIKE 's%';

-- 8. BETWEEN OPERATOR
SELECT name, marks FROM team WHERE marks BETWEEN 50 AND 60;

-- 9. AND OPERATOR
SELECT name, branch, city FROM team WHERE branch='Computer' AND city='Pune';

-- 10. UPDATE RECORDS
UPDATE team SET branch='IT' WHERE roll_no=9;
SELECT * FROM team;

-- 11. DELETE RECORDS
DELETE FROM team WHERE division='BE';
SELECT * FROM team;

-- 12. UNION
CREATE TABLE TE_Students (
    roll_no INT PRIMARY KEY,
    name VARCHAR(50)
);

SELECT * FROM TE_Students;

INSERT INTO TE_Students VALUES
(2, 'Sneha'),
(5, 'Rohit'),
(8, 'Sunil'),
(10,'Amit'),
(11,'Kunal'),
(12,'Pooja'),
(13,'Rahul'),
(14,'Siddhi'),
(15,'Akash'),
(16,'Neeta');
    
SELECT roll_no FROM team UNION SELECT roll_no FROM TE_Students;