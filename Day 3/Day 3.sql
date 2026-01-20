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
ALTER TABLE movies ADD COLUMN director VARCHAR(100);

-- Add multiple columns at once
ALTER TABLE movies
ADD COLUMN budget DECIMAL(12, 2),
ADD COLUMN box_office DECIMAL(12, 2);

-- Add column with default value
ALTER TABLE movies ADD COLUMN rating VARCHAR(10) DEFAULT 'PG-13';

-- Add column with NOT NULL constraint (must provide default or populate existing rows)
ALTER TABLE movies
ADD COLUMN duration_minutes INTEGER NOT NULL DEFAULT 120;

--------------------------------------Dropping columns ---------------------
-- Just Check --
SELECT * FROM movies

-- Drop single table --
ALTER TABLE movies DROP COLUMN rating;

-- Drop multiple columns --
ALTER TABLE movies
DROP COLUMN box_office,
DROP COLUMN duration_minutes;

-- Drop column with CASCADE (removes dependent objects) --
-- Parent -to> Child relations --
ALTER TABLE movies DROP COLUMN director CASCADE;

--------------------------------------------------- Renaming -----------------------------------------------------------
-- Rename a column --
ALTER TABLE movies RENAME COLUMN release_year TO year_released;

-- Rename multiple times to fix naming --
-- PostgreSQL allows only one column rename per ALTER TABLE statement --
ALTER TABLE movies RENAME COLUMN title TO movie_title;

ALTER TABLE movies RENAME COLUMN movie_title TO film_title;

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
ALTER TABLE streaming_users ALTER COLUMN email SET NOT NULL;

-- Add payment information

ALTER TABLE streaming_users
ADD COLUMN payment_method VARCHAR(50),
ADD COLUMN last_payment_date VARCHAR(50);

-- Rename for clarity
ALTER TABLE streaming_users
RENAME COLUMN subscription_type TO plan_type;

-- Drop unnecessary column
ALTER TABLE streaming_users DROP COLUMN payment_method;

-- Change data type for optimization
ALTER TABLE streaming_users ALTER COLUMN username TYPE VARCHAR(30);

-- CASE expressions allow conditional logic in SQL queries - like if/else statements.

-- Create sample data
CREATE TABLE viewer_activity (
    activity_id SERIAL PRIMARY KEY,
    user_id INTEGER,
    movie_id INTEGER,
    watch_percentage INTEGER,
    watched_date DATE
);

INSERT INTO
    viewer_activity (
        user_id,
        movie_id,
        watch_percentage,
        watched_date
    )
VALUES (1, 101, 100, '2025-01-01'),
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

INSERT INTO
    platform_movies (
        title,
        genre,
        rating,
        release_year,
        content_rating
    )
VALUES (
        'Stellar Voyage',
        'Sci-Fi',
        8.7,
        2023,
        'PG-13'
    ),
    (
        'Dark Alley',
        'Thriller',
        7.2,
        2022,
        'R'
    ),
    (
        'Laugh Factory',
        'Comedy',
        6.5,
        2024,
        'PG'
    ),
    (
        'Epic Quest',
        'Fantasy',
        9.1,
        2023,
        'PG-13'
    ),
    (
        'True Crime Story',
        'Documentary',
        8.0,
        2024,
        'R'
    );

SELECT * FROM platform_movies

-- Complex CASE with multiple conditions
SELECT
    title,
    rating,
    content_rating,
    CASE
        WHEN rating >= 9.0 THEN 'Must watch'
        WHEN rating >= 8.0
        AND content_rating IN ('PG', 'PG-13') THEN 'Family Friendly Hit'
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
SELECT title, genre, rating
FROM platform_movies
WHERE
    CASE
        WHEN genre = 'Documentry' THEN rating >= 7.5
        WHEN genre = 'Comedy' THEN rating >= 6.5
        ELSE rating >= 8.0
    END;

-- RELATIONS --
-- ONE - TO - ONE --
CREATE TABLE stream_users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE user_preferences (
    preference_id SERIAL PRIMARY KEY,
    user_id INTEGER UNIQUE NOT NULL,  -- UNIQUE makes it one-to-one ye user id uper wale table se arha hai 
    theme VARCHAR(20) DEFAULT 'dark',
    autoplay BOOLEAN DEFAULT true,
    subtitle_language VARCHAR(20) DEFAULT 'English',
    FOREIGN KEY (user_id) REFERENCES stream_users(user_id) ON DELETE CASCADE -- or idhr relation bna rhe hai
);

-- Insert data
INSERT INTO stream_users (username, email) VALUES
('cinephile_jane', 'jane@email.com'),
('binge_watcher_bob', 'bob@email.com');

INSERT INTO user_preferences (user_id, theme, autoplay) VALUES
(1, 'dark', true),
(2, 'light', false);

-- EK table ki primary key as a foreign key treat ki ja rhi hai

-- View user with their preferences
SELECT * FROM stream_users;
SELECT * FROM user_preferences;


--- ONE TO MANY --
CREATE TABLE directors (
    director_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    birth_year INTEGER,
    nationality VARCHAR(50)
);

CREATE TABLE director_movies (
    movie_id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    director_id INTEGER NOT NULL,  -- No UNIQUE here, allows multiple movies per director
    release_year INTEGER,
    budget DECIMAL(12, 2),
    FOREIGN KEY (director_id) REFERENCES directors(director_id) ON DELETE RESTRICT
);

