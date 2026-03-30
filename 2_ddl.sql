-- 1. CREATE DATABASE
SHOW DATABASES;
CREATE DATABASE dbms2;
USE dbms2;

-- 2. CREATE TABLE
SHOW TABLES;

CREATE TABLE Customers (
    cust_id INT NOT NULL AUTO_INCREMENT,
    cust_name VARCHAR(50),
    product VARCHAR(50),
    quantity INT,
    total_price DECIMAL(10,2),
    PRIMARY KEY (cust_id)
);

SHOW TABLES;
DESC Customers;

SELECT * FROM Customers;

INSERT INTO Customers
(cust_name, product, quantity, total_price)
VALUES
('Alice', 'Laptop', 2, 2000.00),
('Bob', 'Phone', 3, 1500.00),
('Charlie', 'Tablet', 1, 500.00),
('Diana', 'Monitor', 2, 400.00),
('Ethan', 'Keyboard', 5, 250.00);

SELECT * FROM Customers;

-- 3. ALTER TABLE
ALTER TABLE Customers
ADD COLUMN price_per_qnty DECIMAL(10,2);

DESC Customers;

-- 4. CREATE VIEW
SHOW FULL TABLES WHERE Table_type = 'VIEW';

CREATE VIEW Cust_View AS
SELECT cust_id, cust_name
FROM Customers;

SHOW FULL TABLES WHERE Table_type = 'VIEW';

SELECT * FROM Cust_View;

-- 5. UPDATE VIEW
CREATE OR REPLACE VIEW Cust_View AS
SELECT cust_id, product, total_price
FROM Customers;

SELECT * FROM Cust_View;

-- 6. DROP VIEW
DROP VIEW Cust_View;
SHOW FULL TABLES WHERE Table_type = 'VIEW';

-- 7. CREATE INDEX
SHOW INDEX FROM Customers;
CREATE INDEX Cust_index ON Customers (cust_name);
SHOW INDEX FROM Customers;

-- 8. DROP INDEX
DROP INDEX Cust_index ON Customers;
SHOW INDEX FROM Customers;

-- 9. RENAME TABLE & USE ALIAS
SELECT * FROM Customers AS C;
SHOW TABLES;
RENAME TABLE Customers TO Customers_New;
SHOW TABLES;
SELECT * FROM Customers_New AS C;

-- 10. TRUNCATE TABLE
TRUNCATE TABLE Customers_New;
SELECT * FROM Customers_New;
SHOW TABLES;

-- 11. DROP TABLE
DROP TABLE Customers_New;
SHOW TABLES;