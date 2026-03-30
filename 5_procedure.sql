-- 1. CREATE PROCEDURE
SHOW DATABASES;
CREATE DATABASE dbms5;
USE dbms5;

-- 2. CREATE TABLES
SHOW TABLES;

CREATE TABLE Stud_Marks (
    name VARCHAR(15),
    total_marks INT(4)
);

DESC Stud_Marks;

INSERT INTO Stud_Marks(name, total_marks) VALUES
('Rajkumar', 1294),
('Parth', 1500),
('Isha', 1365),
('Anurag', 962),
('Rohan', 100),
('Soham', 852),
('Tanvi', 44);

SELECT * FROM Stud_Marks;

CREATE TABLE Result (
    Roll_no INT(3),
    Name VARCHAR(15),
    Grade VARCHAR(35)
);

DESC Result;


-- 3. CREATE FUNCTION (GRADE CALCULATION)
DELIMITER ||

CREATE FUNCTION grade_calc(P INT)
RETURNS TEXT
DETERMINISTIC
BEGIN
    DECLARE g VARCHAR(35);

    IF P BETWEEN 990 AND 1500 THEN
        SET g = 'DISTINCTION';
    ELSEIF P BETWEEN 900 AND 989 THEN
        SET g = 'FIRST CLASS';
    ELSEIF P BETWEEN 825 AND 899 THEN
        SET g = 'HIGHER SECONDARY CLASS';
    ELSEIF P BETWEEN 700 AND 824 THEN
        SET g = 'LOWER SECONDARY CLASS';
    ELSE
        SET g = 'FAIL';
    END IF;

    RETURN g;
END ||

DELIMITER ;

-- 4. CREATE PROCEDURE (USING CURSOR)
DELIMITER @@

CREATE PROCEDURE grade_proc()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE nm VARCHAR(20);
    DECLARE total INT;

    DECLARE curr_grade CURSOR FOR
        SELECT name, total_marks FROM Stud_Marks;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN curr_grade;

    get_grade: LOOP
        FETCH curr_grade INTO nm, total;

        IF done THEN
            LEAVE get_grade;
        END IF;

        INSERT INTO Result (Name, Grade)
        VALUES (nm, grade_calc(total));

    END LOOP;

    CLOSE curr_grade;
END @@

DELIMITER ;

CALL grade_proc();

SELECT * FROM Result;


-- 5. IF-ELSE PROCEDURE
DELIMITER $$

CREATE PROCEDURE check_grade(IN marks INT)
BEGIN
    IF marks >= 90 THEN
        SELECT 'Grade: A' AS Result;
    ELSEIF marks >= 75 THEN
        SELECT 'Grade: B' AS Result;
    ELSE
        SELECT 'Grade: C' AS Result;
    END IF;
END $$

DELIMITER ;

CALL check_grade(80);

-- 6. CASE PROCEDURE
DELIMITER ??

CREATE PROCEDURE day_message(IN day_name VARCHAR(10))
BEGIN
    CASE
        WHEN day_name = 'Monday' THEN SELECT 'Start of the week' AS Message;
        WHEN day_name = 'Friday' THEN SELECT 'End of the week' AS Message;
        ELSE SELECT 'Midweek' AS Message;
    END CASE;
END ??

DELIMITER ;

CALL day_message('Friday');

-- 7. WHILE LOOP PROCEDURE
DELIMITER ||

CREATE PROCEDURE count_to_five()
BEGIN
    DECLARE i INT DEFAULT 1;

    WHILE i <= 5 DO
        SELECT CONCAT('Counter: ', i) AS Output;
        SET i = i + 1;
    END WHILE;
END ||

DELIMITER ;

CALL count_to_five();

-- 8. REPEAT-UNTIL PROCEDURE
DELIMITER @@

CREATE PROCEDURE repeat_loop()
BEGIN
    DECLARE i INT DEFAULT 1;

    REPEAT
        SELECT CONCAT('Number: ', i) AS Output;
        SET i = i + 1;
    UNTIL i > 5
    END REPEAT;
END @@

DELIMITER ;

CALL repeat_loop();

-- 9. LOOP WITH LABEL (LEAVE) PROCEDURE
DELIMITER //

CREATE PROCEDURE labeled_loop()
BEGIN
    DECLARE i INT DEFAULT 1;

    simple_loop: LOOP
        SELECT CONCAT('Loop value: ', i) AS Value;
        SET i = i + 1;

        IF i > 5 THEN
            LEAVE simple_loop;
        END IF;
    END LOOP simple_loop;
END //

DELIMITER ;

CALL labeled_loop();

-- 10. EXCEPTION HANDLING PROCEDURE (GENERAL SQL ERROR)
DELIMITER ##

CREATE PROCEDURE general_error_demo()
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'A general SQL error occured!' AS Message;
    END;

    INSERT INTO unknown_table VALUES (1);
END ##

DELIMITER ;

CALL general_error_demo();

-- 11. EXCEPTION HANDLING PROCEDURE (DIVISION BY ZERO)
DELIMITER @@

CREATE PROCEDURE divide_demo()
BEGIN
    DECLARE result INT;

    BEGIN
        SELECT 'Division by zero error!' AS Message;
        SET result = 10/0;
    END;
END @@

DELIMITER ;

CALL divide_demo();

-- 12. DUPLICATE ENTRY HANDLING PROCEDURE
CREATE TABLE student (
    roll_no INT PRIMARY KEY,
    name VARCHAR(50)
);

INSERT INTO student VALUES (1, 'Rahul');

DELIMITER $$

CREATE PROCEDURE duplicate_demo()
BEGIN
    DECLARE EXIT HANDLER FOR 1062
    BEGIN
        SELECT 'Duplicate entry found!' AS Message;
    END;

    INSERT INTO student VALUES (1, 'Amit');
END $$

DELIMITER ;

CALL duplicate_demo();