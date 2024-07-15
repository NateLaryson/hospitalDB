-- QUESTION 1

-- A. Create the database with the current records 

-- CREATE HOSPITAL DATABASE

DROP DATABASE IF EXISTS HOSPITAL;
CREATE DATABASE HOSPITAL;
USE HOSPITAL;

-- CREATE PATIENTS' TABLE

CREATE TABLE TBL_PATIENTS (
    NO INT NOT NULL AUTO_INCREMENT,
    NAME VARCHAR(55) DEFAULT NULL,
    AGE INT DEFAULT NULL,
    DEPARTMENT VARCHAR(55), 
    DATE_OF_ADM TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CHARGES DECIMAL(25, 2) DEFAULT 0,
    SEX VARCHAR(25),
    PRIMARY KEY (NO)
);

-- POPULATE PATIENTS' TABLE WITH DATA

INSERT INTO TBL_PATIENTS (NAME, AGE, DEPARTMENT, DATE_OF_ADM, SEX)
VALUES ("Mark Short", 23, "Surgery", "24/02/23", "M"),
    ("Ismael Meyer", 33, "Orthopedic", "24/02/20", "M"),
    ("Brook Cochran", 13, "Orthopedic", "24/02/21", "M"),
    ("Kylie Peck", 14, "Surgery", "24/02/28", "F"),
    ("Jayda Weiss", 12, "ENT", "24/02/23", "F"),
    ("Bria Leonard", 67, "ENT", "24/02/23", "F"),
    ("Josie Stokes", 89, "Cardiology", "24/02/01", "F"),
    ("Aliana Dean", 54, "Gynecology", "24/02/03", "F"),
    ("Finnegan Rush", 91, "Cardiology", "24/02/24", "M");


-- CREATE DOCTORS' TABLE

CREATE TABLE TBL_DOCTORS (
    NO INT NOT NULL AUTO_INCREMENT,
    NAME VARCHAR(55),
    AGE INT,
    DEPARTMENT VARCHAR(55),
    PHONE_NUMBER VARCHAR(25) DEFAULT NULL,
    SALARY DECIMAL(25, 2) DEFAULT 0,
    SEX VARCHAR(25),
    PRIMARY KEY (NO) 
);

-- POPULATE DOCTORS' TABLE WITH DATA

INSERT INTO TBL_DOCTORS (NAME, AGE, DEPARTMENT, SEX)
VALUES ("Violet Reed", 44, "Surgery", "F"),
    ("Audrey White", 33, "Orthopedic", "F"),
    ("Eli White", 28, "Orthopedic", "M"),
    ("Owen Lopez", 56, "Surgery", "M"),
    ("Roman Diaz", 35, "ENT", "M"),
    ("Angel Gomez", 52, "ENT", "F"),
    ("Adrian Perez", 36, "Cardiology", "F"),
    ("Michael Roberts", 54, "Gynecology", "M"),
    ("Ariana Clark", 25, "Cardiology", "F");

-- (B)

--      (I) Show all information about the patients of "cardiology department"

SELECT * FROM TBL_PATIENTS WHERE DEPARTMENT = "Cardiology";

--      (II) List names of all patients with thier date of admission in ascending order

SELECT NAME FROM TBL_PATIENTS ORDER BY DATE_OF_ADM;

--      (III) Display patients' Names, Charges, Ages for male patient's only

SELECT NAME, CHARGES, AGE FROM TBL_PATIENTS WHERE SEX = "M";

--      (IV) Count the number of patients with Age greator than 20

SELECT COUNT(*) FROM TBL_PATIENTS WHERE AGE > 20;

--      (V) insert three(3) new patients to the database

INSERT INTO TBL_PATIENTS (NAME, AGE, DEPARTMENT, DATE_OF_ADM, SEX)
VALUES ("Mark Brook", 23, "Surgery", "24/02/06", "M"),
    ("Beth Meyer", 33, "Orthopedic", "24/02/05", "F"),
    ("Brook Short", 13, "Orthopedic", "24/02/28", "M");

-- (C) 
--      (I) Update charges with values for each department

