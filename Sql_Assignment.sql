create database MarketCoDB;

use MarketCoDB;

drop table if exists ContactEmployee;
drop table if exists Employee;
drop table if exists Contact;
drop table if exists Company;

create table Company (
  CompanyID int primary key auto_increment,
  CompanyName varchar(45),
  Street varchar(45),
  City varchar(45),
  State varchar(2),
  zip varchar(10)
);

INSERT INTO Company 
(CompanyName, Street, City, State, Zip)
VALUES
("Urban Outfitters, Inc.", 'Business Park', 'Mumbai', 'MH', '400001'),
('Toll Brothers', 'Market Street', 'Philadelphia', 'PA', '19103');

select * from Company;

-- 1) Statement to create the Contact table

create table Contact (
   ContactID int primary key auto_increment,
   CompanyID int,
   FirstName varchar(45),
   LastName varchar(45),
   Street varchar(45),
   City varchar(45),
   State varchar(2),
   Zip varchar(10),
   IsMain Boolean,
   Email varchar(45),
   Phone varchar(12),
   foreign key (CompanyID) references Company(CompanyID)
);

INSERT INTO Contact 
(CompanyID, FirstName, LastName, Street, City, State, Zip, IsMain, Email, Phone)
VALUES
(1,'Amit', 'Shah', 'MG Road', 'Mumbai', 'MH', '400001', TRUE, 'amit@email.com', '9876543210'),
(2, 'Dianne', 'Connor', 'Market Street', 'Philadelphia', 'PA', '19103', TRUE, 'dianne@tollbrothers.com', '215-555-3344');

select * from Contact;

-- 2) Statement to create the Employee table  

create table Employee (
   EmployeeID int primary key auto_increment,
   FirstName varchar(45),
   LastName varchar(45),
   Salary decimal(10,2),
   HireDate date,
   JobTitle varchar(45),
   Email varchar(45),
   Phone varchar(12)
);

INSERT INTO Employee
(FirstName, LastName, Salary, HireDate, JobTitle, Phone)
VALUES
('Lesley', 'Bland', 52000, '2022-06-15', 'Manager', '215-555-1234');

select * from Employee;

-- 3) Statement to create the ContactEmployee table  HINT: Use DATE as the datatype for ContactDate. 
-- It allows you to store the date in this format: YYYY-MM-DD (i.e., ‘2014-03-12’ for March 12, 2014).

create table ContactEmployee (
   ContactEmployeeID int primary key auto_increment,
   ContactID int,
   EmployeeID int,
   ContactDate date,
   Description varchar(100),
   foreign key (ContactID) references Contact(ContactID),
   foreign key (EmployeeID) references Employee(EmployeeID)
);

INSERT INTO ContactEmployee
(ContactID, EmployeeID, ContactDate, Description)
VALUES
(1, 1, '2024-03-12', 'Initial Client Meeting'),
(2, 1, '2024-04-01', 'Follow-up Meeting');
  
select * from ContactEmployee;

-- 4) In the Employee table, the statement that changes Lesley Bland’s phone number to 215-555-8800  

select EmployeeID, FirstName, LastName from Employee
where FirstName = 'Lesley' and LastName = 'Bland';

update Employee
set Phone = '215-555-8800'
where EmployeeID = 1;

select * from Employee;

-- 5) In the Company table, the statement that changes the name of “Urban Outfitters, Inc.” to “Urban Outfitters” .

update Company
set CompanyName = 'Urban Outfitters'
where CompanyID = 1;

select * from Company;

-- 6)  In ContactEmployee table, the statement that removes Dianne Connor’s contact event with Jack Lee (one statement). 
-- HINT: Use the primary key of the ContactEmployee table to specify the correct record to remove. 

delete from ContactEmployee
where ContactEmployeeID = 2;

select * from ContactEmployee;

-- 8) What is the significance of “%” and “_” operators in the LIKE statement? 
-- ANS):-
-- The LIKE operator in SQL is used for pattern matching in WHERE clauses.
-- The symbols % and _ are wildcards that help match partial values.

-- 🔹 % (Percent Sign)
-- Represents zero, one, or many characters
-- Used when the number of characters is unknown or variable

select * from Company
where CompanyName like "Urb%";

-- ✔ Correct Matches :- Urban Outfitters, Urban Outfitters, Inc.
-- ❌ Does NOT Match :- Toll Brothers, Best Toll

-- 🔹 _ (Underscore)
-- Represents exactly one character
-- Used when the position is fixed but one character can vary

