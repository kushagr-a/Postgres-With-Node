-- basic command for dataBase (CRUD) --
CREATE TABLE student(
id int,
fname varchar(50),
lname varchar(50),
email varchar(100),
class_name varchar(50),
marks int
)

-- insert data in table -- 
INSERT INTO student(id, fname, lname, email, class_name, marks)
VALUES
(3, 'raj', 'kumar', 'putyourEmail', 'MCA-4', 85),
(4, 'suraj', 'jha', 'putyourEmail', 'BPSC', 75);

-- Selecting data --
-- All Table --
SELECT * FROM student

-- Select some particular data from the DB
SELECT fname, class_name, marks FROM student 

-- Conditional selection --
-- WHERE === CLAUSE HAI
SELECT * FROM student WHERE class_name = 'MCA-2'

-- Update DataBase --
-- Here without condition updating all marks --
UPDATE student
SET marks = 92;

-- Updating marks with conditions --
UPDATE student
SET marks = 90
WHERE id = 3;

-- some additional query --
UPDATE student
SET marks = marks + 1
WHERE class_name = 'MCA-2'

-- delete --
DELETE from student 
WHERE id = 4;

-- Deleting with the conditions --
DELETE from student
WHERE class_name = 'MCA-2' 


