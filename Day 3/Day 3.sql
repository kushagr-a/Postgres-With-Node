
-- Create our base table
CREATE TABLE movies (
    movie_id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    release_year INTEGER
);

-- Just Check --
SELECT * FROM movies

-- Adding Columms in Movies Table --
-- Add a new column
ALTER TABLE movies
ADD COLUMN director VARCHAR(100);

-- Add multiple columns at once
ALTER TABLE movies
ADD COLUMN budget DECIMAL(12, 2),
ADD COLUMN box_office DECIMAL(12, 2);

-- Add column with default value
ALTER TABLE movies
ADD COLUMN rating VARCHAR(10) DEFAULT 'PG-13';

-- Add column with NOT NULL constraint (must provide default or populate existing rows)
ALTER TABLE movies
ADD COLUMN duration_minutes INTEGER NOT NULL DEFAULT 120;

--------------------------------------Dropping columns ---------------------
-- Just Check --
SELECT * FROM movies

-- Drop single table --
ALTER TABLE movies
DROP COLUMN rating;

-- Drop multiple columns --
ALTER TABLE movies
DROP COLUMN box_office,
DROP COLUMN duration_minutes;

-- Drop column with CASCADE (removes dependent objects) --
-- Parent -to> Child relations -- 
ALTER TABLE movies
DROP COLUMN director CASCADE;

--------------------------------------------------- Renaming -----------------------------------------------------------
-- Rename a column --
ALTER TABLE movies
RENAME COLUMN release_year TO year_released;

-- Rename multiple times to fix naming --
-- PostgreSQL allows only one column rename per ALTER TABLE statement --
ALTER TABLE movies
RENAME COLUMN title TO movie_title;

ALTER TABLE movies
RENAME COLUMN movie_title TO film_title;




-- Start with basic table
CREATE TABLE streaming_users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50)
);

SELECT * FROM streaming_users

-- Expand table structure --
ALTER TABLE streaming_users
ADD COLUMN email VARCHAR(100),
ADD COLUMN signup_date DATE DEFAULT CURRENT_DATE,
ADD COLUMN subscription_type VARCHAR(50) DEFAULT 'Free';

-- Make email required --
ALTER TABLE streaming_users
ALTER COLUMN email SET NOT NULL;

-- Add payment information

ALTER TABLE streaming_users
ADD COLUMN payment_method VARCHAR(50),
ADD COLUMN last_payment_date VARCHAR (50);

-- Rename for clarity
ALTER TABLE streaming_users
RENAME COLUMN subscription_type TO plan_type;

-- Drop unnecessary column
ALTER TABLE streaming_users
DROP COLUMN payment_method;

-- Change data type for optimization
ALTER TABLE streaming_users
ALTER COLUMN username TYPE VARCHAR(30);

-- CASE expressions allow conditional logic in SQL queries - like if/else statements.

-- Create sample data
CREATE TABLE viewer_activity (
    activity_id SERIAL PRIMARY KEY,
    user_id INTEGER,
    movie_id INTEGER,
    watch_percentage INTEGER,
    watched_date DATE
);

INSERT INTO viewer_activity (user_id, movie_id, watch_percentage, watched_date) VALUES
(1, 101, 100, '2025-01-01'),
(2, 102, 45, '2025-01-02'),
(3, 103, 75, '2025-01-02'),
(4, 104, 20, '2025-01-03'),
(5, 105, 90, '2025-01-03');

SELECT * FROM viewer_activity

-- Simple CASE: categorize viewing behavior
SELECT 
 activity_id,
 user_id,
 watch_percentage,
 CASE
   WHEN watch_percentage >= 90 THEN 'Completed'
   WHEN watch_percentage >= 50 THEN 'Partial'
   WHEN watch_percentage >= 20 THEN 'Started'
  END AS viewer_status
FROM viewer_activity




------------------ Create movies table with ratings
CREATE TABLE platform_movies (
    movie_id SERIAL PRIMARY KEY,
    title VARCHAR(200),
    genre VARCHAR(50),
    rating DECIMAL(3, 1),
    release_year INTEGER,
    content_rating VARCHAR(10)
);

INSERT INTO platform_movies (title, genre, rating, release_year, content_rating) VALUES
('Stellar Voyage', 'Sci-Fi', 8.7, 2023, 'PG-13'),
('Dark Alley', 'Thriller', 7.2, 2022, 'R'),
('Laugh Factory', 'Comedy', 6.5, 2024, 'PG'),
('Epic Quest', 'Fantasy', 9.1, 2023, 'PG-13'),
('True Crime Story', 'Documentary', 8.0, 2024, 'R');

SELECT * FROM platform_movies

-- Complex CASE with multiple conditions
SELECT 
  title,
  rating,
  content_rating,
  CASE
     WHEN rating >= 9.0 THEN 'Must watch'
	 WHEN rating >= 8.0 AND content_rating IN ('PG', 'PG-13') THEN 'Family Friendly Hit'
	 WHEN rating >= 7.0 THEN 'Worth Watching'
	 WHEN rating >= 6.0 THEN 'Average'
	 ELSE 'Skip'
   END AS recommendation,
   CASE 
     WHEN release_year >= 2024 THEN 'New Release'
	 WHEN release_year >= 2022 THEN 'Recent'
	 ELSE 'Catalog'
	END AS recently
FROM platform_movies

-- CASE in WHERE Clause--
-- Find movies based on conditional criteria
SELECT title,
genre,
rating FROM platform_movies
WHERE 
   CASE 
      WHEN genre = 'Documentry' THEN rating >= 7.5
	  WHEN genre = 'Comedy' THEN rating >= 6.5
	  ELSE rating >= 8.0
	END;
 



















































