UPDATE TBL_PATIENTS SET CHARGES = 3500 WHERE DEPARTMENT = "Surgery";
UPDATE TBL_PATIENTS SET CHARGES = 2300 WHERE DEPARTMENT = "Orthopedic";
UPDATE TBL_PATIENTS SET CHARGES = 1500 WHERE DEPARTMENT = "ENT";
UPDATE TBL_PATIENTS SET CHARGES = 2900 WHERE DEPARTMENT = "Cardiology";
UPDATE TBL_PATIENTS SET CHARGES = 800 WHERE DEPARTMENT = "Gynecology";

--      (II) update salary where  salary is 3 times the charges of each corresponding charges

CREATE TABLE SAL AS SELECT DISTINCT A.DEPARTMENT, A.CHARGES, B.SALARY FROM TBL_PATIENTS A, TBL_DOCTORS B;
UPDATE SAL SET SALARY = CHARGES * 3;

UPDATE TBL_DOCTORS SET SALARY = (SELECT SALARY FROM SAL WHERE DEPARTMENT = "Surgery") WHERE DEPARTMENT = "Surgery";
UPDATE TBL_DOCTORS SET SALARY = (SELECT SALARY FROM SAL WHERE DEPARTMENT = "Orthopedic") WHERE DEPARTMENT = "Orthopedic";
UPDATE TBL_DOCTORS SET SALARY = (SELECT SALARY FROM SAL WHERE DEPARTMENT = "ENT") WHERE DEPARTMENT = "ENT";
UPDATE TBL_DOCTORS SET SALARY = (SELECT SALARY FROM SAL WHERE DEPARTMENT = "Cardiology") WHERE DEPARTMENT = "Cardiology";
UPDATE TBL_DOCTORS SET SALARY = (SELECT SALARY FROM SAL WHERE DEPARTMENT = "Gynecology") WHERE DEPARTMENT = "Gynecology";

-- (D)

--      (I)
--          * Add a table called Expenditure to the Hospital's database with Fields:
--                ID, EXPENSES, EXPENSE_TYPE, COST_PER_MONTH, AMOUNT_PAID, DEBT, LAST_UPDATED
--	        * EXPENSE_TYPE should have a default value "Null"
--	        * Amount Paid should have a default value 0.00
--	        * Debt should be the difference between COST_PER_MONTH and AMOUNT_PAID
--	        * LAST_UPDATED(Timestamp datatype) should have the current date and time as default value

CREATE TABLE EXPENDITURE (
    ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    EXPENSES VARCHAR(55),
    EXPENSE_TYPE VARCHAR(55) DEFAULT NULL,
    COST_PER_MONTH DECIMAL(25, 2),
    AMOUNT_PAID DECIMAL(25, 2) DEFAULT 0.00,
    DEBT DECIMAL(25, 2) AS (COST_PER_MONTH - AMOUNT_PAID),
    LAST_UPDATED TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

--      (II) Insert data into the table and find the total expenditure cost, amount paid and debt.

INSERT INTO EXPENDITURE (EXPENSES, EXPENSE_TYPE, COST_PER_MONTH, AMOUNT_PAID)
VALUES ('Electricity', 'Utility', 1200, 1000),
        ('Water', 'Utility', 800, 680),
        ('Internet', 'Other', 500, 500),
        ('Printing', 'Other', 100, 100),
        ('Misc', 'Misc', 1550, 1500);

SELECT SUM(COST_PER_MONTH) AS 'TOTAL EXPENDITURE',
     SUM(AMOUNT_PAID) AS 'AMOUNT PAID', 
     SUM(DEBT) AS 'DEBT' FROM EXPENDITURE;

-- (E) From the Doctors Table, show average, maximum and minimum salary.

SELECT SUM(SALARY) AS 'TOTAL SALARY', 
AVG(SALARY) AS 'AVERAGE SALARY',
MAX(SALARY) AS 'MAXIMUM SALARY', 
MIN(SALARY) AS 'MINIMUN'
FROM TBL_DOCTORS;

--     END OF CODE'