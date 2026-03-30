-- 1. CREATE DATABASE
SHOW DATABASES;
CREATE DATABASE dbms6;
USE dbms6;

-- 2. CREATE TABLES
SHOW TABLES;

CREATE TABLE O_RollCall (
    Roll_No INT PRIMARY KEY,
    Name VARCHAR(50),
    Subject VARCHAR(50)
);

CREATE TABLE N_RollCall (
    Roll_No INT PRIMARY KEY,
    Name VARCHAR(50),
    Subject VARCHAR(50)
);

DESC O_RollCall;
DESC N_RollCall;

INSERT INTO O_RollCall VALUES
(1, 'Amit', 'Math'),
(2, 'Neha', 'Science'),
(3, 'Raj', 'English'),
(4, 'Sneha', 'History'),
(5, 'Karan', 'Geography'),
(6, 'Pooja', 'Physics'),
(7, 'Rohit', 'Chemistry'),
(8, 'Anita', 'Biology'),
(9, 'Vikas', 'Computer'),
(10, 'Meena', 'Economics');

SELECT * FROM O_RollCall;

INSERT INTO N_RollCall VALUES
(3, 'Raj', 'English'),
(5, 'Karan', 'Geography'),
(7, 'Rohit', 'Chemistry'),
(11, 'Arjun', 'Math'),
(12, 'Divya', 'Science'),
(13, 'Sahil', 'English'),
(14, 'Kavya', 'History'),
(15, 'Manish', 'Physics'),
(16, 'Priya', 'Biology'),
(17, 'Rahul', 'Computer');

SELECT * FROM N_RollCall;


-- 3. CURSOR
DELIMITER ##

CREATE PROCEDURE Merge_RollCall (IN P_Subject VARCHAR(50))
BEGIN
    DECLARE V_Roll_No INT;
    DECLARE V_Count INT;
    DECLARE V_Name VARCHAR(50);
    DECLARE V_Subject VARCHAR(50);
    DECLARE Flag INT DEFAULT 0;

    DECLARE my_cur CURSOR FOR
        SELECT Roll_No, Name, Subject
        FROM N_RollCall
        WHERE Subject = P_Subject;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET Flag = 1;

    OPEN my_cur;

    merge_loop: LOOP
        FETCH my_cur INTO V_Roll_No, V_Name, V_Subject;

        IF Flag = 1 THEN
            LEAVE merge_loop;
        END IF;

        SELECT COUNT(*) INTO V_Count
        FROM O_RollCall
        WHERE Roll_No = V_Roll_No;

        IF V_Count = 0 THEN
            INSERT INTO O_RollCall (Roll_No, Name, Subject)
            VALUES (V_Roll_No, V_Name, V_Subject);
        END IF;

    END LOOP;

    CLOSE my_cur;
END ##

DELIMITER ;

CALL Merge_RollCall('Math');
CALL Merge_RollCall('Science');
CALL Merge_RollCall('English');
CALL Merge_RollCall('History');
CALL Merge_RollCall('Geography');
CALL Merge_RollCall('Physics');
CALL Merge_RollCall('Chemistry');
CALL Merge_RollCall('Biology');
CALL Merge_RollCall('Computer');
CALL Merge_RollCall('Economics');

SELECT * FROM O_RollCall;