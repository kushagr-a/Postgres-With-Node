

CREATE TABLE classes (
  class_id INT PRIMARY KEY,
  class_name VARCHAR(50) NOT NULL
);

CREATE TABLE students (
  student_id INT PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  class_id INT
);

INSERT INTO classes (class_id, class_name) VALUES
(101, 'JavaScript'),
(102, 'Python'),
(103, 'Java');

INSERT INTO students (student_id, name, class_id) VALUES
(1, 'Rahul', 101),
(2, 'Anjali', 102),
(3, 'Aman', 101),
(4, 'Neha', NULL);

SELECT * FROM students;
SELECT * FROM classes;

---------- JOINS ------
--------- Inner Joins -------
SELECT s.name, c.class_name
FROM students s
INNER JOIN classes c
ON s.class_id = c.class_id;

----- Left Joins ----
SELECT s.name, c.class_name
FROM students s
LEFT JOIN classes c
ON s.class_id = c.class_id;

---- Right Joins ----
SELECT s.name, c.class_name
FROM students s
RIGHT JOIN classes c
ON s.class_id = c.class_id;

--- Full outer Joins ---
SELECT s.name, c.class_name
FROM students s
FULL OUTER JOIN classes c
ON s.class_id = c.class_id;

--- Cross join -- Posible outcomes --- Cartitaon product --
SELECT s.name, c.class_name
FROM students s
CROSS JOIN classes c;




--------- Views ----------------
CREATE VIEW student_classes AS
SELECT s.name, c.class_name
FROM students s
INNER JOIN classes c
ON s.class_id = c.class_id;

SELECT * FROM student_classes;
