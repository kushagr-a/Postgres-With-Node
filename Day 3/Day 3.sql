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