-- Insert directors
INSERT INTO directors (name, birth_year, nationality) VALUES
('Christopher Nolan', 1970, 'British-American'),
('Greta Gerwig', 1983, 'American'),
('Denis Villeneuve', 1967, 'Canadian');

-- Insert movies (multiple movies per director)
INSERT INTO director_movies (title, director_id, release_year, budget) VALUES
('Inception', 1, 2010, 160000000),
('Interstellar', 1, 2014, 165000000),
('Dunkirk', 1, 2017, 100000000),
('Lady Bird', 2, 2017, 10000000),
('Little Women', 2, 2019, 40000000),
('Arrival', 3, 2016, 47000000),
('Blade Runner 2049', 3, 2017, 150000000);

-- View all directors
SELECT * FROM directors;

-- View all movies
SELECT * FROM director_movies;

-- Count movies per director
SELECT 
    director_id,
    COUNT(*) AS movie_count
FROM director_movies
GROUP BY director_id;


--- MANY TO MANY
-- First main table
CREATE TABLE actors (
    actor_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    birth_year INTEGER,
    country VARCHAR(50)
);

-- Second main table
CREATE TABLE films (
    film_id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    release_year INTEGER,
    genre VARCHAR(50)
);

-- Junction table (bridges the many-to-many relationship)
CREATE TABLE film_cast (
    cast_id SERIAL PRIMARY KEY,
    film_id INTEGER NOT NULL,
    actor_id INTEGER NOT NULL,
    character_name VARCHAR(100),
    role_type VARCHAR(20) DEFAULT 'supporting',
    FOREIGN KEY (film_id) REFERENCES films(film_id) ON DELETE CASCADE,
    FOREIGN KEY (actor_id) REFERENCES actors(actor_id) ON DELETE CASCADE,
    UNIQUE(film_id, actor_id)  -- Prevents same actor being cast twice in same film
);

-- Insert actors
INSERT INTO actors (name, birth_year, country) VALUES
('Leonardo DiCaprio', 1974, 'USA'),
('Marion Cotillard', 1975, 'France'),
('Tom Hardy', 1977, 'UK'),
('Anne Hathaway', 1982, 'USA'),
('Matthew McConaughey', 1969, 'USA');

-- Insert films
INSERT INTO films (title, release_year, genre) VALUES
('Inception', 2010, 'Sci-Fi'),
('The Dark Knight Rises', 2012, 'Action'),
('Interstellar', 2014, 'Sci-Fi'),
('Dunkirk', 2017, 'War');

-- Create the many-to-many relationships through the junction table
INSERT INTO film_cast (film_id, actor_id, character_name, role_type) VALUES
-- Inception has 3 actors
(1, 1, 'Dom Cobb', 'lead'),
(1, 2, 'Mal Cobb', 'supporting'),
(1, 3, 'Eames', 'supporting'),
-- The Dark Knight Rises has 2 actors
(2, 3, 'Bane', 'lead'),
(2, 4, 'Catwoman', 'lead'),
-- Interstellar has 2 actors
(3, 4, 'Brand', 'supporting'),
(3, 5, 'Cooper', 'lead'),
-- Dunkirk has 1 actor
(4, 3, 'Farrier', 'supporting');

-- View all actors
SELECT * FROM actors;

-- View all films
SELECT * FROM films;

-- View all casting relationships
SELECT * FROM film_cast;

-- Find how many films each actor has
SELECT 
    actor_id,
    COUNT(*) AS film_count
FROM film_cast
GROUP BY actor_id
ORDER BY film_count DESC;

-- Find how many actors each film has
SELECT 
    film_id,
    COUNT(*) AS actor_count
FROM film_cast
GROUP BY film_id
ORDER BY actor_count DESC;

--------------- Use of Primary  Keys  ---------------
-- Single column primary key (most common)
CREATE TABLE streaming_platforms (
    platform_id SERIAL PRIMARY KEY,  -- Auto-incrementing primary key
    platform_name VARCHAR(50) NOT NULL,
    founded_year INTEGER
);

INSERT INTO streaming_platforms (platform_name, founded_year) VALUES
('StreamFlix', 2010),
('WatchNow', 2015),
('VideoHub', 2018);

SELECT * FROM streaming_platforms;

-- Composite primary key (multiple columns together form the key)
CREATE TABLE subscription_history (
    user_id INTEGER,
    plan_change_date DATE,
    new_plan VARCHAR(30),
    PRIMARY KEY (user_id, plan_change_date)  -- Both columns together are unique
);

INSERT INTO subscription_history VALUES
(1, '2024-01-15', 'Basic'),
(1, '2024-06-20', 'Premium'),  -- Same user, different date (allowed)
(2, '2024-01-15', 'Standard'); -- Different user, same date (allowed)
-- (1, '2024-01-15', 'Pro') would fail - duplicate composite key

SELECT * FROM subscription_history;

-- Adding primary key to existing table
CREATE TABLE content_ratings (
    rating_code VARCHAR(10),
    description TEXT
);

-- Add primary key constraint after table creation
ALTER TABLE content_ratings
ADD PRIMARY KEY (rating_code);

INSERT INTO content_ratings VALUES
('G', 'General Audiences'),
('PG', 'Parental Guidance'),
('PG-13', 'Parents Strongly Cautioned'),
('R', 'Restricted');

SELECT * FROM content_ratings;













