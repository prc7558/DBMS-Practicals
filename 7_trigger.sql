-- 1. CREATE DATABASE
SHOW DATABASES;
CREATE DATABASE dbms7;
USE dbms7;

-- 2. CREATE TABLES
SHOW TABLES;

CREATE TABLE Library (
    Book_Id INT,
    Book_name VARCHAR(50),
    Author VARCHAR(50),
    Price INT,
    Quantity INT
);

DESC Library;

CREATE TABLE Library_Audit (
    Lib_ID INT PRIMARY KEY AUTO_INCREMENT,
    Book_Id INT,
    Book_name VARCHAR(50),
    Author VARCHAR(50),
    Price INT,
    Quantity INT,
    Operation_Type VARCHAR(50),
    Operation_Time DATETIME
);

DESC Library_Audit;

INSERT INTO Library VALUES
(201, 'Java: The Complete Reference', 'Herbert Schildt', 850, 15),
(202, 'Database System Concepts', 'Abraham Silberschatz', 750, 10),
(203, 'Software Engineering: A Practitioner''s Approach', 'Roger S. Pressman', 900, 8),
(204, 'Operating System Concepts', 'Abraham Silberschatz', 650, 12),
(205, 'Data Structures and Algorithms in C++', 'Adam Drozdek', 926, 20),
(206, 'Object-Oriented Programming with C++', 'E. Balagurusamy', 450, 25);

SELECT * FROM Library;


-- 3. BEFORE UPDATE TRIGGER
DELIMITER ##

CREATE TRIGGER before_library_update
BEFORE UPDATE
ON Library
FOR EACH ROW
BEGIN
    INSERT INTO Library_Audit
    (Book_Id, Book_name, Author, Price, Quantity, Operation_Type, Operation_Time)
    VALUES
    (OLD.Book_Id, OLD.Book_name, OLD.Author, OLD.Price, OLD.Quantity,
     'before_update', NOW());
END ##

DELIMITER ;

-- 4. AFTER UPDATE TRIGGER
DELIMITER $$

CREATE TRIGGER after_library_update
AFTER UPDATE
ON Library
FOR EACH ROW
BEGIN
    INSERT INTO Library_Audit
    (Book_Id, Book_name, Author, Price, Quantity, Operation_Type, Operation_Time)
    VALUES
    (NEW.Book_Id, NEW.Book_name, NEW.Author, NEW.Price, NEW.Quantity,
     'after_update', NOW());
END $$

DELIMITER ;

-- 5. BEFORE DELETE TRIGGER
DELIMITER ##

CREATE TRIGGER before_library_delete
BEFORE DELETE
ON Library
FOR EACH ROW
BEGIN
    INSERT INTO Library_Audit
    (Book_Id, Book_name, Author, Price, Quantity, Operation_Type, Operation_Time)
    VALUES
    (OLD.Book_Id, OLD.Book_name, OLD.Author, OLD.Price, OLD.Quantity,
     'before_delete', NOW());
END ##

DELIMITER ;

-- 6. AFTER DELETE TRIGGER
DELIMITER ##

CREATE TRIGGER after_library_delete
AFTER DELETE
ON Library
FOR EACH ROW
BEGIN
    INSERT INTO Library_Audit
    (Book_Id, Book_name, Author, Price, Quantity, Operation_Type, Operation_Time)
    VALUES
    (OLD.Book_Id, OLD.Book_name, OLD.Author, OLD.Price, OLD.Quantity,
     'after_delete', NOW());
END ##

DELIMITER ;

-- 7. TESTING TRIGGERS
UPDATE Library SET Price = 300 WHERE Book_Id = 201;
UPDATE Library SET Price = 275 WHERE Book_Id = 202;

DELETE FROM Library WHERE Book_Id = 203;

UPDATE Library SET Price = 800 WHERE Book_Id = 205;

DELETE FROM Library WHERE Book_Id = 206;

SELECT * FROM Library;
SELECT * FROM Library_Audit;

SHOW TRIGGERS;