CREATE TABLE courses (
    id SERIAL PRIMARY KEY,
    student_name VARCHAR(50),
    email VARCHAR(50),
    course_name VARCHAR(50),
    price NUMERIC(8,2),
    rating INT,
    level VARCHAR(20) CHECK (level IN ('Beginner','Intermediate','Advanced')),
    completion_status BOOLEAN,
    skills TEXT[],
    course_meta JSONB,
    enrolled_on TIMESTAMP
);

INSERT INTO courses (
    student_name,
    email,
    course_name,
    price,
    rating,
    level,
    completion_status,
    skills,
    course_meta,
    enrolled_on
) VALUES
(
    'Tushar Nag',
    'toshu@gmail.com',
    'Python Devloper',
    21999.00,
    3,
    'Beginner',
    true,
    ARRAY['Python', 'AI', 'ML', 'Django'],
    '{"duration":"10 months","platform":"Udemy","certificate":true}',
    '2025-01-05 10:30:00'
),
(
    'Kushagra Bharti',
    'kushagra@gmail.com',
    'Full Stack Web Development',
    14999.00,
    5,
    'Beginner',
    true,
    ARRAY['HTML', 'CSS', 'JavaScript', 'Node.js'],
    '{"duration":"6 months","platform":"Udemy","certificate":true}',
    '2025-01-05 10:30:00'
),
(
    'Rishabh Maheshwari',
    'rishabh@gmail.com',
    'Data Structures & Algorithms',
    9999.50,
    4,
    'Intermediate',
    false,
    ARRAY['C++', 'Arrays', 'Linked List', 'Trees'],
    '{"duration":"4 months","platform":"Coding Ninjas","certificate":false}',
    '2025-01-10 14:15:00'
),
(
    'Harsh Ranjan',
    'harsh@gmail.com',
    'Machine Learning',
    19999.99,
    5,
    'Advanced',
    true,
    ARRAY['Python', 'NumPy', 'Pandas', 'Scikit-learn'],
    '{"duration":"8 months","platform":"Coursera","projects":5}',
    '2024-12-20 09:00:00'
);

SELECT * FROM courses

-------------------------------------- BASIC ---------------------------------

-- Q1 --
SELECT student_name, course_name FROM courses

-- Q2 --
SELECT * FROM courses WHERE level = 'Beginner'

-- Q3 --
SELECT * FROM courses WHERE price > 9999.51

-- Q4 --
SELECT DISTINCT course_name FROM courses

-- Q5 --
SELECT * FROM courses ORDER BY price DESC LIMIT 5;

----------------------------------- Now Intermidiate Ques ---------------------------------------
-- Q6 --
SELECT * FROM courses WHERE rating IN (3, 4);

-- Q7 --
SELECT * FROM courses WHERE price BETWEEN 9000 AND 15000;

-- Q8 --
SELECT * FROM courses WHERE student_name LIKE 'T%';

-- Q9 --
SELECT * FROM courses WHERE completion_status = 'True';

-- Q10 --
SELECT * FROM courses WHERE 'JavaScript' = ANY (skills);

--------------------- Advance --------------
-- Q11 --
SELECT SUM(price) AS Total_revenue FROM courses;

-- Q12 --
SELECT AVG(price) As Every_Level FROM courses GROUP BY level;

-- Q13 --
SELECT * FROM courses WHERE course_meta ->> 'duration' = '10 months'

-- Q14 --
SELECT * FROM courses WHERE array_length (skills, 1) >= 4;

-- Q15 --
SELECT completion_status, COUNT(*)
FROM courses
GROUP BY
    completion_status;