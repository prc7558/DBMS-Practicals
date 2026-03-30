-- 1. CREATE DATABASE
SHOW DATABASES;
CREATE DATABASE dbms4;
USE dbms4;

-- 2. CREATE TABLES
SHOW TABLES;

CREATE TABLE Customers (
    ID INT PRIMARY KEY,
    name VARCHAR(15),
    age INT,
    address VARCHAR(15),
    salary INT
);

CREATE TABLE Orders (
    O_Id INT,
    O_date DATE,
    Cust_Id INT,
    amount INT
);

SHOW TABLES;

DESC Customers;
DESC Orders;

INSERT INTO Customers (ID, name, age, address, salary) VALUES
(1, 'Alice', 25, 'New York', 22000),
(2, 'Bob', 30, 'Los Angeles', 18000),
(3, 'Charlie', 22, 'Chicago', 25000),
(4, 'David', 28, 'Houston', 21000),
(5, 'Eve', 24, 'Miami', 19000);

INSERT INTO Orders (O_Id, O_date, Cust_Id, amount) VALUES
(101, '2025-01-15', 1, 500),
(102, '2025-02-10', 2, 750),
(103, '2025-03-20', 1, 300),
(104, '2025-04-05', 4, 1200),
(105, '2025-05-12', 5, 450);

SELECT * FROM Customers;
SELECT * FROM Orders;

-- 3. INNER JOIN
SELECT c.ID, c.name, o.amount, o.O_date
FROM Customers c
INNER JOIN Orders o
ON c.ID = o.Cust_Id;

-- 4. LEFT JOIN
SELECT c.ID, c.name, o.amount, o.O_date
FROM Customers c
LEFT JOIN Orders o
ON c.ID = o.Cust_Id;

-- 5. RIGHT JOIN
SELECT c.ID, c.name, o.amount, o.O_date
FROM Customers c
RIGHT JOIN Orders o
ON c.ID = o.Cust_Id;

-- 6. FULL JOIN (USING UNION)
SELECT c.ID, c.name, o.amount, o.O_date
FROM Customers c
LEFT JOIN Orders o ON c.ID = o.Cust_Id
UNION ALL
SELECT c.ID, c.name, o.amount, o.O_date
FROM Customers c
RIGHT JOIN Orders o ON c.ID = o.Cust_Id;

-- 7. SELF JOIN
SELECT A.name, B.name, A.address
FROM Customers A, Customers B
WHERE A.address = B.address;

-- 8. CROSS JOIN
SELECT c.ID, c.name, o.amount, o.O_date
FROM Customers c
CROSS JOIN Orders o;

-- 9. NATURAL JOIN
SELECT c.ID, c.name, o.amount, o.O_date
FROM Customers c
NATURAL JOIN Orders o;

-- 10. SELECT WITH SUBQUERY
SELECT *
FROM Customers
WHERE ID IN (
    SELECT ID
    FROM Customers
    WHERE salary > 20000
);

-- 11. CREATE BACKUP TABLE
CREATE TABLE cust_bkp AS
SELECT *
FROM Customers;

SELECT * FROM cust_bkp;

-- 12. UPDATE WITH SUBQUERY
UPDATE Customers
SET salary = salary * 1.1
WHERE age >= 24
AND ID IN (
    SELECT ID FROM cust_bkp
);

-- 13. DELETE WITH SUBQUERY
DELETE FROM Customers
WHERE ID IN (
    SELECT ID
    FROM cust_bkp
    WHERE age > 26
);

SELECT * FROM Customers;