select * from Employee
where FirstName like 'L_sley';

-- ✔ Matches :- Lesley
-- ❌ Does NOT Match :- Laisley (extra character),Lisley (extra character),Lsley (missing character)

-- Note :-
-- % matches any number of characters
-- _ matches exactly one character

-- 9) Explain normalization in the context of databases. 
-- ANS):-
-- -- Normalization is the process of organizing database tables to remove duplicate data 
-- and keep data accurate and consistent.
--
-- 1NF (First Normal Form): Each column has single (atomic) values and each row is unique.
--
-- 2NF (Second Normal Form): Table is in 1NF and all non-key columns depend on the whole primary key.
--
-- 3NF (Third Normal Form): Table is in 2NF and non-key columns do not depend on other non-key columns.
--
-- Example:
-- Unnormalized Table:
-- EmployeeID | EmployeeName | DeptName | DeptLocation
-- 1          | Alice        | HR       | New York
-- 2          | Bob          | HR       | New York
--
-- Problem: DeptName and DeptLocation are repeated for many employees.
--
-- Normalized Tables:
-- Employee Table:
-- EmployeeID | EmployeeName | DeptID
-- 1          | Alice        | 101
-- 2          | Bob          | 101
--
-- Department Table: 
-- DeptID    | DeptName | DeptLocation
-- 101       | HR       | New York
--
-- Benefits: No duplicate data, easier updates, saves space, and keeps data consistent.

-- 10) What does a join in MySQL mean?  
-- ANS):-
-- A JOIN in MySQL is used to combine rows from two or more tables based on a related column between them.

-- Types of JOINs:
-- 1. INNER JOIN: Returns only the rows that have matching values in both tables.
-- 2. LEFT JOIN (or LEFT OUTER JOIN): Returns all rows from the left table, and matched rows from the right table. 
--    If there is no match, NULL is shown for the right table.
-- 3. RIGHT JOIN (or RIGHT OUTER JOIN): Returns all rows from the right table, and matched rows from the left table.
--    If there is no match, NULL is shown for the left table.
-- 4. FULL OUTER JOIN: Returns all rows when there is a match in one of the tables. (Not directly supported in MySQL)

-- Example:
-- Employee Table: EmployeeID | EmployeeName | DeptID
-- Department Table: DeptID | DeptName
-- Query: SELECT EmployeeName, DeptName
--        FROM Employee
--        INNER JOIN Department ON Employee.DeptID = Department.DeptID;
-- Result: Shows employee names with their department names only if DeptID matches in both tables.

-- 11) What do you understand about DDL, DCL, and DML in MySQL? 
-- ANS):-
-- In MySQL, SQL commands are divided into three main categories:
--
-- 1. DDL (Data Definition Language):
--    - Used to define and manage database structures (tables, schemas, indexes).
--    - Examples: CREATE, ALTER, DROP, TRUNCATE
--    - Example: CREATE TABLE Employee (EmployeeID INT, Name VARCHAR(50));
--
-- 2. DML (Data Manipulation Language):
--    - Used to manage and manipulate data inside tables.
--    - Examples: INSERT, UPDATE, DELETE, SELECT
--    - Example: INSERT INTO Employee (EmployeeID, Name) VALUES (1, 'Alice');
--
-- 3. DCL (Data Control Language):
--    - Used to control access and permissions to the database.
--    - Examples: GRANT, REVOKE
--    - Example: GRANT SELECT, INSERT ON Employee TO 'user1'@'localhost';

-- 12) What is the role of the MySQL JOIN clause in a query, and what are some common types of joins? 
-- ANS):-
-- The JOIN clause in MySQL is used to combine rows from two or more tables based on a related column.
-- It helps retrieve meaningful data from multiple tables in a single query.
--
-- Common types of joins:
-- 1. INNER JOIN: Returns only rows with matching values in both tables.
-- 2. LEFT JOIN (LEFT OUTER JOIN): Returns all rows from the left table, and matched rows from the right table. NULL if no match.
-- 3. RIGHT JOIN (RIGHT OUTER JOIN): Returns all rows from the right table, and matched rows from the left table. NULL if no match.
-- 4. FULL OUTER JOIN: Returns all rows from both tables, with NULLs for unmatched rows (not directly supported in MySQL).
--
-- Example:
-- SELECT EmployeeName, DeptName
-- FROM Employee
-- INNER JOIN Department ON Employee.DeptID = Department.DeptID;
-- This shows employee names along with their department names where DeptID matches.
